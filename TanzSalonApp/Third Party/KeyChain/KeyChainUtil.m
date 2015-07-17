//
//  KeyChainUtil.m
//  OTS
//
//  Created by Avtar Guleria on 17/04/13.
//  Copyright (c) 2013 Xavient Information System. All rights reserved.
//

#import "KeyChainUtil.h"
#import "KeychainItemWrapper.h"


NSString * KEY_CHAIN_NAME=@"APP_KEYCHAIN";

@implementation KeyChainUtil


+(void)saveUserName:(NSString*)userName
{
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:KEY_CHAIN_NAME accessGroup:nil];
    
    [keychainItem setObject:userName forKey:(__bridge id)(kSecAttrAccount)];
}


+(NSString*)getUserName
{
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:KEY_CHAIN_NAME accessGroup:nil];
    
    return [keychainItem objectForKey:(__bridge id)(kSecAttrAccount)];
}




+(void)savePassword:(NSString*)password
{
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:KEY_CHAIN_NAME accessGroup:nil];
    
    [keychainItem setObject:password forKey:(__bridge id)(kSecValueData)];
}



+(NSString*)getPassword
{
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:KEY_CHAIN_NAME accessGroup:nil];
    
    return [keychainItem objectForKey:(__bridge id)(kSecValueData)];
}




+(void)resetKeyChainItem
{

    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:KEY_CHAIN_NAME accessGroup:nil];
    
    
   [keychainItem resetKeychainItem];

}


@end
