
#import <UIKit/UIKit.h>

@interface SalonServices : NSObject
	
@property(nonatomic,retain) NSString* serviceID;
@property(nonatomic,retain) NSString* serviceName;
@property(nonatomic,assign) BOOL isBookable;
@end