#import <UIKit/UIKit.h>
#import "BaseParser.h"
#import "WeatherRoot.h"

@interface WeatherParser : BaseParser

+(WeatherRoot*) parseWeatherData:(NSData*) data;
@end