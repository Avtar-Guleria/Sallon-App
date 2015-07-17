//
//  MyLocation.h
//  RidingsApp
//
//  Created by Daffodil Suncity on 17/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Location : NSObject <MKAnnotation> {
    NSString *_name;
    NSString *_address;
    NSString *_mapPinImageName;
    NSString *_mapPinUrl;
    
    NSNumber*_annotationIndex;
    
    CLLocationCoordinate2D _coordinate;
}

@property (strong) NSString *name;
@property (strong) NSString *address;
@property (strong) NSNumber *annotationIndex;
@property (strong) NSString *mapPinImageName;
@property (strong) NSString *mapPinUrl;

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate;

@end