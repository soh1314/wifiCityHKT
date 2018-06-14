

#import <UIKit/UIKit.h>

@interface FFBadgedBarButtonItem : UIBarButtonItem

@property (nonatomic, strong) NSString *badge;

-(id)initWithImage:(UIImage *)image target:(id)target action:(SEL)action;

@end
