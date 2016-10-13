//
//  UIViewController+Extension.m
//  WBCustomSDK
//
//  Created by 吴飚 on 16/9/22.
//  Copyright © 2016年 wubiao. All rights reserved.
//

#import "UIViewController+Extension.h"

@implementation UIViewController (Extension)

/**
 push默认动画
 */
- (void)pushViewController:(UIViewController *)viewController
{
    [self.navigationController pushViewController:viewController animated:YES];
}

/**
 push其它动画
 */
- (void)pushViewController:(UIViewController *)viewController animateType:(NSInteger)row
{
    if (row < 4)
    {
        //UIView Animation
        CGContextRef context = UIGraphicsGetCurrentContext();
        [UIView beginAnimations:nil context:context];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.35];
        [self.navigationController pushViewController:viewController animated:NO];
        switch (row)
        {
            case 0:
                [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.navigationController.view cache:YES];
                break;
            case 1:
                [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.navigationController.view cache:YES];
                break;
            case 2:
                [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:YES];
                break;
            case 3:
                [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:YES];
                break;
            default:
                break;
        }
        [UIView commitAnimations];
    }
    else
    {
        //core animation
        CATransition *animation = [CATransition animation];
        animation.delegate = self;
        animation.duration = 0.35;
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.subtype = kCATransitionFromLeft;
        switch (row)
        {
            case 4:
                animation.type = kCATransitionReveal;
                break;
            case 5:
                animation.type = kCATransitionMoveIn;
                break;
            case 6:
                animation.type = @"cube";
                break;
            case 7:
                animation.type = @"suckEffect";
                break;
            case 8:
                animation.type = @"rippleEffect";
                break;
            case 9:
                animation.type = @"pageCurl";
                break;
            case 10:
                animation.type = @"pageUnCurl";
                break;
            case 11:
                animation.type = kCATransitionFade;
                break;
            case 12:
                animation.type = kCATransitionMoveIn;
                animation.subtype = kCATransitionFromTop;
                break;
            default:
                break;
        }
        
        [self.navigationController pushViewController:viewController animated:NO];
        [[self.navigationController.view layer] addAnimation:animation forKey:@"animation"];
    }
}

@end
