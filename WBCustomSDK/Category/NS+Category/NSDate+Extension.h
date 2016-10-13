//
//  NSDate+Extension.h
//  WBCustomSDK
//
//  Created by 吴飚 on 16/9/21.
//  Copyright © 2016年 wubiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

/**
 时间戳字符串
 */
@property (nonatomic, copy, readonly) NSString *timeStampString;

/**
 时间戳长整型
 */
@property (nonatomic, assign, readonly) double timeStamp;

/**
 时间成分
 */
@property (nonatomic, strong, readonly) NSDateComponents *components;


/**
 是否为今年/昨天/今天
 */
- (BOOL)isThisYear;

- (BOOL)isYesterday;

- (BOOL)isToday;

/**
 比较两个时间

 @param unit     成分单元
 @param fromDate 起点时间
 @param toDate   终点时间

 @return 时间成分对象
 */
+ (NSDateComponents *)compareDateComponents:(NSCalendarUnit)unit fromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

/**
 根据年、月、日、时、分、秒返回NSDate

 @param year   年
 @param month  月
 @param day    日
 @param hour   时
 @param minute 分
 @param second 秒
 */
+ (NSDate *)dateWithYear:(NSInteger)year
                   Month:(NSInteger)month
                     Day:(NSInteger)day
                    Hour:(NSInteger)hour
                  Minute:(NSInteger)minute
                  Second:(NSInteger)second;

/**
 NSDateFormatter单例方法

 @return 相应格式的NSDateFormatter对象
 */
+ (NSDateFormatter *)defaultDateFormatterWithYYYYMMddHHmmss;
+ (NSDateFormatter *)defaultDateFormatterWithYYYYMMdd;
+ (NSDateFormatter *)defaultDateFormatterWithYYYYMMddHHmmInChinese;

/**
 获取当天的包括“年”，“月”，“日”，“周”，“时”，“分”，“秒”的NSDateComponents
 */
- (NSDateComponents *)componentsOfDay;

- (NSInteger)year;

- (NSInteger)month;

- (NSInteger)day;

- (NSInteger)hour;

- (NSInteger)minute;

- (NSInteger)second;

- (NSInteger)weekday;

/**
 获取当天是当年的第几周
 */
- (NSInteger)weekOfDayInYear;

/**
 类似X分钟前、X天前的描述
 */
- (NSString *)timeAgoDescription;

/**
 类似星期X上午/下午的描述
 */
- (NSString *)timeBeforeDescription;

/**
 星期X的描述
 */
- (NSString *)weekdayDescription;

/**
 YYYY-MM-dd HH:mm:ss
 */
- (NSString *)timeDescriptionWithYYYYMMddHHmmss;

/**
 YYYY.MM.dd
 */
- (NSString *)timeDescriptionWithYYYYMMdd;

/**
 YYYY年MM月dd日 HH时mm分
 */
- (NSString *)timeDescriptionWithYYYYMMddHHmmInChinese;

@end
