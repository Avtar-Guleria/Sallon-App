#import <UIKit/UIKit.h>
#import "ServiceRoot.h"
@interface ServiceParser : BaseParser

+(ServiceRoot*) parseServices:(NSData*) data;


@end