//
//  UIView+Extension.h
//  WBCustomSDK
//
//  Created by 吴飚 on 16/9/22.
//  Copyright © 2016年 wubiao. All rights reserved.
//

#import <UIKit/UIKit.h>

CGPoint CGRectGetCenter(CGRect rect);
CGRect CGRectMoveToCenter(CGRect rect, CGPoint center);

@interface UIView (Extension)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat radius;

@property (nonatomic, readonly) CGPoint bottomLeft;
@property (nonatomic, readonly) CGPoint bottomRight;
@property (nonatomic, readonly) CGPoint topRight;

/**
 移动
 */
- (void)moveBy:(CGPoint)delta;

/**
 缩放
 */
- (void)scaleBy:(CGFloat)scaleFactor;

/**
 根据宽、高适应
 */
- (void)fitInSize:(CGSize)aSize;

/**
 获取view所在的控制器
 */
- (UIViewController *)viewController;

/**
 移除所有子view
 */
- (void)removeAllSubviews;

#pragma mark - 其它效果

/**
 变圆
 */
- (UIView *)turnRound;

/**
 加阴影
 */
- (void)addShadow;

typedef void (^GestureActionBlock)(UIGestureRecognizer *ges);

/**
 单击手势
 */
- (void)tapGesture:(GestureActionBlock)block;

- (void)tapGesture:(GestureActionBlock)block numberOfTapsRequired:(NSUInteger)tapsCount;

/**
 长按手势
 */
- (void)longPressGestrue:(GestureActionBlock)block;

/**
 添加边框
 */
- (void)border:(UIColor *)color width:(CGFloat)width;

- (void)border:(UIColor *)color width:(CGFloat)width CornerRadius:(CGFloat)radius;

/**
 四角变圆
 */
- (void)borderRound;

- (void)borderRoundCornerRadius:(CGFloat)radius;

/**
 画线
 */
+ (CAShapeLayer *)drawLine:(CGPoint)points to:(CGPoint)pointe color:(UIColor *)color;

/**
 画框框线
 */
+ (CAShapeLayer *)drawRect:(CGRect)rect radius:(CGFloat)redius color:(UIColor *)color;

/**
 画圆
 */
+ (CAShapeLayer *)drawArc:(CGPoint)points radius:(CGFloat)radius startD:(CGFloat)startd endD:(CGFloat)endD color:(UIColor *)color;

@end
