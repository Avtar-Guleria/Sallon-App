#import "Clouds.h"
#import "Coord.h"
#import "Wind.h"
#import "Sys.h"
#import "Rain.h"
#import "Main.h"

#import <UIKit/UIKit.h>

@interface WeatherRoot : NSObject
	
@property(nonatomic,retain) NSNumber* id;
@property(nonatomic,retain) NSNumber* dt;
@property(nonatomic,retain) Clouds* clouds;
@property(nonatomic,retain) Coord* coord;
@property(nonatomic,retain) Wind* wind;
@property(nonatomic,retain) NSNumber* cod;
@property(nonatomic,retain) Sys* sys;
@property(nonatomic,retain) NSString* name;
@property(nonatomic,retain) NSString* base;
@property(nonatomic,retain) NSMutableArray* weather;
@property(nonatomic,retain) Rain* rain;
@property(nonatomic,retain) Main* main;
@end