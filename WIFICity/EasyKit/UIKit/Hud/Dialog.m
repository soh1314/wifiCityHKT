
#import "Dialog.h"
#import "MBProgressHUD.h"
#import <unistd.h>
#import "AILoadingView.h"
#import "BQActivityView.h"
#import "XLLoadingHUD.h"

#pragma GCC diagnostic ignored "-Wdeprecated-declarations"

@implementation Dialog

static Dialog *instance = nil;

+ (Dialog *)Instance
{
    @synchronized(self)
    {
        if (instance == nil) {
            instance = [self new];
            [SVProgressHUD setMaximumDismissTimeInterval:0.5];
            [SVProgressHUD setMinimumDismissTimeInterval:0.25];

        }
    }
    return instance;
}

+ (void)alert:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:nil 
                              message:message 
                              delegate:nil 
                              cancelButtonTitle:@"确定" 
                              otherButtonTitles:nil, nil];
    [alertView show];
}

+ (void)alertWithTitle:(NSString *)title andMessage:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:title
                              message:message
                              delegate:nil
                              cancelButtonTitle:@"确定"
                              otherButtonTitles:nil, nil];
    [alertView show];
}

+ (void)showBubbleLoadingView:(UIView *)view {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    hud.color  = [UIColor clearColor];
    BQActivityView *activityView = [BQActivityView showActiviTy:view];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = activityView;
}

+ (void)showRingLoadingView:(UIView *)view {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.removeFromSuperViewOnHide = YES;
//    hud.minShowTime = 0.5;
    hud.color  = [UIColor clearColor];
    hud.mode = MBProgressHUDModeCustomView;
    hud.yOffset = -80.f;
    XLLoadingHUD *ringHud = [[XLLoadingHUD alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [ringHud start];
    hud.customView = ringHud;
}

+ (void)toast:(UIViewController *)controller withMessage:(NSString *)message {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.margin = 10.f;
    hud.yOffset = 150.f;
    [hud hide:YES afterDelay:2];
}

+ (void)toast:(NSString *)message {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
	hud.mode = MBProgressHUDModeText;
    hud.animationType = MBProgressHUDAnimationFade;
	hud.labelText = message;
	hud.margin = 10.f;
	hud.yOffset = 150.f;
	hud.removeFromSuperViewOnHide = YES;
	[hud hide:YES afterDelay:1];
}

+ (void)simpleToast:(NSString *)message
{
//    [SVProgressHUD showImage:[UIImage qsImageNamed:@""] status:message];
//    [SVProgressHUD setCornerRadius:5];
//    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
//    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
//    [SVProgressHUD dismissWithDelay:1.5];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.animationType = MBProgressHUDAnimationFade;
    hud.minShowTime = 0.5;
    hud.labelText = message;
    hud.labelFont = [UIFont systemFontOfSize:14];
    hud.margin = 10.f;
    hud.yOffset = KSCREENW/2.0;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1.5];
}

+ (void)hideSimpleToast
{
    [SVProgressHUD dismissWithDelay:0.25];
}

+ (void)toastCenter:(NSString *)message {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
	hud.mode = MBProgressHUDModeText;
    hud.animationType = MBProgressHUDAnimationFade;
    hud.minShowTime = 0.5;
	hud.labelText = message;
	hud.margin = 10.f;
	hud.yOffset = -20.f;
	hud.removeFromSuperViewOnHide = YES;
	[hud hide:YES afterDelay:2];
}

+ (void)progressToast:(NSString *)message
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
	hud.mode = MBProgressHUDModeIndeterminate;
	hud.labelText = message;
	hud.margin = 10.f;
	hud.yOffset = -20.f;
	hud.removeFromSuperViewOnHide = YES;
	[hud hide:YES afterDelay:2];
}

- (void)gradient:(UIViewController *)controller seletor:(SEL)method {
    HUD = [[MBProgressHUD alloc] initWithView:controller.view];
	[controller.view addSubview:HUD];
//	HUD.dimBackground = YES;
	HUD.delegate = self;
	[HUD showWhileExecuting:method onTarget:controller withObject:nil animated:YES];
}

- (void)showProgress:(UIViewController *)controller {
    HUD = [[MBProgressHUD alloc] initWithView:controller.view];
    [controller.view addSubview:HUD];
//    HUD.dimBackground = YES;
    HUD.delegate = self;
    [HUD show:YES];
}

- (void)showProgress:(UIViewController *)controller withLabel:(NSString *)labelText {
    HUD = [[MBProgressHUD alloc] initWithView:controller.view];
    [controller.view addSubview:HUD];
    HUD.delegate = self;
//    HUD.dimBackground = YES;
    HUD.labelText = labelText;
    [HUD show:YES];
}

- (void)showCenterProgressWithLabel:(NSString *)labelText
{
    HUD = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
    [[UIApplication sharedApplication].keyWindow addSubview:HUD];
    HUD.delegate = self;
    //    HUD.dimBackground = YES;
    HUD.labelText = labelText;
    [HUD show:YES];
}

- (void)hideProgress {
    [HUD hide:YES];
}

- (void)progressWithLabel:(UIViewController *)controller seletor:(SEL)method {
    HUD = [[MBProgressHUD alloc] initWithView:controller.view];
    [controller.view addSubview:HUD];
    HUD.delegate = self;
    //HUD.labelText = @"数据加载中...";
    [HUD showWhileExecuting:method onTarget:controller withObject:nil animated:YES];
}

+ (void)showWindowToast {
    [MBProgressHUD showHUDAddedTo:KWINDOW animated:YES];
}

+ (void)hideWindowToast {
    [MBProgressHUD hideAllHUDsForView:KWINDOW animated:YES];
}

+ (void)hideToastView:(UIView *)view {
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
    
}

#pragma mark -
#pragma mark Execution code

- (void)myTask {
	sleep(3);
}

- (void)myProgressTask {
	float progress = 0.0f;
	while (progress < 1.0f) {
		progress += 0.01f;
		HUD.progress = progress;
		usleep(50000);
	}
}

- (void)myMixedTask {
	sleep(2);
	HUD.mode = MBProgressHUDModeDeterminate;
	HUD.labelText = @"Progress";
	float progress = 0.0f;
	while (progress < 1.0f)
	{
		progress += 0.01f;
		HUD.progress = progress;
		usleep(50000);
	}
	HUD.mode = MBProgressHUDModeIndeterminate;
	HUD.labelText = @"Cleaning up";
	sleep(2);
	HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] ;
	HUD.mode = MBProgressHUDModeCustomView;
	HUD.labelText = @"Completed";
	sleep(2);
}

#pragma mark -
#pragma mark NSURLConnectionDelegete

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	expectedLength = [response expectedContentLength];
	currentLength = 0;
	HUD.mode = MBProgressHUDModeDeterminate;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	currentLength += [data length];
	HUD.progress = currentLength / (float)expectedLength;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
	HUD.mode = MBProgressHUDModeCustomView;
	[HUD hide:YES afterDelay:2];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	[HUD hide:YES];
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
	[HUD removeFromSuperview];
	HUD = nil;
}

@end
