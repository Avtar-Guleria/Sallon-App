//
//  UITextField+UIEnhancement.m
//  Template
//
//  Created by XAV-MAC13 on 17/12/13.
//  Copyright (c) 2013 XAV-MAC13. All rights reserved.
//

#import "UITextField+UIEnhancement.h"

@implementation UITextField (UIEnhancement)
-(void)setPadding:(int)padding
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, padding, 20)];
    self.leftView = paddingView;
    self.rightView = paddingView;
    self.leftViewMode = UITextFieldViewModeAlways;
    self.rightViewMode = UITextFieldViewModeAlways;
}
@end
