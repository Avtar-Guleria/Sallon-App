//
//  BaseParser.m
//  NightBird
//
//  Created by Avtar Guleria on 19/03/14.
//  Copyright (c) 2014 Avtar Guleria. All rights reserved.
//

#import "BaseParser.h"

@implementation BaseParser


+(NSString*) getString:(NSDictionary*)jsonObject forKey:(NSString*)key {
    NSString* value = nil;
    @try {
        if(jsonObject)
        {
            value=[jsonObject valueForKey:key];
            
            
            if((NSNull*)value==[NSNull null]){
                value=nil;
            }
            
        }
    } @catch (NSException* e) {
        NSLog(@"%@",e);
    }
    return value;
}
+(NSDictionary*) getDictionary:(NSDictionary*) jsonObject forKey:(NSString*)key {
    NSDictionary* value = nil;
    @try {
        if(jsonObject)
        {
            value=[jsonObject valueForKey:key];
            
            
            if((NSNull*)value==[NSNull null]){
                value=nil;
            }
        }
    } @catch (NSException* e) {
        NSLog(@"%@",e);
    }
    return value;
}
+(NSMutableArray*) getArray:(NSDictionary*) jsonObject forKey:(NSString*)key {
    NSMutableArray* value = nil;
    @try {
        if(jsonObject)
        {
            value=[jsonObject valueForKey:key];
            
            
            if((NSNull*)value==[NSNull null]){
                value=nil;
            }
            
        }
    } @catch (NSException* e) {
        NSLog(@"%@",e);
    }
    return value;
}
+(NSNumber*) getNumber:(NSDictionary*) jsonObject forKey:(NSString*)key {
    NSNumber* value = nil;
    @try {
        if(jsonObject)
        {
            value=[jsonObject valueForKey:key];
            
            
            if((NSNull*)value==[NSNull null]){
                value=nil;
            }
        }
    } @catch (NSException* e) {
        NSLog(@"%@",e);
    }
    return value;
}


@end
