//
//  UIView+Animation.m
//  Template
//
//  Created by XAV-MAC13 on 17/12/13.
//  Copyright (c) 2013 XAV-MAC13. All rights reserved.
//

#import "UIView+Animation.h"

@implementation UIView (Animation)
-(void)fadeIn:(float)seconds
{
    [UIView animateWithDuration:seconds animations:^{
        self.alpha=1;
    }];
}
-(void)fadeOut:(float)seconds
{
    [UIView animateWithDuration:seconds animations:^{
        self.alpha=0;
    }];
}
-(void)moveToOrigin:(CGPoint)targetOrigin inTime:(float)seconds
{
    [UIView animateWithDuration:seconds animations:^{
        CGRect rect=self.frame;
        rect.origin=targetOrigin;
        self.frame=rect;
        
    }];
}
-(void)moveToX:(int)x andY:(int)y inSeconds:(int)seconds
{
    
    [UIView animateWithDuration:seconds animations:^{
        CGRect rect=self.frame;
        rect.origin=CGPointMake(x, y);
        self.frame=rect;
        
    }];
}
@end
