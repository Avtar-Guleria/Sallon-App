//
//  BaseParser.h
//  NightBird
//
//  Created by Avtar Guleria on 19/03/14.
//  Copyright (c) 2014 Avtar Guleria. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseParser : NSObject


+(NSString*) getString:(NSDictionary*)jsonObject forKey:(NSString*)key ;
+(NSDictionary*) getDictionary:(NSDictionary*) jsonObject forKey:(NSString*)key ;
+(NSMutableArray*) getArray:(NSDictionary*) jsonObject forKey:(NSString*)key ;
+(NSNumber*) getNumber:(NSDictionary*) jsonObject forKey:(NSString*)key;

@end
