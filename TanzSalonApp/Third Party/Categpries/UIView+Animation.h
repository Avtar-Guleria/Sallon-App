//
//  UIView+Animation.h
//  Template
//
//  Created by XAV-MAC13 on 17/12/13.
//  Copyright (c) 2013 XAV-MAC13. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Animation)
-(void)fadeIn:(float)seconds;
-(void)fadeOut:(float)seconds;
-(void)moveToOrigin:(CGPoint)targetOrigin inTime:(float)seconds;
-(void)moveToX:(int)x andY:(int)y inSeconds:(int)seconds;

-(void)addSubViewWithAnimation:(UIView*)subView containerView:(UIView*)containerView;
-(void)removeViewWithAnimation:(UIView*)subView containerView:(UIView*)containerView;
@end
