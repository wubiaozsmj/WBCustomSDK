//
//  NSArray+Extension.h
//  WBCustomSDK
//
//  Created by 吴飚 on 16/9/21.
//  Copyright © 2016年 wubiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Extension)

/**
 是否真数组
 */
@property (nonatomic, assign, readonly) BOOL isArray;

/**
 数组转换成json
 */
@property (nonatomic, copy, readonly) NSString *jsonString;

/**
 检查是否越界和NSNull，如果是返回nil
 */
- (id)checkObjectAtIndex:(NSInteger)index;

/**
 数组比较
 */
- (BOOL)compareWithArray:(NSArray *)array;

@end
