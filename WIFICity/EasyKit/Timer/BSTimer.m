//
//  BSTimer.m
//  
//
//  Created by kai on 15/7/11.
//
//

#import "BSTimer.h"

@interface TimerTargetWrapper : NSObject

@property(weak, nonatomic) id target;
@property(assign, nonatomic) SEL aSelector;

- (void)onTimeout:(id)timer;

@end

@implementation TimerTargetWrapper

- (void)onTimeout:(id)timer
{
    if (_target ) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Warc-performSelector-leaks"
        [_target performSelector:_aSelector withObject:self];
#pragma clang diagnostic pop
    }
}
@end

@interface BSTimer()

@property(strong, nonatomic) NSTimer *timer;

@end

@implementation BSTimer

+ (BSTimer *)timerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo
{
    BSTimer *bstimer = [BSTimer new];
    
    TimerTargetWrapper *wrapper = [TimerTargetWrapper new];
    wrapper.target = aTarget;
    wrapper.aSelector = aSelector;
    
    bstimer.timer = [NSTimer timerWithTimeInterval:ti target:wrapper selector:@selector(onTimeout:) userInfo:userInfo repeats:yesOrNo];
    
    return bstimer;
}

+ (BSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo
{
    BSTimer *bstimer = [BSTimer new];
    
    TimerTargetWrapper *wrapper = [TimerTargetWrapper new];
    wrapper.target = aTarget;
    wrapper.aSelector = aSelector;
    
    bstimer.timer = [NSTimer scheduledTimerWithTimeInterval:ti target:wrapper selector:@selector(onTimeout:) userInfo:userInfo repeats:yesOrNo];
    return bstimer;
}

- (void)fire
{
    [_timer fire];
}

- (void)invalidate
{
    [_timer invalidate];
}

- (BOOL)isValid
{
    return [_timer isValid];
}

@end
