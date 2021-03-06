
#import "WifiValidatorController.h"
#import <WebKit/WebKit.h>
@interface WifiValidatorController ()
@property(nonatomic,strong)WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;
@end

@implementation WifiValidatorController

- (id)init {
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"wifi认证";
    [self setBlackNavBar];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"←" style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    
    if(!self.URLString ){
        if (self.htmlWord) {
            UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
            webView.backgroundColor = [UIColor whiteColor];
            [self.view addSubview:webView];
            CGFloat width = [UIScreen mainScreen].bounds.size.width-16;
            NSString *header = [NSString stringWithFormat:@"<head><style>img{max-width:%fpx !important;}</style></head>",width];
            NSString *html = [NSString stringWithFormat:@"%@%@",header,self.htmlWord];
            [webView loadHTMLString:html baseURL:nil];
        } else {
            return;
        }
        
    } else {
        self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        self.webView.scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.view addSubview:self.webView];
        [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:(self.URLString)]];
        [self.webView loadRequest:request];
        self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 5)];
        self.progressView.progressViewStyle = UIProgressViewStyleBar;
        self.progressView.progressTintColor = [UIColor blackColor];
        [self.navigationController.view addSubview:self.progressView];
    }
    
    
    
}
-(void)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
        [self.progressView setProgress:progress animated:YES];
        if(progress == 1.0)
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self.progressView setProgress:0.0 animated:NO];
//                [self.navigationController popViewControllerAnimated:YES];
                
            });
        }
        
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
- (void)dealloc{
    
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
