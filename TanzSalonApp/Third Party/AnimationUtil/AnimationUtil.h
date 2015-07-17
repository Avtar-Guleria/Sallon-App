//
//  AnimationUtil.h
//  TigerVeda
//
//  Created by Avtar Guleria on 30/03/14.
//  Copyright (c) 2014 Avtar Guleria. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnimationUtil : NSObject

+(void)addSubViewWithAnimation:(UIView*)subView containerView:(UIView*)containerView;
+(void)removeViewWithAnimation:(UIView*)subView containerView:(UIView*)containerView;
@end
