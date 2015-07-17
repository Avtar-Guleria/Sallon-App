//
//  UIViewController+Network.m
//  Template
//
//  Created by XAV-MAC13 on 17/12/13.
//  Copyright (c) 2013 XAV-MAC13. All rights reserved.
//
#define kMessageInternetNotAvailable @"Internet connection is not available"
#import "UIViewController+Network.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
@implementation UIViewController (Network)
-(void)sendHttpGetRequest:(NSString*)url
{
    [self sendHttpGetRequest:url andRequestId:-100];
}
-(void)sendHttpPostRequestWith:(NSString*)url andParameters:(NSDictionary*)dictionary
{
    [self sendHttpPostRequestWith:url andParameters:dictionary andRequestId:-100];
    
}
-(void)sendHttpMultipartRequest:(NSString*)url andParameters:(NSDictionary*)dictionary progressView:(UIProgressView*)progressView
{
    [self sendHttpMultipartRequest:url andParameters:dictionary progressView:progressView andRequestId:-100];
}
-(void)didReceiveData:(NSData*)data
{
    
}

-(void)sendHttpGetRequest:(NSString*)url andRequestId:(int)requestId
{
    if ([self isInternetAvailable]) {
        MBProgressHUD* hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText=@"Loading...";
        NSOperationQueue* operationQueue=[[NSOperationQueue alloc]init];
        [operationQueue addOperation:[NSBlockOperation blockOperationWithBlock:^{
            NSMutableURLRequest* request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
            [request setTimeoutInterval:90];
            NSError* error=nil;
            NSData* data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self didReceiveData:data error:error andRequestId:requestId];
                
            });
            
            
        }]];
        
    }
}
-(void)basicAuthentication:(NSString*)url andRequestId:(int)requestId username:(NSString*)username password:(NSString*)pwd
{
    if ([self isInternetAvailable]) {
        MBProgressHUD* hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText=@"Loading...";
        NSOperationQueue* operationQueue=[[NSOperationQueue alloc]init];
        [operationQueue addOperation:[NSBlockOperation blockOperationWithBlock:^{
            ASIHTTPRequest* request=[[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:url]];
            request.requestMethod=@"GET";
            [request addRequestHeader:@"Content-Type" value:@"application/json"];
            [request addRequestHeader:@"Accept" value:@"application/json"];
            [request addRequestHeader:@"Authorization" value:[NSString stringWithFormat:@"Basic %@",[ASIHTTPRequest base64forData:[[NSString stringWithFormat:@"%@:%@",username,pwd] dataUsingEncoding:NSUTF8StringEncoding]]]];
            [request startSynchronous];
            NSError* error=request.error;
            NSData* data=request.responseData;
            NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self didReceiveData:data error:error andRequestId:requestId];
                
            });
            
            
        }]];
        
        
        
    }
}
-(void)basicAuthenticationPost:(NSString*)url andRequestId:(int)requestId username:(NSString*)username password:(NSString*)pwd params:(NSMutableDictionary*)dictionary
{
    if ([self isInternetAvailable]) {
        MBProgressHUD* hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText=@"Loading...";
        NSOperationQueue* operationQueue=[[NSOperationQueue alloc]init];
        [operationQueue addOperation:[NSBlockOperation blockOperationWithBlock:^{
            ASIHTTPRequest* request=[[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:url]];
            request.requestMethod=@"GET";
            [request addRequestHeader:@"Content-Type" value:@"application/json"];
            [request addRequestHeader:@"Accept" value:@"application/json"];
            [request addRequestHeader:@"Authorization" value:[NSString stringWithFormat:@"Basic %@",[ASIHTTPRequest base64forData:[[NSString stringWithFormat:@"%@:%@",username,pwd] dataUsingEncoding:NSUTF8StringEncoding]]]];
            [request startSynchronous];
            NSError* error=request.error;
            NSData* data=request.responseData;
            NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self didReceiveData:data error:error andRequestId:requestId];
                
            });
            
            
        }]];
        
        
        
    }
}
-(NSString*)  encodeUsernamePassword:(NSString*)username :(NSString*)pwd {
    NSString* string = [NSString stringWithFormat:@"%@:%@",username,pwd];
    return string;
}
-(void)sendHttpPostRequestWith:(NSString*)url andParameters:(NSDictionary*)dictionary andRequestId:(int)requestId
{
    if ([self isInternetAvailable]) {
        MBProgressHUD* hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText=@"Loading...";
        NSOperationQueue* operationQueue=[[NSOperationQueue alloc]init];
        [operationQueue addOperation:[NSBlockOperation blockOperationWithBlock:^{
            ASIFormDataRequest* request=[[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:url]];
            for (NSString* key in dictionary.allKeys) {
                [request setPostValue:[dictionary valueForKey:key] forKey:key];
            }
            [request startSynchronous];
            NSError* error=request.error;
            NSData* data=request.responseData;
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self didReceiveData:data error:error andRequestId:requestId];
                
            });
            
            
        }]];
        
    }
    
}
-(void)sendHttpPostJsonRequestWith:(NSString*)url jsonData:(NSMutableDictionary*)dictionary andRequestId:(int)requestId
{
    if ([self isInternetAvailable]) {
 
        NSLog(@"URL:%@",url);
        
        MBProgressHUD* hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText=@"Loading...";
        NSOperationQueue* operationQueue=[[NSOperationQueue alloc]init];
        [operationQueue addOperation:[NSBlockOperation blockOperationWithBlock:^{
            ASIHTTPRequest* request=[[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:url]];
            request.requestMethod=@"POST";
            [request addRequestHeader:@"Content-Type" value:@"application/json"];
            [request addRequestHeader:@"Accept" value:@"application/json"];
            
            NSError* error=nil;
            NSData* data=nil;
            if(dictionary){
                
                data=[NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
                
                request.postBody=[NSMutableData dataWithData:data];
            }
            
            
            [request startSynchronous];
            
            error=request.error;
            data=request.responseData;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self didReceiveData:data error:error andRequestId:requestId];
                
            });
            
            
        }]];
        
    }
    
}

-(void)sendHttpMultipartRequest:(NSString*)url andParameters:(NSDictionary*)dictionary progressView:(UIProgressView*)progressView andRequestId:(int)requestId
{
    if ([self isInternetAvailable]) {
        if (!progressView) {
            MBProgressHUD* hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.labelText=@"Loading...";
        }
        
        NSOperationQueue* operationQueue=[[NSOperationQueue alloc]init];
        [operationQueue addOperation:[NSBlockOperation blockOperationWithBlock:^{
            ASIFormDataRequest* request=[[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:url]];
            for (NSString* key in dictionary.allKeys) {
                [request setPostValue:[dictionary valueForKey:key] forKey:key];
            }
            request.downloadProgressDelegate=progressView;
            [request startSynchronous];
            NSError* error=request.error;
            NSData* data=request.responseData;
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self didReceiveData:data error:error andRequestId:requestId];
                
            });
            
            
        }]];
        
    }
    
}
-(void)didReceiveData:(NSData*)data error:(NSError*)error andRequestId:(int)requestId
{
    
}
-(BOOL) isInternetAvailable
{
    Reachability* reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    
    
    switch (netStatus)
    {
        case NotReachable:        {
            [self showMessage:kMessageInternetNotAvailable];
            return NO;
            break;
        }
            
        case ReachableViaWWAN:        {
            
            
            break;
        }
        case ReachableViaWiFi:        {
            
            
            break;
        }
    }
    return YES;
    
}
-(void) showMessage:(NSString*)msg
{
    UIAlertView* alertView=[[UIAlertView alloc]initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alertView show];
}
@end
