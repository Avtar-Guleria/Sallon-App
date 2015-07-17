//
//  LocationUtil.h
//  MyEmergencyApp
//
//  Created by Daffodil Suncity on 30/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import  "CoreLocation/CoreLocation.h"
#import "BaseViewController.h"

@protocol LocationRecieved <NSObject>

-(void)addressRetrievedSuccessfully:(NSString*)formattedAddress;
-(void)failedToGetLocation;




@end


@interface LocationUtil : NSObject<CLLocationManagerDelegate>
{
    CLLocationManager* locationManager;
    BaseViewController *viewController;
    
    BOOL isLocationAlreadyRecieved;
}

@property (nonatomic,strong)id<LocationRecieved> locationDelegate;

@property(nonatomic,readonly) CLLocationCoordinate2D userCurrentCordinate;
@property(nonatomic,retain) NSString *name;
@property(nonatomic,retain) NSString *locality;
@property(nonatomic,retain) NSString *postalCode;
@property(nonatomic,retain) NSString *isoCountryCode;
@property(nonatomic,retain) NSString *country;

@property (nonatomic, readonly) NSDictionary *addressDictionary;

@property (nonatomic, readonly) NSString *thoroughfare; // street address, eg. 1 Infinite Loop
@property (nonatomic, readonly) NSString *subThoroughfare; // eg. 1
@property (nonatomic, readonly) NSString *subLocality; // neighborhood, common name, eg. Mission District
@property (nonatomic, readonly) NSString *administrativeArea; // state, eg. CA
@property (nonatomic, readonly) NSString *subAdministrativeArea; // county, eg. Santa Clara
@property (nonatomic, readonly) NSString *inlandWater; // eg. Lake Tahoe
@property (nonatomic, readonly) NSString *ocean; // eg. Pacific Ocean
@property (nonatomic, readonly) NSArray *areasOfInterest; // eg. Golden Gate Park

@property (nonatomic, readonly) NSString *formattedAddress; // eg. Golden Gate Park


-(void)startLocationManagerForViewController:(BaseViewController*)controller;

@end
