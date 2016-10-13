//
//  UIViewController+Extension.h
//  WBCustomSDK
//
//  Created by 吴飚 on 16/9/22.
//  Copyright © 2016年 wubiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Extension)<CAAnimationDelegate>

/**
 push默认动画
 */
- (void)pushViewController:(UIViewController *)viewController;

/**
 push其它动画
 */
- (void)pushViewController:(UIViewController *)viewController animateType:(NSInteger)row;

@end
