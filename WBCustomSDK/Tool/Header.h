//
//  Header.h
//  WBCustomSDK
//
//  Created by 吴飚 on 16/9/22.
//  Copyright © 2016年 wubiao. All rights reserved.
//

#ifndef Header_h
#define Header_h

/**
 系统版本号（double类型）
 */
#define SYSTEM_VERSION [[UIDevice currentDevice].systemVersion doubleValue]

/**
 本地plist对象，缓存用户数据等
 */
#define USERDEFAULTS [NSUserDefaults standardUserDefaults]

/**
 弱引用声明
 */
#define WEAKSELF __weak __typeof(self) weakSelf = self;

/**
 AppDelegate代理对象，可用于传值
 */
#define APPDELEGATE ((AppDelegate *) [[UIApplication sharedApplication] delegate])

/**
 状态栏高度
 */
#define kStatusBarHeight 20

/**
 导航栏高度
 */
#define kNavigationBarHeight 44

/**
 状态栏+导航栏高度
 */
#define kStatusNavigationBarHeight 64

/**
 标签栏高度
 */
#define kTabBarHeight 49

/**
 屏幕宽度
 */
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

/**
 屏幕高度
 */
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

/**
 字符串是否为空
 */
#define kStringIsEmpty(string) ([string isKindOfClass:[NSNull class]] || [string length] < 1 ? YES : NO || [string isEqualToString:@"(null)"] || [string isEqualToString:@"null"])

/**
 随机颜色
 */
#define kRandomColor [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1.0]

/**
 RGB方式设置颜色
 */
#define kRGBColor(r, g, b) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1.0]

/**
 十六进制颜色值设置颜色
 */
#define kColor(X) [UIColor colorWithRed:((float) ((X & 0xFF0000) >> 16)) / 255.0 green:((float) ((X & 0xFF00) >> 8)) / 255.0 blue:((float) (X & 0xFF)) / 255.0 alpha:1.0]

#endif /* Header_h */
