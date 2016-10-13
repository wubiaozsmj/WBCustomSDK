//
//  UILabel+Extension.m
//  WBCustomSDK
//
//  Created by 吴飚 on 16/9/22.
//  Copyright © 2016年 wubiao. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

/**
 创建label
 */
+ (UILabel *)createLabelWithFrame:(CGRect)frame text:(NSString *)text textAlignment:(NSTextAlignment)alignment textColor:(UIColor *)textColor textFont:(CGFloat)font backgroundColor:(UIColor *)backgroundColor
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.textAlignment = alignment;
    label.textColor = textColor;
    label.font = [UIFont systemFontOfSize:font];
    label.backgroundColor = backgroundColor;
    label.numberOfLines = 0;
    
    return label;
}

/**
 设置label圆角
 */
- (void)setRoundRectWithCornerRadius:(CGFloat)radius
{
    self.layer.cornerRadius = radius;
}

/**
 设置label边框
 */
- (void)setFrameWithColor:(UIColor *)color width:(CGFloat)width
{
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
}

/**
 删除线
 */
- (void)stringWithDeleteLine:(NSString *)string
{
    if (kStringIsEmpty(string))
    {
        return;
    }
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:string];
    [attributed addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, string.length)];
    [self setAttributedText:attributed];
}

/**
 下划线
 */
- (void)stringWithUnderLine:(NSString *)string
{
    if (kStringIsEmpty(string))
    {
        return;
    }
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:string];
    [attributed addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, string.length)];
    [self setAttributedText:attributed];
}

/**
 设置label行间距为默认值：10
 */
- (void)setLabelRowOfHeight:(NSString *)string
{
    [self setLabelRowOfHeight:10 string:string];
}

/**
 设置label行间距
 */
- (void)setLabelRowOfHeight:(CGFloat)height string:(NSString *)string
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:height]; //调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [string length])];
    self.attributedText = attributedString;
    [self sizeToFit];
}

/**
 设置HTML代码格式
 */
- (void)htmlString:(NSString *)string
{
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[string dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    self.attributedText = attributedString;
}

/**
 设置HTML代码格式，行间距
 */
- (void)htmlString:(NSString *)string labelRowOfHeight:(CGFloat)height
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithData:[string dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:height]; //调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attributedString length])];
    self.attributedText = attributedString;
    [self sizeToFit];

}

@end
