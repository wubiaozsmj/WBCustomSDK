//
//  NSString+Extension.h
//  WBCustomSDK
//
//  Created by 吴飚 on 16/9/21.
//  Copyright © 2016年 wubiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extension)

/**
 将十六进制的编码转为emoji字符
 */
+ (NSString *)emojiWithIntCode:(int)intCode;

+ (NSString *)emojiWithStringCode:(NSString *)stringCode;

- (NSString *)emoji;

/**
 去掉表情符号
 */
- (NSString *)disableEmoji;

/**
 是否为emoji字符
 */
- (BOOL)isEmoji;

/**
 删除空格 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]
 */
@property (nonatomic, copy, readonly) NSString *deleteBlank;

/**
 删除空格 stringByReplacingOccurrencesOfString:@" " withString:@""
 */
@property (nonatomic, copy, readonly) NSString *deleteSpace;

/**
 时间戳对应的NSDate
 */
@property (nonatomic, strong, readonly) NSDate *timeDate;

/**
 转为 Data
 */
@property (nonatomic, copy, readonly) NSData *data;

/**
 转为 base64string后的Data
 */
@property (nonatomic, copy, readonly) NSData *base64Data;

/**
 转为 base64string
 */
@property (nonatomic, copy, readonly) NSString *base64String;

/**
 解 base64string 为 string，解不了返回原始的数值
 */
@property (nonatomic, copy, readonly) NSString *decodeBase64String;

/**
 解 为字典
 */
@property (nonatomic, strong, readonly) NSDictionary *jsonDictionary;

/**
 解 为数组
 */
@property (nonatomic, strong, readonly) NSArray *jsonArray;

/**
 32位MD5加密
 */
@property (nonatomic, copy, readonly) NSString *MD5String;

#pragma mark - function

/**
 默认font、宽获取高度
 */
- (CGFloat)heightWithFont:(NSInteger)font width:(CGFloat)width;

/**
 默认font、高获取宽度
 */
- (CGFloat)widthWithFont:(NSInteger)font height:(CGFloat)height;

/**
 根据字体大小、最大宽度获取size
 */
- (CGSize)sizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth;

- (CGSize)sizeWithFont:(UIFont *)font;

/**
 是否包含substring
 */
- (BOOL)isContainString:(NSString *)subString;

/**
 拼接字符串
 */
- (NSString *)addString:(NSString *)string;

/**
 拼接整形数字
 */
- (NSString *)addInt:(int)string;

/**
 获取字符串长度，1个中文算2个字符
 */
- (int)textLength;

/**
 限制字符串最大显示长度
 */
- (NSString *)limitMaxLengthTextShow:(NSInteger)limit;

/**
 是否中文
 */
- (BOOL)isValidateChinese;

/**
 是否邮箱
 */
- (BOOL)isValidateEmail;

/**
 是否手机号
 */
- (BOOL)isValidateTelephoneNumber;

/**
 是否数字
 */
- (BOOL)isValidateNumber;

/**
 密码是否合法
 */
- (BOOL)isLegalWithPassword;

/**
 是否包含中括号[]
 */
- (BOOL)isContainMiddleBracket;

/**
 随机4位数字
 */
- (NSString *)randomCode;

@end
