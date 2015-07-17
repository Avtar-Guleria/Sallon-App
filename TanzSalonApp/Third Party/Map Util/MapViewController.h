//
//  MapViewController
//
//  To use this Include 
//  MapKit.framework.
//  CoreLocation.Framework.

//  Created by Avtar Singh Guleria on 16/10/12.
//  Copyright (c) 2012 Daffodil Sotware Ltd.. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "BaseViewController.h"
#import "Location.h"


@interface MKMapView (ZoomLevel)
- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel
                   animated:(BOOL)animated;

-(double) getZoomLevel;
@end






@interface MapViewController : BaseViewController<UIActionSheetDelegate,CLLocationManagerDelegate,MKMapViewDelegate>
{
    CLLocationManager *locationManager;
    
    
}
@property(nonatomic,retain) IBOutlet MKMapView *mapView;

@property(nonatomic,retain) NSString* mapPinTitle;
@property(nonatomic,retain) NSString* mapPinSubTitle;

@property(nonatomic,assign) CLLocationCoordinate2D userCurrentLocationCoordinate;
@property(nonatomic,assign) CLLocationCoordinate2D embassyCoordinate;

@property(nonatomic,assign) BOOL isCurrentLocationNeeded;

//IBAction Methods
- (IBAction)showDirectionActionSheet:(id)sender;


//BL methods.


//Method to get direction using google map
-(void)getDirectionOnMap:(CLLocationCoordinate2D)fromCoordinate toCoordinate:(CLLocationCoordinate2D)toCoordinate;

//Plot particular cordinate on map.
- (void)plotPositionWithCordinate:(CLLocationCoordinate2D)coordinate withPinTitle:(NSString*)pinTitle;

- (void)plotPositionWithCordinate:(CLLocationCoordinate2D)coordinate withPinTitle:(NSString*)pinTitle mapPinImage:(NSString *)imageName;

- (void)plotPositionWithCordinate:(CLLocationCoordinate2D)coordinate withPinTitle:(NSString*)pinTitle mapPinImageUrl:(NSString *)imageUrl;

- (void)showUserLocationToCenter;

//Method to plot multiple cordinates at once. 
//Accepts array of Location type objects.
-(void)plotCordinates:(NSMutableArray*)locations;
@end
