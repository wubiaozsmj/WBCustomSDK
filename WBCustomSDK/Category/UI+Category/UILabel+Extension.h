//
//  UILabel+Extension.h
//  WBCustomSDK
//
//  Created by 吴飚 on 16/9/22.
//  Copyright © 2016年 wubiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)

/**
 创建label
 */
+ (UILabel *)createLabelWithFrame:(CGRect)frame text:(NSString *)text textAlignment:(NSTextAlignment)alignment textColor:(UIColor *)textColor textFont:(CGFloat)font backgroundColor:(UIColor *)backgroundColor;

/**
 设置label圆角
 */
- (void)setRoundRectWithCornerRadius:(CGFloat)radius;

/**
 设置label边框
 */
- (void)setFrameWithColor:(UIColor *)color width:(CGFloat)width;

/**
 删除线
 */
- (void)stringWithDeleteLine:(NSString *)string;

/**
 下划线
 */
- (void)stringWithUnderLine:(NSString *)string;

/**
 设置label行间距为默认值：10
 */
- (void)setLabelRowOfHeight:(NSString *)string;

/**
设置label行间距
 */
- (void)setLabelRowOfHeight:(CGFloat)height string:(NSString *)string;

/**
 设置HTML代码格式
 */
- (void)htmlString:(NSString *)string;

/**
 设置HTML代码格式，行间距
 */
- (void)htmlString:(NSString *)string labelRowOfHeight:(CGFloat)height;

@end
