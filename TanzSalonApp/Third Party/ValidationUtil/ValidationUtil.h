//
//  ValidationUtil.h
//  NeerBee
//
//  Created by Avtar Guleria on 11/04/14.
//  Copyright (c) 2014 Avtar Guleria. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ValidationUtil : NSObject

+(BOOL)isValidTextInTextField:(UITextField*)textField;

+(BOOL)isValidEmail:(NSString*)email;

@end
