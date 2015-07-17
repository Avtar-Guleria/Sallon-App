//
//  LocationUtil.m
//  MyEmergencyApp
//
//  Created by Daffodil Suncity on 30/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LocationUtil.h"
#import "MBProgressHUD.h"

@implementation LocationUtil

@synthesize userCurrentCordinate,locality,name,postalCode,isoCountryCode,country,addressDictionary,ocean,inlandWater,subLocality,thoroughfare,areasOfInterest,subThoroughfare,administrativeArea,subAdministrativeArea,formattedAddress,locationDelegate;


#pragma mark- Location Methods

-(void)startLocationManagerForViewController:(BaseViewController*)controller
{
    viewController=controller;
    
     //start location manager to get user current location.
    
    if ([CLLocationManager locationServicesEnabled] == NO) {
        NSLog(@"locationServicesEnabled false");
        UIAlertView *servicesDisabledAlert = [[UIAlertView alloc] initWithTitle:@"Location Services Disabled" message:@"You currently have all location services for this device disabled" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [servicesDisabledAlert show];
    } else {
        CLAuthorizationStatus authorizationStatus= [CLLocationManager authorizationStatus];
        if(authorizationStatus == kCLAuthorizationStatusDenied || authorizationStatus == kCLAuthorizationStatusRestricted){
            NSLog(@"authorizationStatus failed");
        } else {
            NSLog(@"authorizationStatus authorized");
            locationManager = [[CLLocationManager alloc] init];
            if(([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)) {
                [locationManager requestWhenInUseAuthorization];
            }
            locationManager.delegate = self;
            locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            locationManager.distanceFilter = kCLDistanceFilterNone;
            [locationManager startUpdatingLocation];
        }
    }
    
    name=nil;
    locality=nil;
    postalCode=nil;
    isoCountryCode=nil;
    country=nil;

    
    MBProgressHUD* hud=[MBProgressHUD showHUDAddedTo:viewController.view animated:YES];
    hud.labelText=@"Loading...";


}

/**
 *Delegate methods to get user current location.
 */
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    
    userCurrentCordinate=newLocation.coordinate;
    [locationManager stopUpdatingLocation];
    
      
    //REVERSE GEOCODING.
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    
    [UserDefaultsUtil saveNSObject:[NSNumber numberWithFloat:newLocation.coordinate.latitude ]forKey:@"latitude"];
    [UserDefaultsUtil saveNSObject:[NSNumber numberWithFloat:newLocation.coordinate.longitude ]forKey:@"longitude"];
    
 
    [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
          for (CLPlacemark * placemark in placemarks) {
       
              if(placemark.name){
                  name=[[NSString alloc]initWithString:[placemark name]]; 
              }
              
              if (placemark.locality){
                    locality=[[NSString alloc]initWithString:[placemark locality]];
              }
      
              if(placemark.postalCode){
                  postalCode=[[NSString alloc]initWithString:[placemark postalCode]];
              }
              
              if(placemark.ISOcountryCode){
                  isoCountryCode=[[NSString alloc]initWithString:[placemark ISOcountryCode]];
              }

              if(placemark.country){
                  country=[[NSString alloc]initWithString:[placemark country]];
              }
              
              if(placemark.addressDictionary){
                  addressDictionary=[[NSDictionary alloc]initWithDictionary:[placemark addressDictionary]];
              }

              if(placemark.ocean){
                  ocean=[[NSString alloc]initWithString:[placemark ocean]];
              }
              
              if(placemark.inlandWater){
                  inlandWater=[[NSString alloc]initWithString:[placemark inlandWater]];
              }
              
              if(placemark.subLocality){
                  subLocality=[[NSString alloc]initWithString:[placemark subLocality]];
              }
              
              if(placemark.thoroughfare){
                  thoroughfare=[[NSString alloc]initWithString:[placemark thoroughfare]];
              }
              
              if(placemark.areasOfInterest){
                  areasOfInterest=[[NSArray alloc]initWithArray:[placemark areasOfInterest]];
              }
              
              if(placemark.administrativeArea){
                  administrativeArea=[[NSString alloc]initWithString:[placemark administrativeArea]];
              }
              
              if(placemark.subAdministrativeArea){
                  subAdministrativeArea=[[NSString alloc]initWithString:[placemark subAdministrativeArea]];
              }
   
              NSArray* places = [[placemark addressDictionary] valueForKey:@"FormattedAddressLines"];
              
              NSMutableString* formattedPlace=[[NSMutableString alloc]init];
              for (int i=0; i<[places count]; i++) {
                  [formattedPlace appendString:[places objectAtIndex:i]];
                  [formattedPlace appendString:@", "];
              }
             
              if(formattedPlace && formattedPlace.length>3){
                  formattedAddress= [[NSString alloc]initWithString:[formattedPlace substringToIndex:[formattedPlace length]-2]];
                  formattedPlace=nil;
              }else{
                  formattedAddress=nil;
              }
         
              

              NSLog(@"********************************************Locality-%@",[placemark locality]);
              NSLog(@"********************************************name-%@",[placemark name]);
              NSLog(@"********************************************postalCode-%@",[placemark postalCode]);
              NSLog(@"********************************************country-%@",[placemark country]);
              NSLog(@"********************************************addressDictionary-%@",[placemark addressDictionary]);
              NSLog(@"********************************************ocean-%@",[placemark ocean]);
              NSLog(@"********************************************inlandWater-%@",[placemark inlandWater]);
              NSLog(@"********************************************subLocality-%@",[placemark subLocality]);
              NSLog(@"********************************************Locality-%@",[placemark thoroughfare]);
              NSLog(@"********************************************areasOfInterest-%@",[placemark areasOfInterest]);
              NSLog(@"********************************************subThoroughfare-%@",[placemark subThoroughfare]);
              NSLog(@"********************************************administrativeArea-%@",[placemark administrativeArea]);
              NSLog(@"********************************************subAdministrativeArea-%@",[placemark subAdministrativeArea]);
         
            NSLog(@"********************************************formattedAddress-%@",formattedAddress);
              
    }    
        
        if(!isLocationAlreadyRecieved && (name||locality||postalCode||isoCountryCode||country)){
            isLocationAlreadyRecieved=YES;
            //call view controller method after gettin any one of the above.
              [MBProgressHUD hideHUDForView:viewController.view animated:YES];
            [self.locationDelegate addressRetrievedSuccessfully:formattedAddress];
        }
        
       
    }];
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError*)error{
  
    //In some cases when we are using iphone simulator the didupdate location is failed to be called for this we are explicitly calling the delegate method with dummy location.
    if( [(NSString *)[[UIDevice currentDevice] model] isEqualToString:@"iPhone Simulator"] ){
       
        CLLocation *dummyLocation=[[CLLocation alloc]initWithLatitude:28.4360111 longitude:77.7372];
        
        [self locationManager:locationManager didUpdateToLocation:dummyLocation fromLocation:nil];
        
    }else{
         [MBProgressHUD hideHUDForView:viewController.view animated:YES];
        [self.locationDelegate failedToGetLocation];
    }
}

@end
