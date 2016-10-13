//
//  NSString+Extension.m
//  WBCustomSDK
//
//  Created by 吴飚 on 16/9/21.
//  Copyright © 2016年 wubiao. All rights reserved.
//

#import "NSString+Extension.h"
#import <CommonCrypto/CommonDigest.h>

#define EmojiCodeToSymbol(c) ((((0x808080F0 | (c & 0x3F000) >> 4) | (c & 0xFC0) << 10) | (c & 0x1C0000) << 18) | (c & 0x3F) << 24)

@implementation NSString (Extension)

/**
 将十六进制的编码转为emoji字符
 */
+ (NSString *)emojiWithIntCode:(int)intCode;
{
    int symbol = EmojiCodeToSymbol(intCode);
    NSString *string = [[NSString alloc] initWithBytes:&symbol length:sizeof(symbol) encoding:NSUTF8StringEncoding];
    if (string == nil)
    { // 新版Emoji
        string = [NSString stringWithFormat:@"%C", (unichar) intCode];
    }
    return string;
}

+ (NSString *)emojiWithStringCode:(NSString *)stringCode
{
    char *charCode = (char *) stringCode.UTF8String;
    int intCode = (int) strtol(charCode, NULL, 16);
    return [self emojiWithIntCode:intCode];
}

- (NSString *)emoji
{
    return [NSString emojiWithStringCode:self];
}

/**
 去掉表情符号
 */
- (NSString *)disableEmoji
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, [self length]) withTemplate:@""];
    return modifiedString;
}

/**
 是否为emoji字符
 */
- (BOOL)isEmoji
{
    BOOL returnValue = NO;
    const unichar hs = [self characterAtIndex:0];
    
    if (0xd800 <= hs && hs <= 0xdbff)
    {
        if (self.length > 1)
        {
            const unichar ls = [self characterAtIndex:1];
            const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
            if (0x1d000 <= uc && uc <= 0x1f77f)
            {
                returnValue = YES;
            }
        }
    }
    
    else if (self.length > 1)
    {
        const unichar ls = [self characterAtIndex:1];
        if (ls == 0x20e3)
        {
            returnValue = YES;
        }
    }
    
    else
    {
        if (0x2100 <= hs && hs <= 0x27ff)
        {
            returnValue = YES;
        }
        else if (0x2B05 <= hs && hs <= 0x2b07)
        {
            returnValue = YES;
        }
        else if (0x2934 <= hs && hs <= 0x2935)
        {
            returnValue = YES;
        }
        else if (0x3297 <= hs && hs <= 0x3299)
        {
            returnValue = YES;
        }
        else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50)
        {
            returnValue = YES;
        }
    }
    
    return returnValue;
}

/**
 删除空格 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]
 */
- (NSString *)deleteBlank
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

/**
 删除空格 stringByReplacingOccurrencesOfString:@" " withString:@""
 */
- (NSString *)deleteSpace
{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

/**
 时间戳对应的NSDate
 */
- (NSDate *)timeDate
{
    return [NSDate dateWithTimeIntervalSince1970:self.floatValue];
}

/**
 转为 Data
 */
- (NSData *)data
{
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

/**
 转为 base64string后的Data
 */
- (NSData *)base64Data
{
    return [[NSData alloc] initWithBase64EncodedString:self options:0];
}

/**
 转为 base64string
 */
- (NSString *)base64String
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
}

/**
 解 base64string 为 string，解不了返回原始的数值
 */
- (NSString *)decodeBase64String
{
    NSString *WillDecode = [[NSString alloc] initWithData:[[NSData alloc] initWithBase64EncodedString:self options:0] encoding:NSUTF8StringEncoding];
    return (WillDecode.length != 0) ? WillDecode : self;
}

/**
 解 为字典
 */
- (NSDictionary *)jsonDictionary
{
    return [NSJSONSerialization JSONObjectWithData:self.data options:NSJSONReadingMutableContainers error:nil];
}

/**
 解 为数组
 */
- (NSArray *)jsonArray
{
    return [NSJSONSerialization JSONObjectWithData:self.data options:NSJSONReadingMutableContainers error:nil];
}

/**
 32位MD5加密
 */
- (NSString *)MD5String
{
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG) strlen(cStr), digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        [result appendFormat:@"%02x", digest[i]];
    }
    return [result copy];
}

#pragma mark - function

/**
 默认font、宽获取高度
 */
- (CGFloat)heightWithFont:(NSInteger)font width:(CGFloat)width
{
    return [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:font] } context:nil].size.height;
}

/**
 默认font、高获取宽度
 */
- (CGFloat)widthWithFont:(NSInteger)font height:(CGFloat)height
{
    return [self boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:font] } context:nil].size.width;
}

/**
 根据字体大小、最大宽度获取size
 */
- (CGSize)sizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth
{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxWidth, MAXFLOAT);
    
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
}

- (CGSize)sizeWithFont:(UIFont *)font
{
    return [self sizeWithFont:font maxWidth:MAXFLOAT];
}

/**
 是否包含substring
 */
- (BOOL)isContainString:(NSString *)subString
{
    return ([self rangeOfString:subString].location == NSNotFound) ? NO : YES;
}

/**
 拼接字符串
 */
- (NSString *)addString:(NSString *)string
{
    if (!string || string.length == 0)
    {
        return self;
    }
    return [self stringByAppendingString:string];
}

/**
 拼接整形数字
 */
- (NSString *)addInt:(int)string
{
    return [self stringByAppendingString:@(string).stringValue];
}

/**
 获取字符串长度，1个中文算2个字符
 */
- (int)textLength
{
    float number = 0.0;
    for (int index = 0; index < [self length]; index++)
    {
        NSString *character = [self substringWithRange:NSMakeRange(index, 1)];
        if ([character lengthOfBytesUsingEncoding:NSUTF8StringEncoding] == 3)
        {
            number = number + 2;
        }
        else
        {
            number = number + 1;
        }
    }
    return ceil(number);
}

/**
 限制字符串最大显示长度
 */
- (NSString *)limitMaxLengthTextShow:(NSInteger)limit
{
    NSString *orign = [self copy];
    for (NSInteger i = orign.length; i > 0; i--)
    {
        NSString *get = [orign substringToIndex:i];
        if (get.textLength <= limit)
        {
            return get;
        }
    }
    return self;
}

/**
 是否中文
 */
- (BOOL)isValidateChinese
{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

/**
 是否邮箱
 */
- (BOOL)isValidateEmail
{
    NSString *emailRegex = @"\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

/**
 是否手机号
 */
- (BOOL)isValidateTelephoneNumber
{
    NSString *phoneRegex = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

/**
 是否数字
 */
- (BOOL)isValidateNumber
{
    NSCharacterSet *cs;
    cs = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    NSRange specialrang = [self rangeOfCharacterFromSet:cs];
    if (specialrang.location != NSNotFound)
    {
        return YES;
    }
    return NO;
}

/**
 密码是否合法
 */
- (BOOL)isLegalWithPassword
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,18}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:self];
}

/**
 是否包含中括号[]
 */
- (BOOL)isContainMiddleBracket
{
    for (int i=0; i<[self length]; i++)
    {
        char str = [self characterAtIndex:i];
        if (str=='[' || str==']')
        {
            return YES;
        }
    }
    return NO;
}

/**
 随机4位数字
 */
- (NSString *)randomCode
{
    NSString *code = @"";
    for (int i = 0; i < 4; i++)
    {
        int value = (arc4random() % 10);
        code = [NSString stringWithFormat:@"%d%@",value,code];
    }
    return code;
}

@end
