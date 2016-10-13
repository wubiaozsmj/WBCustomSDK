//
//  UIImage+Extension.m
//  WBCustomSDK
//
//  Created by 吴飚 on 16/9/22.
//  Copyright © 2016年 wubiao. All rights reserved.
//

#import "UIImage+Extension.h"

#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

@implementation UIImage (Extension)

/**
 纯色图片
 */
+ (UIImage *)colorImage:(UIColor *)color
{
    CGSize size = CGSizeMake(1.0f, 1.0f);
    return [self colorImage:color size:size];
}

+ (UIImage *)colorImage:(UIColor *)color size:(CGSize)size
{
    CGRect rect = (CGRect){{0.0f, 0.0f}, size};
    //开启一个图形上下文
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    //获取图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    //获取图像
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    return image;
}

/**
 针对iOS7以上的系统适配新的图片资源
 */
+ (UIImage *)imageWithName:(NSString *) imageName
{
    UIImage *newImage = nil;
    if (iOS7)
    {
        newImage = [UIImage imageNamed:[imageName stringByAppendingString:@"_os7"]];
    }
    if (newImage == nil)
    {
        newImage = [UIImage imageNamed:imageName];
    }
    return newImage;
}

/**
 生成可以拉伸指定位置的图片
 */
+ (UIImage *)resizableImageWithName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    // 获取原有图片的宽高的一半
    CGFloat w = image.size.width * 0.5;
    CGFloat h = image.size.height * 0.5;
    // 生成可以拉伸指定位置的图片
    UIImage *newImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w) resizingMode:UIImageResizingModeStretch];
    
    return newImage;
}

/**
 实现图片的缩小或者放大
 */
- (UIImage*)scaleImageWithSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size,NO,0);  //size 为CGSize类型，即你所需要的图片尺寸
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;   //返回的就是已经改变的图片
}

/**
 调整图片方向
 */
- (UIImage *)fixOrientation
{
    if (self.imageOrientation == UIImageOrientationUp)
    {
        return self;
    }
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation)
    {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (self.imageOrientation)
    {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0, 0, self.size.height, self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0, 0, self.size.width, self.size.height), self.CGImage);
            break;
    }
    
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

@end
