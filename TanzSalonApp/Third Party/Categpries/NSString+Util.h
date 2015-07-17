//
//  NSString+Util.h
//  Template
//
//  Created by XAV-MAC13 on 17/12/13.
//  Copyright (c) 2013 XAV-MAC13. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Util)
-(NSString*)trim;
-(BOOL)contains:(NSString*)string;

-(BOOL)isUrl;
-(BOOL)isEmail;
-(BOOL)isNumber;

-(NSString*)toDateFormat:(NSString*)toDateFormat from:(NSString*)fromDateFormat;

-(NSString*)reverse;
-(BOOL)isValidUsername;
-(NSString *)toBase64String;

@end
