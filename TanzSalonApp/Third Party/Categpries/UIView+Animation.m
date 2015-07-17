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


/**
 Method to add subview with Action sheet type animation
 */
-(void)addSubViewWithAnimation:(UIView*)subView containerView:(UIView*)containerView{
    
    int x_of_subview=subView.frame.origin.x;
    
    int width_of_subView=subView.frame.size.width;
    int height_of_subView=subView.frame.size.height;
    
    subView.frame=CGRectMake(x_of_subview,430+height_of_subView,width_of_subView,height_of_subView);
    
    
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         subView.frame=CGRectMake(x_of_subview,containerView.frame.size.height-subView.frame.size.height,width_of_subView,height_of_subView);
                     }
                     completion:^(BOOL finished){
                     }];
    
    
    [containerView addSubview:subView];
}


/**
 Method to remove subview with Action sheet type animation
 */
-(void)removeViewWithAnimation:(UIView*)subView containerView:(UIView*)containerView
{
    int x_of_subview=subView.frame.origin.x;
    
    int width_of_subView=subView.frame.size.width;
    int height_of_subView=subView.frame.size.height;
    
    
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         subView.frame=CGRectMake(x_of_subview,containerView.frame.size.height+subView.frame.size.height,width_of_subView,height_of_subView);
                     }
                     completion:^(BOOL finished){
                     
                         [subView removeFromSuperview];
                     }];
}


@end
