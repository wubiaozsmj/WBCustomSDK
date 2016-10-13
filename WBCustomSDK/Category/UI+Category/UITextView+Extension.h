//
//  UITextView+Extension.h
//  WBCustomSDK
//
//  Created by 吴飚 on 16/9/22.
//  Copyright © 2016年 wubiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Extension)

/**
 插入NSAttributedString
 */
- (void)insertAttributedText:(NSAttributedString *)text;

- (void)insertAttributedText:(NSAttributedString *)text settingBlock:(void (^)(NSMutableAttributedString *attributedText))settingBlock;

@end
