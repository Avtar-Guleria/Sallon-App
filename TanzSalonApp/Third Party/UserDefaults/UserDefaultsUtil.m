//
//  UserDefaultsUtil
//  OTS
//
//  Created by Avtar Singh on 3/22/13.
//  Copyright (c) 2013 Xavient Information System. All rights reserved.
//

#import "UserDefaultsUtil.h"
#import "Constants.h"

@implementation UserDefaultsUtil


#pragma mark- Save Methods.

+(BOOL) saveNSObject:(NSObject*) nsObject forKey:(NSString*)key
{
    if(nsObject)
    {
        
        @try {
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:nsObject];
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
            [[NSUserDefaults standardUserDefaults] synchronize];
            return YES;
            
        }
        @catch (NSException *exception) {
            NSLog(@"Could not save--%@",exception);
        }
        
        
        
    }
    return NO;
}



/**
 MEthod to save boolean values in user defaults .
 */
+(BOOL) saveBoolValue:(BOOL)boolValue forKey:(NSString*)key
{
    @try {
        
        [[NSUserDefaults standardUserDefaults] setBool:boolValue forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
        
    }
    @catch (NSException *exception) {
        NSLog(@"Could not save--%@",exception);
    }
    
    
    return NO;
}


#pragma mark- Get Methods


+(NSObject*) getNSObjectForKey:(NSString*)key
{
    NSObject *nsObject=NULL;
    if(key)
    {
        
        @try {
            NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
            NSData *nsData = [currentDefaults objectForKey:key];
            if (nsData != nil)
            {
                nsObject = [NSKeyedUnarchiver unarchiveObjectWithData:nsData];
                
                
                return nsObject;
            }
            
        }
        @catch (NSException *exception) {
            NSLog(@"Could not retrieve--%@",exception);
        }
        
    }
    
    return nsObject;
    
}



/**
 Method to get boolean values from user defaults.
 */
+(BOOL) getBoolValue:(NSString*)key
{
    BOOL value=NO;
    if(key)
    {
        
        @try {
            NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
            
            value=[currentDefaults boolForKey:key];
        }
        @catch (NSException *exception) {
            NSLog(@"Could not retrieve--%@",exception);
        }
        
    }
    
    return value;

}
 



#pragma mark- Other Methods.
+(void) removeObjectForKey:(NSString*) key
{
    @try {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
        
    }
    @catch (NSException *exception) {
        NSLog(@"Exception =%@ i.e. Could not remove object for key--%@",[exception description], key);
    }
   
}


@end
