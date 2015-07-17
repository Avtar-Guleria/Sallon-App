//
//  UserDefaultsUtil
//  OTS
//
//  Created by Avtar Singh on 3/22/13.
//  Copyright (c) 2013 Xavient Information System. All rights reserved.
//


#import <Foundation/Foundation.h>
@interface UserDefaultsUtil : NSObject



//Save values
+(BOOL) saveNSObject:(NSObject*)nsObject forKey:(NSString*)key;
+(BOOL) saveBoolValue:(BOOL)boolValue forKey:(NSString*)key;


//Get Values
+(NSObject*) getNSObjectForKey:(NSString*)key;
+(BOOL) getBoolValue:(NSString*)key;


//Other Methods.
+(void) removeObjectForKey:(NSString*) key;

@end
