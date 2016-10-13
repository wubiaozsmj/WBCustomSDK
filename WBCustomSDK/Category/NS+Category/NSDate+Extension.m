//
//  NSDate+Extension.m
//  WBCustomSDK
//
//  Created by 吴飚 on 16/9/21.
//  Copyright © 2016年 wubiao. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

/**
 时间戳字符串
 */
- (NSString *)timeStampString
{
    return [@([self timeIntervalSince1970]).stringValue copy];
}

/**
 时间戳长整型
 */
- (double)timeStamp
{
    return [self timeIntervalSince1970];
}

/**
 时间成分
 */
- (NSDateComponents *)components
{
    //创建日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //定义成分
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self];
}

/**
 是否为今年/昨天/今天
 */
- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 获得某个时间的年月日时分秒
    NSDateComponents *dateCmps = [calendar components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *nowCmps = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    return dateCmps.year == nowCmps.year;
}

- (BOOL)isYesterday
{
    NSDate *now = [NSDate date];
    
    // date ==  2014-04-30 10:05:28 --> 2014-04-30 00:00:00
    // now == 2014-05-01 09:22:10 --> 2014-05-01 00:00:00
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    // 2014-04-30
    NSString *dateStr = [fmt stringFromDate:self];
    // 2014-10-18
    NSString *nowStr = [fmt stringFromDate:now];
    
    // 2014-10-30 00:00:00
    NSDate *date = [fmt dateFromString:dateStr];
    // 2014-10-18 00:00:00
    now = [fmt dateFromString:nowStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:date toDate:now options:0];
    
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}

- (BOOL)isToday
{
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:now];
    
    return [dateStr isEqualToString:nowStr];
}

/**
 比较两个时间
 
 @param unit     成分单元
 @param fromDate 起点时间
 @param toDate   终点时间
 
 @return 时间成分对象
 */
+ (NSDateComponents *)compareDateComponents:(NSCalendarUnit)unit fromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
    //创建日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    //直接计算
    NSDateComponents *components = [calendar components:unit fromDate:fromDate toDate:toDate options:0];
    
    return components;
}

/**
 根据年、月、日、时、分、秒返回NSDate
 
 @param year   年
 @param month  月
 @param day    日
 @param hour   时
 @param minute 分
 @param second 秒
 */
+ (NSDate *)dateWithYear:(NSInteger)year Month:(NSInteger)month Day:(NSInteger)day Hour:(NSInteger)hour Minute:(NSInteger)minute Second:(NSInteger)second
{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:[NSDate date]];
    dateComponents.year = year;
    dateComponents.month = month;
    dateComponents.day = day;
    dateComponents.hour = hour;
    dateComponents.minute = minute;
    dateComponents.second = second;
    
    return [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
}

/**
 NSDateFormatter单例方法
 
 @return 相应格式的NSDateFormatter对象
 */
+ (NSDateFormatter *)defaultDateFormatterWithYYYYMMddHHmmss
{
    static NSDateFormatter *dateFormatter;
    if (!dateFormatter)
    {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    }
    return dateFormatter;
}

+ (NSDateFormatter *)defaultDateFormatterWithYYYYMMdd
{
    static NSDateFormatter *dateFormatter;
    if (!dateFormatter)
    {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYY.MM.dd"];
    }
    return dateFormatter;
}

+ (NSDateFormatter *)defaultDateFormatterWithYYYYMMddHHmmInChinese
{
    static NSDateFormatter *dateFormatter;
    if (!dateFormatter)
    {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYY年MM月dd日 HH:mm"];
    }
    return dateFormatter;
}

/**
 获取当天的包括“年”，“月”，“日”，“周”，“时”，“分”，“秒”的NSDateComponents
 */
- (NSDateComponents *)componentsOfDay
{
    return [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:self];
}

- (NSInteger)year
{
    return [self componentsOfDay].year;
}

- (NSInteger)month
{
    return [self componentsOfDay].month;
}

- (NSInteger)day
{
    return [self componentsOfDay].day;
}

- (NSInteger)hour
{
    return [self componentsOfDay].hour;
}

- (NSInteger)minute
{
    return [self componentsOfDay].minute;
}

- (NSInteger)second
{
    return [self componentsOfDay].second;
}

- (NSInteger)weekday
{
    return [self componentsOfDay].weekday;
}

/**
 获取当天是当年的第几周
 */
- (NSInteger)weekOfDayInYear
{
    return [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitWeekOfYear inUnit:NSCalendarUnitYear forDate:self];
}

/**
 类似X分钟前、X天前的描述
 */
- (NSString *)timeAgoDescription
{
    if (self == nil)
    {
        return @"";
    }
    NSTimeInterval timeInterval = -[self timeIntervalSinceNow];
    long temp = 0;
    NSString *result;
    if (timeInterval < 60)
    {
        result = [NSString stringWithFormat:@"1分钟内"];
    }
    else if ((temp = timeInterval / 60) < 60)
    {
        result = [NSString stringWithFormat:@"%ld分钟前", temp];
    }
    else if ((temp = temp / 60) < 24)
    {
        result = [NSString stringWithFormat:@"%ld小时前", temp];
    }
    else if ((temp = temp / 24) < 30)
    {
        result = [NSString stringWithFormat:@"%ld天前", temp];
    }
    else if ((temp = temp / 30) < 12)
    {
        result = [NSString stringWithFormat:@"%ld个月前", temp];
    }
    else
    {
        temp = temp / 12;
        result = [NSString stringWithFormat:@"%ld年前", temp];
    }
    return result;
}

/**
 类似星期X上午/下午的描述
 */
- (NSString *)timeBeforeDescription
{
    if (self == nil) {
        return @"";
    }
    NSDate *yesterday = [[NSDate date] dateByAddingTimeInterval:-(24 * 60 * 60)];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitDay;
    NSDateComponents *Compareday = [calendar components:unitFlags fromDate:self];
    NSDateComponents *Yesterday = [calendar components:unitFlags fromDate:yesterday];
    NSDateComponents *Today = [calendar components:unitFlags fromDate:[NSDate date]];
    
    NSDateFormatter *F_Mon_Day = [[NSDateFormatter alloc] init];
    [F_Mon_Day setDateFormat:@"MM-dd"];
    NSDateFormatter *F_H_M = [[NSDateFormatter alloc] init];
    [F_H_M setDateFormat:@"HH:mm"];
    NSString *S_H = [[F_H_M stringFromDate:self] substringWithRange:NSMakeRange(0, 2)];
    NSString *S_M = [[F_H_M stringFromDate:self] substringWithRange:NSMakeRange(3, 2)];
    NSString *sunormoon = @"";
    NSInteger Hour = [S_H integerValue];
    
    if (Hour >= 3 && Hour < 6)
    {
        sunormoon = @"凌晨";
    }
    else if (Hour >= 6 && Hour < 8)
    {
        sunormoon = @"早上";
    }
    else if (Hour >= 8 && Hour < 11)
    {
        sunormoon = @"上午";
    }
    else if (Hour >= 11 && Hour < 14)
    {
        sunormoon = @"中午";
    }
    else if (Hour >= 14 && Hour < 19)
    {
        sunormoon = @"下午";
    }
    else if (Hour >= 19)
    {
        sunormoon = @"晚上";
    }
    else if (Hour >= 0 && Hour < 3)
    {
        sunormoon = @"深夜";
    }
    
    if (Hour > 12) {
        Hour = Hour - 12;
    }
    
    NSString *Mon_Day = [F_Mon_Day stringFromDate:self];
    NSString *Hou_Min = [NSString stringWithFormat:@"%@ %d:%@", sunormoon, (int) Hour, S_M];
    NSString *Week = [self weekdayDescription];
    NSTimeInterval oldtime = [self timeIntervalSince1970];
    NSTimeInterval nowTime = [[NSDate date] timeIntervalSince1970];
    
    if ([[[NSCalendar autoupdatingCurrentCalendar] components:NSCalendarUnitYear fromDate:self] year] != [[[NSCalendar autoupdatingCurrentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]] year]) {
        [F_Mon_Day setDateFormat:@"YYYY-MM-dd"];
        Mon_Day = [F_Mon_Day stringFromDate:self];
    }
    
    if ([Today day] == [Compareday day]) {
        return [NSString stringWithFormat:@"%@", Hou_Min];
    }
    
    if ([Yesterday day] == [Compareday day]) {
        return [NSString stringWithFormat:@"昨天  %@", Hou_Min];
    }
    
    if ((nowTime - oldtime) / 60 / 60 / 24 >= 7) {
        return [NSString stringWithFormat:@"%@   %@", Mon_Day, Hou_Min];
    }
    
    if ((nowTime - oldtime) / 60 / 60 / 24 < 7) {
        return [NSString stringWithFormat:@"%@  %@", Week, Hou_Min];
    }
    
    return [NSString stringWithFormat:@"%@   %@", Mon_Day, Hou_Min];
}

/**
 星期X的描述
 */
- (NSString *)weekdayDescription
{
    NSDateComponents *componets = [[NSCalendar autoupdatingCurrentCalendar] components:NSCalendarUnitWeekday fromDate:self];
    int weekday = (int) [componets weekday]; //a就是星期几，1代表星期日，2代表星期一，后面依次
    switch (weekday) {
        case 1:
            return @"星期日";
            break;
        case 2:
            return @"星期一";
            break;
        case 3:
            return @"星期二";
            break;
        case 4:
            return @"星期三";
            break;
        case 5:
            return @"星期四";
            break;
        case 6:
            return @"星期五";
            break;
        case 7:
            return @"星期六";
            break;
            
        default:
            break;
    }
    
    return @"";
}

/**
 YYYY-MM-dd HH:mm:ss
 */
- (NSString *)timeDescriptionWithYYYYMMddHHmmss
{
    return [[NSDate defaultDateFormatterWithYYYYMMddHHmmss] stringFromDate:self];
}

/**
 YYYY.MM.dd
 */
- (NSString *)timeDescriptionWithYYYYMMdd
{
    return [[NSDate defaultDateFormatterWithYYYYMMdd] stringFromDate:self];
}

/**
 YYYY年MM月dd日 HH时mm分
 */
- (NSString *)timeDescriptionWithYYYYMMddHHmmInChinese
{
    return [[NSDate defaultDateFormatterWithYYYYMMddHHmmInChinese] stringFromDate:self];
}

@end
