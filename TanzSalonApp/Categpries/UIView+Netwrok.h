//
//  UIView+Netwrok.h
//  Template
//
//  Created by Sukhpal on 2/27/14.
//  Copyright (c) 2014 XAV-MAC13. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Netwrok)
-(void)sendHttpGetRequest:(NSString*)url;
-(void)sendHttpPostRequestWith:(NSString*)url andParameters:(NSDictionary*)dictionary;
-(void)sendHttpMultipartRequest:(NSString*)url andParameters:(NSDictionary*)dictionary progressView:(UIProgressView*)progressView;
-(void)didReceiveData:(NSData*)data;

-(void)sendHttpGetRequest:(NSString*)url andRequestId:(int)requestId;
-(void)sendHttpPostRequestWith:(NSString*)url andParameters:(NSDictionary*)dictionary andRequestId:(int)requestId;
-(void)sendHttpMultipartRequest:(NSString*)url andParameters:(NSDictionary*)dictionary progressView:(UIProgressView*)progressView andRequestId:(int)requestId;
-(void)didReceiveData:(NSData*)data error:(NSError*)error andRequestId:(int)requestId;

-(BOOL) isInternetAvailable;
-(void)sendHttpPostJsonRequestWith:(NSString*)url jsonData:(NSData*)dictionary andRequestId:(int)requestId;
-(void)basicAuthentication:(NSString*)url andRequestId:(int)requestId username:(NSString*)username password:(NSString*)pwd;
@end
