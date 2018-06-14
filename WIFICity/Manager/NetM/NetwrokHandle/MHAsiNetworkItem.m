//
//  MHAsiNetworkItem.m
//  MHProject
//
//  Created by MengHuan on 15/4/23.
//  Copyright (c) 2015年 MengHuan. All rights reserved.
//

#import "MHAsiNetworkItem.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "MHAsiNetworkDefine.h"
#import "AppDelegate.h"
#import "TGNetConfig.h"

@interface MHAsiNetworkItem ()

@end

@implementation MHAsiNetworkItem


#pragma mark - 创建一个网络请求项，开始请求网络
/**
 *  创建一个网络请求项，开始请求网络
 *
 *  @param networkType  网络请求方式
 *  @param url          网络请求URL
 *  @param params       网络请求参数
 *  @param delegate     网络请求的委托，如果没有取消网络请求的需求，可传nil
 *  @param hashValue    网络请求的委托delegate的唯一标示
 *  @param showHUD      是否显示HUD
 *  @param successBlock 请求成功后的block
 *  @param failureBlock 请求失败后的block
 *
 *  @return MHAsiNetworkItem对象
 */
- (MHAsiNetworkItem *)initWithtype:(MHAsiNetWorkType)networkType
                               url:(NSString *)url
                            params:(NSDictionary *)params
                          delegate:(id)delegate
                            target:(id)target
                            action:(SEL)action
                         hashValue:(NSUInteger)hashValue
                           showHUD:(BOOL)showHUD
                      successBlock:(MHAsiSuccessBlock)successBlock
                      failureBlock:(MHAsiFailureBlock)failureBlock
{
    if (self = [super init])
    {
        self.networkType    = networkType;
        self.url            = url;
        self.params         = params;
        self.delegate       = delegate;
        self.showHUD        = showHUD;
        self.tagrget        = target;
        self.select         = action;
        if (showHUD==YES) {
            [MBProgressHUD showHUDAddedTo:KWINDOW animated:YES];
        }
        __weak typeof(self)weakSelf = self;
        DTLog(@"--请求url地址--%@\n",url);
        DTLog(@"----请求参数%@\n",params);
        [params setValue:[[AccountManager shared].user.userId copy] forKey:@"userId"];
        AFHTTPSessionManager *manager = [TGNetConfig httpManager];
        if (networkType==MHAsiNetWorkGET)
        {
            [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [MBProgressHUD hideAllHUDsForView:KWINDOW animated:YES];
                if (successBlock) {
                    successBlock(responseObject);
                }
                if ([weakSelf.delegate respondsToSelector:@selector(requestDidFinishLoading:)]) {
                    [weakSelf.delegate requestDidFinishLoading:responseObject];
                }
                [weakSelf performSelector:@selector(finishedRequest: didFaild:) withObject:responseObject withObject:nil];
                [weakSelf removewItem];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [MBProgressHUD hideAllHUDsForView:KWINDOW animated:YES];
                if (failureBlock) {
                    failureBlock(error);
                }
                if ([weakSelf.delegate respondsToSelector:@selector(requestdidFailWithError:)]) {
                    [weakSelf.delegate requestdidFailWithError:error];
                }
                [weakSelf performSelector:@selector(finishedRequest: didFaild:) withObject:nil withObject:error];
                [weakSelf removewItem];
            }];
        }else{
            [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [MBProgressHUD hideHUDForView:KWINDOW animated:YES];
                if ([responseObject isKindOfClass:[NSDictionary class]]) {

                }
                if (successBlock) {
                    
                    successBlock(responseObject);
                }
                if ([weakSelf.delegate respondsToSelector:@selector(requestDidFinishLoading:)]) {
                    [weakSelf.delegate requestDidFinishLoading:responseObject];
                }
                [weakSelf performSelector:@selector(finishedRequest: didFaild:) withObject:responseObject withObject:nil];
                [weakSelf removewItem];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [MBProgressHUD hideAllHUDsForView:KWINDOW animated:YES];
                NSLog(@"failUrl:%@",url);
                if (failureBlock) {
                    failureBlock(error);
                }
                if ([weakSelf.delegate respondsToSelector:@selector(requestdidFailWithError:)]) {
                    [weakSelf.delegate requestdidFailWithError:error];
                }
                [weakSelf performSelector:@selector(finishedRequest: didFaild:) withObject:nil withObject:error];
                [weakSelf removewItem];
            }];

        }
    }
    return self;
}
/**
 *   移除网络请求项
 */
- (void)removewItem
{
    __weak typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([weakSelf.delegate respondsToSelector:@selector(netWorkWillDealloc:)]) {
            [weakSelf.delegate netWorkWillDealloc:weakSelf];
        }
    });
}

- (void)finishedRequest:(id)data didFaild:(NSError*)error
{
    if ([self.tagrget respondsToSelector:self.select]) {
        [self.tagrget performSelector:@selector(finishedRequest:didFaild:) withObject:data withObject:error];
    }
}

- (UIViewController*)getCurrentVC
{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    return [self topViewControllerWithRootViewController:window.rootViewController];
}

- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController
{
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}

- (void)dealloc
{
    
    
}

@end
