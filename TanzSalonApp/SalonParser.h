#import <UIKit/UIKit.h>
#import "SalonRoot.h"

@interface SalonParser : BaseParser

+(SalonRoot*) parseSalons:(NSData*) data;

@end