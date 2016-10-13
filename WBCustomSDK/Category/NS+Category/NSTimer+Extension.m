//
//  NSTimer+Extension.m
//  WBCustomSDK
//
//  Created by 吴飚 on 16/9/22.
//  Copyright © 2016年 wubiao. All rights reserved.
//

#import "NSTimer+Extension.h"

@implementation NSTimer (Extension)

/**
 手动将timer添加到一个runloop中。[[NSRunLoop currentRunLoop]addTimer:he forMode:NSDefaultRunLoopMode];
 */
+ (id)timerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)())inBlock repeats:(BOOL)inRepeats
{
    void (^block)() = [inBlock copy];
    id ret = [self timerWithTimeInterval:inTimeInterval target:self selector:@selector(jdExecuteSimpleBlock:) userInfo:block repeats:inRepeats];
    return ret;
}

/**
 scheduled的初始化方法将以默认mode直接添加到当前的runloop中。
 */
+ (id)runTimer:(NSTimeInterval)inTimeInterval block:(void (^)())inBlock repeats:(BOOL)inRepeats
{
    void (^block)() = [inBlock copy];
    id ret = [self scheduledTimerWithTimeInterval:inTimeInterval target:self selector:@selector(jdExecuteSimpleBlock:) userInfo:block repeats:inRepeats];
    return ret;
}

+ (void)jdExecuteSimpleBlock:(NSTimer *)inTimer;
{
    if ([inTimer userInfo])
    {
        void (^block)() = (void (^)())[inTimer userInfo];
        block();
    }
}

/**
 暂停
 */
- (void)pause
{
    if (![self isValid])
    {
        return;
    }
    [self setFireDate:[NSDate distantFuture]];
}

/**
 继续
 */
- (void)goOn
{
    if (![self isValid])
    {
        return;
    }
    [self setFireDate:[NSDate date]];
}

/**
 X秒后继续
 */
- (void)goOn:(NSTimeInterval)interval
{
    if (![self isValid])
    {
        return;
    }
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}

@end
