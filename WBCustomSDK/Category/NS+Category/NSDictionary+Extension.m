//
//  NSDictionary+Extension.m
//  WBCustomSDK
//
//  Created by 吴飚 on 16/9/21.
//  Copyright © 2016年 wubiao. All rights reserved.
//

#import "NSDictionary+Extension.h"

@implementation NSDictionary (Extension)

- (NSString *)jsonString
{
    return [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:self options:0 error:NULL] encoding:NSUTF8StringEncoding];
}

@end
