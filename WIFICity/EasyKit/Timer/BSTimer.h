//
//  BSTimer.h
//  
//
//  Created by kai on 15/7/11.
//
//

#import <Foundation/Foundation.h>

@interface BSTimer : NSObject

+ (BSTimer *)timerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo;
+ (BSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo;

- (void)fire;
- (void)invalidate;

@property (readonly, getter=isValid) BOOL valid;

@end
