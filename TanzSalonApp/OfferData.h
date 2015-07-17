
#import <UIKit/UIKit.h>

@interface OfferData : NSObject
	
@property(nonatomic,retain) NSString* offerID;
@property(nonatomic,retain) NSString* offerDescription;
@property(nonatomic,retain) NSString* offerName;
@property(nonatomic,assign) BOOL isSubscribable;


@end