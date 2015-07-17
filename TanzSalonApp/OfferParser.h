#import <UIKit/UIKit.h>
#import "BaseParser.h"
#import "OfferRoot.h"

@interface OfferParser : BaseParser{
    
}
+(OfferRoot*) parseOffers:(NSData*) data;
@end