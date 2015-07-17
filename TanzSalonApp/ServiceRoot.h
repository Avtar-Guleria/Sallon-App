
#import <UIKit/UIKit.h>

@interface ServiceRoot : NSObject
	
@property(nonatomic,retain) NSString* responseCode;
@property(nonatomic,retain) NSMutableArray* data;
@property(nonatomic,retain) NSString* msg;
@end