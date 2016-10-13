//
//  MyTextView.h
//  WBCustomSDK
//
//  Created by 吴飚 on 16/9/29.
//  Copyright © 2016年 wubiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTextView : UITextView

/** 提示文字 */
@property (nonatomic,copy)NSString *placeholder;
/** 提示文字的颜色 */
@property (nonatomic,strong)UIColor *placeholderColor;

@end
