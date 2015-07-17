//
//  JsonUtil
//  OTS
//
//  Created by Avtar Singh on 3/21/13.
//  Copyright (c) 2013 Xavient Information System. All rights reserved.
//




#import "JsonUtil.h"
#import "SBJsonWriter.h"
#import "SBJson.h"


@implementation JsonUtil


/**
 Method to return NSString value for the key in Json Object (NSMutableDictionary)
 
 *Input- NSMutableDictionary and NSString key.
 *Output - value for key if present in dictionary or nil value if not present.
 */
 
+(NSString*)getString:(NSMutableDictionary*)dictonary forKey:(NSString*)key
{
    @try {
         
    NSString* valueForKey = [dictonary objectForKey:key];
    
    if ((NSNull*)valueForKey == [NSNull null])
    {
        return  nil; 
    }
    else
    {
        return valueForKey;   
    }
    
    }
    @catch (NSException *exception) {
        NSLog(@"Exception::%@",[exception description]);
    }
    
    
    return nil;
}

/**
 Method to return NSDecimalNumber value for the key in Json Object (NSMutableDictionary)
 
 *Input- NSMutableDictionary and NSString key.
 *Output - value for key if present in dictionary or nil value if not present.
 */

+(NSDecimalNumber*)getDecimalNumber:(NSMutableDictionary*)dictionary forKey:(NSString*)key
{
    
    @try {
        
        NSDecimalNumber* valueForKey = [dictionary objectForKey:key];
        
        if ((NSNull*)valueForKey == [NSNull null])
        {
            return  nil; 
        }
        else
        {
            return valueForKey;   
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"Exception::%@",[exception description]);
    }
    
    
    return nil;

}

/**
 Method to return BOOL value for the key in Json Object (NSMutableDictionary)
 
 *Input- NSMutableDictionary and NSString key.
 *Output - value for key if present in dictionary or nil value if not present.
 */

+(BOOL)getBoolean:(NSMutableDictionary*)dictonary forKey:(NSString*)key
{
    @try {
        
        BOOL valueForKey = [[dictonary objectForKey:key] boolValue];
        
        return valueForKey;
                
    }
    @catch (NSException *exception) {
        NSLog(@"Exception::%@",[exception description]);
    }
    
    
    return NO;
}
/**
 Method to get Json String format for NSMutable Dictionary object.
 */
+(NSString*)getJsonStringFromDictionary:(NSDictionary*)dictionary{
    SBJsonWriter *jsonWriter = [SBJsonWriter new];
    
    NSString *jsonString =[[NSString alloc]init];
  
    @try {
        if(dictionary){
            jsonString = [[NSString alloc]initWithString:[jsonWriter stringWithObject:dictionary]];
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"%@",[exception description]);
    }
   
    return jsonString;
}


/**
 Method to get NSMutableDictionary form json String
 */
+(NSMutableDictionary*)getMutableDictionaryFromJsonString:(NSString*)jsonString
{
    NSMutableDictionary *jsonDictionary=nil;
    
    if(jsonString){
    
        
        
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"+" withString:@" "];
        jsonString = [jsonString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        jsonString = [jsonString stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:@""];
        int lastChar = [jsonString length]-1;
        jsonString = [jsonString stringByReplacingCharactersInRange:NSMakeRange(lastChar,1) withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\\" withString:@""];

        NSLog(@"%@",jsonString);
        
        NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
        NSError *error;
    
        jsonDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:0
                                                                     error:&error];
    
        if (error)
        {
            NSLog(@"[JsonUtil] Error converting JsonString to Dictonary=%@", [error description]);
        }
    
    }
    return jsonDictionary;
}

/**
 Method to set object in NSMutableDictionary.
 */
+(NSMutableDictionary*)setObjectInDictionary:(NSMutableDictionary*)dictionary forKey:(NSString*)key value:(id)value
{
    @try {
        //removed nil check so that it can throw exception. and the user will be notified. 
        [dictionary setObject:value forKey:key];      
        
    }
    @catch (NSException *exception) {
        NSLog(@"%@",[exception description]);
    }
    
    return dictionary;
}



@end
