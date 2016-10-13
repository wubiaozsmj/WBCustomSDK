//
//  UIButton+Extension.h
//  WBCustomSDK
//
//  Created by 吴飚 on 16/9/22.
//  Copyright © 2016年 wubiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)

/**
 创建button，无图片
 */
+ (UIButton *)createButtonWithTitle:(NSString *)title titleFont:(CGFloat)font titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backgroundColor;

/**
 创建button，有图片
 */
+ (UIButton *)createButtonWithImage:(NSString *)imageName highlightImage:(NSString *)highlightImageName selectedImage:(NSString *)selectedImageName;

/**
 设置button圆角
 */
- (void)setRoundRectWithCornerRadius:(CGFloat)radius;

/**
 设置button边框
 */
- (void)setFrameWithColor:(UIColor *)color width:(CGFloat)width;

@end
