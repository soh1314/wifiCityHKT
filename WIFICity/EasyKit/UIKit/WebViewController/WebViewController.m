
#import "WebViewController.h"
#import <WebKit/WebKit.h>
#import "EaseWebViewProgressBar.h"
#import "WebLoadFaliView.h"
@interface WebViewController ()<UIWebViewDelegate,WKNavigationDelegate,WKUIDelegate>

@property(nonatomic,strong)WKWebView *webView;
@property (nonatomic,strong)UIWebView *uiwebView;
@property (nonatomic,strong) UIProgressView *progressView;
@property (nonatomic,strong)EaseWebViewProgressBar *progressBar;
@property (nonatomic,strong)WebLoadFaliView *failView;

@end

@implementation WebViewController

- (id)init {
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBlackNavBar];
    if (self.hideNavBar) {
        [self setWhiteTrasluntNavBar];
    }
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"←" style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
  
    if(!self.URLString ){
        if (self.htmlWord) {
            CGFloat navHeight = kStatusBarHeight + 44;
            UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-navHeight)];
            self.uiwebView = webView;
            webView.backgroundColor = [UIColor whiteColor];
            [self.view addSubview:webView];
//            CGFloat width = [UIScreen mainScreen].bounds.size.width-16;
//            NSString *header = [NSString stringWithFormat:@"<head><style>img{max-width:%fpx !important;}</style></head>",width];
//            NSString *html = [NSString stringWithFormat:@"%@%@",header,self.htmlWord];
            [webView loadHTMLString:self.htmlWord baseURL:nil];
            self.uiwebView.delegate = self;
        } else {
            return;
        }
        
    } else {
        CGFloat navHeight = kStatusBarHeight + 44;
        self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-navHeight)];
        self.webView.scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
         [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
        [self loadUrlRequest];
        self.webView.UIDelegate = self;
        self.webView.navigationDelegate = self;
        [self.view addSubview:self.webView];
        self.progressBar = [[EaseWebViewProgressBar alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 4) lineWidth:4];
        if (!self.progressBar.superview) {
            [self.view addSubview:self.progressBar];
            [self.progressBar setProgress:0.3];
        }
    }
}

- (void)loadUrlRequest {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.URLString]];
    [self.webView loadRequest:request];
}

- (void)modifyImageJs {
    NSString *js = @"function imgAutoFit() { \
    var imgs = document.getElementsByTagName('img'); \
    for (var i = 0; i < imgs.length; ++i) {\
    imgs[i].setAttribute('style','margin: 10px auto 0px; padding: 0px; display: block; max-width: 100%; height: auto;');   \
    } \
    }";
    [self.uiwebView stringByEvaluatingJavaScriptFromString:js];
    [self.uiwebView stringByEvaluatingJavaScriptFromString:@"imgAutoFit()"];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self modifyImageJs];
}

-(void)back:(id)sender {
    if (self.webView && [self.webView canGoBack]) {
        [self.webView goBack];
    } else {
       [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)popAction {
    if (self.webView && [self.webView canGoBack]) {
        [self.webView goBack];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.progressView removeFromSuperview];
    });
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        
        CGFloat progress = [change[NSKeyValueChangeNewKey] floatValue];
        [self.progressBar setProgress:progress];
        if (progress < 0.3) {
            [self.progressBar setProgress:0.3];
        } else {
            if(progress == 1.0)
            {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.progressBar setProgress:0];
                });
            } else {
                [self.progressBar setProgress:progress];
            }
            
        }
    } else if ([keyPath isEqualToString:@"title"]) {
        if ([keyPath isEqualToString:@"title"]) {
            if (object == self.webView) {
                if ([self.webView.title isEqualToString:@"信息发布表"]) {
                    self.title = [self.newsTitle copy];
                } else {
                    self.title = self.webView.title;
                }
                
            } else {
                [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
            }
        }
    }
    else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }

}

#pragma mark - WKWebViewDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSLog(@"是否允许这个导航");
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    //    Decides whether to allow or cancel a navigation after its response is known.
    if (navigationResponse && [navigationResponse.response.URL.path containsString:@"download"]) {
        decisionHandler(WKNavigationResponsePolicyCancel);
        return;
    }
    NSLog(@"知道返回内容之后，是否允许加载，允许加载");
    decisionHandler(WKNavigationResponsePolicyAllow);
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"开始加载");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"跳转到其他的服务器");
    
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"网页由于某些原因加载失败");
    if (error) {
        if (!self.failView.superview) {
            [self.webView addSubview:self.failView];
        }
    } else {

    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"网页开始接收网页内容");
    
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"网页导航加载完毕");
    if (self.failView.superview) {
        [self.failView  removeFromSuperview];
    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"加载失败,失败原因:%@",[error description]);
}
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    NSLog(@"网页加载内容进程终止");
}

- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    return self.webView;
}

- (void)dealloc{
    
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - get

- (WebLoadFaliView *)failView {
    if (!_failView) {
        _failView = [WebLoadFaliView new];
        _failView.frame = self.view.bounds;
        weakself;
        _failView.reloadBlock = ^{
            [wself loadUrlRequest];
        };
    }
    return _failView;
}

@end
