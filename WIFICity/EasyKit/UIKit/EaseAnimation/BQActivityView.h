

#import <UIKit/UIKit.h>

@interface BQActivityView : UIView
/**  显示活动指示器 */
+ (BQActivityView *)showActiviTy:(UIView *)view;
/**  关闭活动指示器 */
- (void)hideActiviTy;
@end
