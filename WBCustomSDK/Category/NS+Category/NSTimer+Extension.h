//
//  NSTimer+Extension.h
//  WBCustomSDK
//
//  Created by 吴飚 on 16/9/22.
//  Copyright © 2016年 wubiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Extension)

/**
 手动将timer添加到一个runloop中。[[NSRunLoop currentRunLoop]addTimer:he forMode:NSDefaultRunLoopMode];
 */
+ (id)timerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)())inBlock repeats:(BOOL)inRepeats;

/**
 scheduled的初始化方法将以默认mode直接添加到当前的runloop中。
 */
+ (id)runTimer:(NSTimeInterval)inTimeInterval block:(void (^)())inBlock repeats:(BOOL)inRepeats;

/**
 暂停
 */
- (void)pause;

/**
 继续
 */
- (void)goOn;

/**
 X秒后继续
 */
- (void)goOn:(NSTimeInterval)interval;

@end
