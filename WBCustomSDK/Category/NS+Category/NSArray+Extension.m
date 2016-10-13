//
//  NSArray+Extension.m
//  WBCustomSDK
//
//  Created by 吴飚 on 16/9/21.
//  Copyright © 2016年 wubiao. All rights reserved.
//

#import "NSArray+Extension.h"

@implementation NSArray (Extension)

/**
 是否真数组
 */
- (BOOL)isArray
{
    return [self isKindOfClass:[NSArray class]];
}

/**
 数组转换成json
 */
- (NSString *)jsonString
{
    return [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:self options:0 error:NULL] encoding:NSUTF8StringEncoding];
}

/**
 检查是否越界和NSNull，如果是返回nil
 */
- (id)checkObjectAtIndex:(NSInteger)index
{
    if (index < self.count)
    {
        return self[index];
    }
    else
    {
        return nil;
    }
}

/**
 数组比较
 */
- (BOOL)compareWithArray:(NSArray *)array
{
    NSSet *set1 = [NSSet setWithArray:self];
    NSSet *set2 = [NSSet setWithArray:array];
    return [set1 isEqualToSet:set2];
}

@end
