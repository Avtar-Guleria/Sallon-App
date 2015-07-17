//
//  ValidationUtil.m
//  NeerBee
//
//  Created by Avtar Guleria on 11/04/14.
//  Copyright (c) 2014 Avtar Guleria. All rights reserved.
//

#import "ValidationUtil.h"

@implementation ValidationUtil


+(BOOL)isValidTextInTextField:(UITextField*)textField
{
    if([[textField.text trim] length]>0){
        return  YES;
    }
    
    return NO;
}



+(BOOL)isValidEmail:(NSString*)email{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
@end
