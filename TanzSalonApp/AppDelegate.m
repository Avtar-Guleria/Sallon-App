//
//  AppDelegate.m
//  TanzSalonApp
//
//  Created by Avtar Guleria on 04/03/14.
//  Copyright (c) 2014 Avtar Guleria. All rights reserved.
//

#import "AppDelegate.h"
#import "Reachability.h"
#import "Constants.h"
#import "SalonData.h"
#import "SalonParser.h"
#import "SalonRoot.h"



@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
   [NSThread sleepForTimeInterval:5];
   /* if ([[UIApplication sharedApplication]respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
    {
        // iOS 8 Notifications
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else{
        // iOS < 8 Notifications
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }*/
    
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    }
    
    
    [self getNearBySalons];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    
    NSString *deviceTokenString = [NSString
                                   
                                   stringWithFormat:@"%@",deviceToken];
    
    
    deviceTokenString  = [deviceTokenString stringByReplacingOccurrencesOfString:@" " withString:@""];
    deviceTokenString  = [deviceTokenString stringByReplacingOccurrencesOfString:@"<" withString:@""];
    deviceTokenString  = [deviceTokenString stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"token is: %@", deviceTokenString);
    
    NSString *url=[NSString stringWithFormat:@"http://appguv.com/saloon-app/webservices/webservice.php?method=addDevice&deviceID=%@&deviceType=iphone&deviceToken=%@",[self identifierForVendor],deviceTokenString];
    
    [self sendHttpGetRequest:url andRequestId:107];
    
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
	NSLog(@"Failed to get token, error: %@", error);
}


-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"%@",userInfo.description);
    
    if (userInfo != nil)
    {
        UIAlertView* alert=[[UIAlertView alloc]initWithTitle:@"Notification" message:[[userInfo objectForKey:@"aps"] objectForKey:@"alert"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}


- (NSString *) identifierForVendor
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(identifierForVendor)]) {
        return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    }
    return @"1235";
}

-(void)sendHttpGetRequest:(NSString*)url andRequestId:(int)requestId
{
    if ([self isInternetAvailable]) {
        
        NSOperationQueue* operationQueue=[[NSOperationQueue alloc]init];
        [operationQueue addOperation:[NSBlockOperation blockOperationWithBlock:^{
            NSMutableURLRequest* request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
            [request setTimeoutInterval:90];
            NSError* error=nil;
            
            
            
            NSData* data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSString* jsonString=[[NSString alloc]initWithData:data encoding:NSASCIIStringEncoding];
                jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                
                NSLog(@"URL=%@",url);
                NSLog(@"Response =%@",jsonString);
                
            });
            
            
        }]];
        
    }
}

-(BOOL) isInternetAvailable
{
    Reachability* reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    switch (netStatus)
    {
        case NotReachable: {
            return NO;
            break;
        }
    }
    return YES;
    
}


-(void)getNearBySalons{
    
    NSNumber *lat=(NSNumber*)[UserDefaultsUtil getNSObjectForKey:@"latitude"] ;
    NSNumber *longitude=(NSNumber*)[UserDefaultsUtil getNSObjectForKey:@"longitude"] ;
    
    NSString *url=nil;
    
    if(lat.floatValue==0.f ||longitude.floatValue==0.f){
        url=[NSString stringWithFormat:@"http://appguv.com/saloon-app/webservices/webservice.php?method=getSaloonsByUserLocation&latitude=%f&longitude=%f",[lat floatValue],[longitude floatValue]];
        
//          url=@"http://appguv.com/saloon-app/webservices/webservice.php?method=getAllSaloons";
    }else{
     
         url=[NSString stringWithFormat:@"http://appguv.com/saloon-app/webservices/webservice.php?method=getSaloonsByUserLocation&latitude=%f&longitude=%f",[lat floatValue],[longitude floatValue]];
    }
    
    
    
    if ([self isInternetAvailable]) {
        
        NSOperationQueue* operationQueue=[[NSOperationQueue alloc]init];
        [operationQueue addOperation:[NSBlockOperation blockOperationWithBlock:^{
            NSMutableURLRequest* request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
            [request setTimeoutInterval:90];
            NSError* error=nil;
            
            
            
            NSData* data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSString* jsonString=[[NSString alloc]initWithData:data encoding:NSASCIIStringEncoding];
                jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                
                NSLog(@"URL=%@",url);
               
                
               SalonRoot* salonRoot=[SalonParser parseSalons:data];
                
                if(salonRoot){
                    if([salonRoot.responseCode isEqualToString:@"200"]){
                        if (salonRoot && salonRoot.data.count>0) {
                            self.nearBySalons=salonRoot.data;
                        }
                    }
                }

            });
            
            
        }]];
        
    }
    
}




@end
