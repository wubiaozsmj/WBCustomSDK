//
//  UIView+Extension.m
//  WBCustomSDK
//
//  Created by 吴飚 on 16/9/22.
//  Copyright © 2016年 wubiao. All rights reserved.
//

#import "UIView+Extension.h"
#import <objc/runtime.h>

CGPoint CGRectGetCenter(CGRect rect)
{
    CGPoint pt;
    pt.x = CGRectGetMidX(rect);
    pt.y = CGRectGetMidY(rect);
    return pt;
}

CGRect CGRectMoveToCenter(CGRect rect, CGPoint center)
{
    CGRect newrect = CGRectZero;
    newrect.origin.x = center.x - CGRectGetMidX(rect);
    newrect.origin.y = center.y - CGRectGetMidY(rect);
    newrect.size = rect.size;
    return newrect;
}

@implementation UIView (Extension)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)newwidth
{
    CGRect newframe = self.frame;
    newframe.size.width = newwidth;
    self.frame = newframe;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)newheight
{
    CGRect newframe = self.frame;
    newframe.size.height = newheight;
    self.frame = newframe;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)newsize
{
    CGRect newframe = self.frame;
    newframe.size = newsize;
    self.frame = newframe;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)neworigin
{
    CGRect newframe = self.frame;
    newframe.origin = neworigin;
    self.frame = newframe;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setTop:(CGFloat)newtop
{
    CGRect newframe = self.frame;
    newframe.origin.y = newtop;
    self.frame = newframe;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setLeft:(CGFloat)newleft
{
    CGRect newframe = self.frame;
    newframe.origin.x = newleft;
    self.frame = newframe;
}

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setBottom:(CGFloat)newbottom
{
    CGRect newframe = self.frame;
    newframe.origin.y = newbottom - self.frame.size.height;
    self.frame = newframe;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setRight:(CGFloat)newright
{
    CGFloat delta = newright - (self.frame.origin.x + self.frame.size.width);
    CGRect newframe = self.frame;
    newframe.origin.x += delta;
    self.frame = newframe;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRadius:(CGFloat)radius
{
    if (radius <= 0)
    {
        radius = self.width * 0.5f;
    }
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

- (CGFloat)radius
{
    return self.layer.cornerRadius;
}

- (CGPoint)bottomLeft
{
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint)bottomRight
{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint)topRight
{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y;
    return CGPointMake(x, y);
}

/**
 移动
 */
- (void)moveBy:(CGPoint)delta
{
    CGPoint newcenter = self.center;
    newcenter.x += delta.x;
    newcenter.y += delta.y;
    self.center = newcenter;
}

/**
 缩放
 */
- (void)scaleBy:(CGFloat)scaleFactor
{
    CGRect newframe = self.frame;
    newframe.size.width *= scaleFactor;
    newframe.size.height *= scaleFactor;
    self.frame = newframe;
}

/**
 根据宽、高适应
 */
- (void)fitInSize:(CGSize)aSize
{
    CGFloat scale;
    CGRect newframe = self.frame;
    
    if (newframe.size.height && (newframe.size.height > aSize.height))
    {
        scale = aSize.height / newframe.size.height;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    if (newframe.size.width && (newframe.size.width >= aSize.width))
    {
        scale = aSize.width / newframe.size.width;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    self.frame = newframe;
}

/**
 获取view所在的控制器
 */
- (UIViewController *)viewController
{
    UIResponder *next = self.nextResponder;
    while (next != nil)
    {
        if ([next isKindOfClass:[UIViewController class]])
        {
            return (UIViewController *) next;
        }
        
        next = next.nextResponder;
    }
    
    return nil;
}

/**
 移除所有子view
 */
- (void)removeAllSubviews
{
    while (self.subviews.count)
    {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

#pragma mark - 其它效果

/**
 变圆
 */
- (UIView *)turnRound
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.width / 2;
    return self;
}

/**
 加阴影
 */
- (void)addShadow
{
    self.layer.shadowOffset = CGSizeMake(0, 2);
    self.layer.shadowOpacity = 0.24;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, self.height - 2, self.width == 320 ? [UIScreen mainScreen].bounds.size.width : self.width, 2)].CGPath;
}

typedef void (^GestureActionBlock)(UIGestureRecognizer *ges);

static char kActionHandlerTapBlockKey;
static char kActionHandlerTapGestureKey;
static char kActionHandlerLongPressBlockKey;
static char kActionHandlerLongPressGestureKey;

/**
 单击手势
 */
- (void)tapGesture:(GestureActionBlock)block
{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kActionHandlerTapGestureKey);
    if (!gesture)
    {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForTapGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &kActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)tapGesture:(GestureActionBlock)block numberOfTapsRequired:(NSUInteger)tapsCount
{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kActionHandlerTapGestureKey);
    if (!gesture)
    {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForTapGesture:)];
        gesture.numberOfTapsRequired = tapsCount;
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &kActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)handleActionForTapGesture:(UITapGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        GestureActionBlock block = objc_getAssociatedObject(self, &kActionHandlerTapBlockKey);
        if (block)
        {
            block(gesture);
        }
    }
}

/**
 长按手势
 */
- (void)longPressGestrue:(GestureActionBlock)block
{
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *gesture = objc_getAssociatedObject(self, &kActionHandlerLongPressGestureKey);
    if (!gesture)
    {
        gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForLongPressGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kActionHandlerLongPressGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &kActionHandlerLongPressBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)handleActionForLongPressGesture:(UITapGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        GestureActionBlock block = objc_getAssociatedObject(self, &kActionHandlerLongPressBlockKey);
        if (block)
        {
            block(gesture);
        }
    }
}

/**
 添加边框
 */
- (void)border:(UIColor *)color width:(CGFloat)width
{
    CALayer *layer = self.layer;
    if (color != nil)
    {
        layer.borderColor = color.CGColor;
    }
    layer.cornerRadius = 4;
    layer.masksToBounds = YES;
    layer.borderWidth = width;
}

- (void)border:(UIColor *)color width:(CGFloat)width CornerRadius:(CGFloat)radius
{
    if (radius == 0)
    {
        [self border:color width:width];
    }
    else
    {
        CALayer *layer = self.layer;
        if (color != nil)
        {
            layer.borderColor = color.CGColor;
        }
        layer.cornerRadius = radius;
        layer.masksToBounds = YES;
        layer.borderWidth = width;
    }
}

/**
 四角变圆
 */
- (void)borderRound
{
    CALayer *layer = self.layer;
    layer.cornerRadius = 4;
    layer.masksToBounds = YES;
}

- (void)borderRoundCornerRadius:(CGFloat)radius
{
    CALayer *layer = self.layer;
    layer.cornerRadius = radius;
    layer.masksToBounds = YES;
}

/**
 画线
 */
+ (CAShapeLayer *)drawLine:(CGPoint)points to:(CGPoint)pointe color:(UIColor *)color
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:points];
    [path addLineToPoint:pointe];
    [path closePath];
    shapeLayer.path = path.CGPath;
    shapeLayer.strokeColor = [color CGColor];
    shapeLayer.fillColor = [[UIColor whiteColor] CGColor];
    shapeLayer.lineWidth = 1;
    return shapeLayer;
}

/**
 画框框线
 */
+ (CAShapeLayer *)drawRect:(CGRect)rect radius:(CGFloat)redius color:(UIColor *)color
{
    CAShapeLayer *solidLine = [CAShapeLayer layer];
    UIBezierPath *solidPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:redius];
    solidLine.lineWidth = 1.0f;
    solidLine.strokeColor = color.CGColor;
    solidLine.fillColor = [UIColor clearColor].CGColor;
    solidLine.path = solidPath.CGPath;
    return solidLine;
}

/**
 画圆
 */
+ (CAShapeLayer *)drawArc:(CGPoint)points radius:(CGFloat)radius startD:(CGFloat)startd endD:(CGFloat)endD color:(UIColor *)color
{
    CAShapeLayer *solidLine = [CAShapeLayer layer];
    UIBezierPath *solidPath = [UIBezierPath bezierPathWithArcCenter:points radius:radius startAngle:startd endAngle:endD clockwise:YES];
    solidLine.lineWidth = 1.0f;
    solidLine.strokeColor = color.CGColor;
    solidLine.fillColor = [UIColor clearColor].CGColor;
    solidLine.path = solidPath.CGPath;
    return solidLine;
}

@end
