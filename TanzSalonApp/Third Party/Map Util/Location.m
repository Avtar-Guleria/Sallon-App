//
//  MyLocation.m
//  RidingsApp
//
//  Created by Daffodil Suncity on 17/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Location.h"

@implementation Location
@synthesize name = _name;
@synthesize address = _address;
@synthesize coordinate = _coordinate;
@synthesize annotationIndex=_annotationIndex;
@synthesize mapPinImageName=_mapPinImageName;
@synthesize mapPinUrl=_mapPinUrl;



- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate {
    if ((self = [super init])) {
        _name = name ;
        _address = address ;
        _coordinate = coordinate;
    }
    return self;
}

- (NSString *)title {
    return _name;
}

- (NSString *)subtitle {
    return _address;
}


@end