
#import <UIKit/UIKit.h>

@interface ServiceData : NSObject
	
@property(nonatomic,retain) NSString* serviceID;
@property(nonatomic,retain) NSString* serviceName;
@property(nonatomic,retain) NSString* serviceURL;


@property(nonatomic,assign) BOOL isSelected;

@property(nonatomic,assign) BOOL isBookable;
@end