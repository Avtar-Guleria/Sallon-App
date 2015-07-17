//
//  UIView+UI.m
//  Template
//
//  Created by Sukhpal on 2/27/14.
//  Copyright (c) 2014 XAV-MAC13. All rights reserved.
//

#import "UIView+UI.h"

@implementation UIView (UI)
-(id)viewWithNib:(NSString*)nib owner:(id)owner
{
    NSArray* array=[[NSBundle mainBundle]loadNibNamed:nib owner:owner options:nil];
    return [array objectAtIndex:0];
}
@end
