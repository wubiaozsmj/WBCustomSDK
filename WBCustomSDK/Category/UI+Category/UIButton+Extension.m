//
//  UIButton+Extension.m
//  WBCustomSDK
//
//  Created by 吴飚 on 16/9/22.
//  Copyright © 2016年 wubiao. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)

/**
 创建button，无图片
 */
+ (UIButton *)createButtonWithTitle:(NSString *)title titleFont:(CGFloat)font titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backgroundColor
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:font];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.backgroundColor = backgroundColor;
    
    return btn;
}

/**
 创建button，有图片
 */
+ (UIButton *)createButtonWithImage:(NSString *)imageName highlightImage:(NSString *)highlightImageName selectedImage:(NSString *)selectedImageName
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highlightImageName] forState:UIControlStateHighlighted];
    [btn setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
    
    return btn;
}

/**
 设置button圆角
 */
- (void)setRoundRectWithCornerRadius:(CGFloat)radius
{
    self.layer.cornerRadius = radius;
}

/**
 设置button边框
 */
- (void)setFrameWithColor:(UIColor *)color width:(CGFloat)width
{
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
}

@end
