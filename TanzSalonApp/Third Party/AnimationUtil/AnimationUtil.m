//
//  AnimationUtil.m
//  TigerVeda
//
//  Created by Avtar Guleria on 30/03/14.
//  Copyright (c) 2014 Avtar Guleria. All rights reserved.
//

#import "AnimationUtil.h"

@implementation AnimationUtil
/**
 Method to add subview with Action sheet type animation
 */
+(void)addSubViewWithAnimation:(UIView*)subView containerView:(UIView*)containerView{
    
    int x_of_subview=subView.frame.origin.x;
    
    int width_of_subView=subView.frame.size.width;
    int height_of_subView=subView.frame.size.height;
    
    subView.frame=CGRectMake(x_of_subview,430+height_of_subView,width_of_subView,height_of_subView);
    
    
    [UIView animateWithDuration:0.6
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseInOut
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
+(void)removeViewWithAnimation:(UIView*)subView containerView:(UIView*)containerView
{
    int x_of_subview=subView.frame.origin.x;
    
    int width_of_subView=subView.frame.size.width;
    int height_of_subView=subView.frame.size.height;
    
    
    [UIView animateWithDuration:0.6
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         subView.frame=CGRectMake(x_of_subview,containerView.frame.size.height+subView.frame.size.height,width_of_subView,height_of_subView);
                     }
                     completion:^(BOOL finished){
                         
                         [subView removeFromSuperview];
                     }];
}


@end
