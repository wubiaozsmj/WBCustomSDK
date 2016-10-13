//
//  UIImage+Extension.h
//  WBCustomSDK
//
//  Created by 吴飚 on 16/9/22.
//  Copyright © 2016年 wubiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/**
 纯色图片
 */
+ (UIImage *)colorImage:(UIColor *)color;

+ (UIImage *)colorImage:(UIColor *)color size:(CGSize)size;

/**
 针对iOS7以上的系统适配新的图片资源
 */
+ (UIImage *)imageWithName:(NSString *) imageName;

/**
 生成可以拉伸指定位置的图片
 */
+ (UIImage *)resizableImageWithName:(NSString *)imageName;

/**
 实现图片的缩小或者放大
 */
- (UIImage*)scaleImageWithSize:(CGSize)size;

/**
 调整图片方向
 */
- (UIImage *)fixOrientation;

@end
