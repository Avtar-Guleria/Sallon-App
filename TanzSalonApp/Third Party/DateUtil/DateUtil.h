//
//

#import <Foundation/Foundation.h>

@interface DateUtil : NSObject



+ (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime;

+(BOOL)isDateFallWithInWeek:(NSString*)answerDateString;

+(NSDate*)getDateInstanceForParticularHour:(int)hour minute:(int)minute seconds:(int)seconds;

+(NSDate*)getFormattedDateFromString:(NSString*)dateString;

+(NSString*)getFormattedStringFromDate:(NSDate*)date;
+ (NSDate*)getDateFromString:(NSString*)dateStr;
+(NSString*)getFormattedTimeString:(NSDate*)date;
+(NSString*)getFormattedDateString:(NSDate*)date ;
+ (NSDate*)getFormattedDateFromMilliseconds:(NSString*)unixTimeStamp;
+ (NSInteger)getAge:(NSDate *)dateOfBirth;
@end
