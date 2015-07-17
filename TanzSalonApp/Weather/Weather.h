
#import <UIKit/UIKit.h>

@interface Weather : NSObject
	
@property(nonatomic,retain) NSNumber* id;
@property(nonatomic,retain) NSString* icon;
@property(nonatomic,retain) NSString* description;
@property(nonatomic,retain) NSString* main;
@end