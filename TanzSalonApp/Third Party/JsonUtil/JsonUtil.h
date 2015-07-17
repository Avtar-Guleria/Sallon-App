//
//  JsonUtil
//  OTS
//
//  Created by Avtar Singh on 3/21/13.
//  Copyright (c) 2013 Xavient Information System. All rights reserved.
//




#import <Foundation/Foundation.h>

@interface JsonUtil : NSObject


+(NSString*)getString:(NSMutableDictionary*)dictonary forKey:(NSString*)key;

//Method to get Decimal NUmber i.e. int type from json
+(NSDecimalNumber*)getDecimalNumber:(NSMutableDictionary*)dictionary forKey:(NSString*)key;

//MEthod to get Boolean from dictonary.
+(BOOL)getBoolean:(NSMutableDictionary*)dictonary forKey:(NSString*)key;


//Method to get Json String from Dictonary.
+(NSString*)getJsonStringFromDictionary:(NSDictionary*)dictionary;

//Method to get Mutable Dictionary from Json String.
+(NSMutableDictionary*)getMutableDictionaryFromJsonString:(NSString*)jsonString;

//Method to set Object in Dictonary.
+(NSMutableDictionary*)setObjectInDictionary:(NSMutableDictionary*)dictionary forKey:(NSString*)key value:(id)value;
@end
