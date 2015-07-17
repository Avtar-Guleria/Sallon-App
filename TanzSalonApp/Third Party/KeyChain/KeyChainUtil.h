//
//  KeyChainUtil.h
//  OTS
//
//  Created by Avtar Guleria on 17/04/13.
//  Copyright (c) 2013 Xavient Information System. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyChainUtil : NSObject

+(void)saveUserName:(NSString*)userName;

+(void)savePassword:(NSString*)password;

+(void)resetKeyChainItem;

+(NSString*)getUserName;

+(NSString*)getPassword;


@end
