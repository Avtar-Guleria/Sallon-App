//
//  DateUtil.m
//  Avtar Guleria
//
//

#import "DateUtil.h"

NSString * DATE_FORMAT=@"yyyy-MM-dd";
//NSString * DATE_FORMAT=@"yyyy-MM-dd HH:mm:ss zzz";

@implementation DateUtil


/**
 Method to get number of days between two dates.
 */

+ (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSDayCalendarUnit
                                               fromDate:fromDate toDate:toDate options:0];
    
    return [difference day];
}

+ (NSInteger)getAge:(NSDate *)dateOfBirth {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *dateComponentsNow = [calendar components:unitFlags fromDate:[NSDate date]];
    NSDateComponents *dateComponentsBirth = [calendar components:unitFlags fromDate:dateOfBirth];
    
    if (([dateComponentsNow month] < [dateComponentsBirth month]) ||
        (([dateComponentsNow month] == [dateComponentsBirth month]) && ([dateComponentsNow day] < [dateComponentsBirth day]))) {
        return [dateComponentsNow year] - [dateComponentsBirth year] - 1;
    } else {
        return [dateComponentsNow year] - [dateComponentsBirth year];
    }
}
/**
 Method to check if this date fall with in week or not.
 */

+(BOOL)isDateFallWithInWeek:(NSString *)answerDateString
{
    BOOL isFall=NO;
   
    NSDate *currentDate=[NSDate date];
    
    NSDate * answerDate=[self getDateFromString:answerDateString];

    int daysDiff=[DateUtil daysBetweenDate:answerDate  andDate:currentDate];
   
    if(daysDiff<=7){
        isFall=YES;
    }
        
    return isFall;
}

/**
 Method to get Date object from String date .
 It will accept default format for string date such as [NSdate date] gives
 e.g.=2012-07-01 08:38:27 +0000
 */
+ (NSDate*)getDateFromString:(NSString*)dateStr
{
    // Convert string to date object
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:DATE_FORMAT];
    
    NSDate *date = [[NSDate alloc]init];
    date=[dateFormatter dateFromString:dateStr]; 
    
 
    return date;
}





/**
 Method to get date instanse of today at particular point of time.
 
 For e.g if you want to get date instance of today 8 pm.
 
 Input: hours, minutes and seconds.
 Output:Default Date object for that time in todays date.

*/
+(NSDate*)getDateInstanceForParticularHour:(int)hour minute:(int)minute seconds:(int)seconds
{

  NSCalendar* myCalendar = [NSCalendar currentCalendar];
  NSDateComponents* components = [myCalendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit 
                                             fromDate:[NSDate date]];
  [components setHour: hour];
  [components setMinute: minute];
  [components setSecond: seconds];
    
  NSDate *dateInstance = [myCalendar dateFromComponents:components];

    return dateInstance;
}

/**
 Method to accept date string and convert it into NSDate object using formatter.
 Input String:2012-09-10 18:30:00 +0000 as NSString
 Output Date:2012-09-10 18:30:00 +0000  as NSDate
 */
+(NSDate*)getFormattedDateFromString:(NSString*)dateString
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MM/dd/yyyy HH:mm:ss aaa"];
    
    NSDate *convertedDate = [df dateFromString:dateString];
    
    return convertedDate;
}


/**
 Method to accept date and convert it into NSString object using formatter.
 Input String:2012-09-10 18:30:00 +0000 as NSDate
 Output Date:MM/dd/YYYY HH:mm:ss AM  as NSString
 */
+(NSString*)getFormattedDateString:(NSDate*)date 
{
    NSString *dateString=nil;
    if(date){
        NSDateFormatter *dateFormatter= [[NSDateFormatter alloc]init];
//        [dateFormatter setDateFormat:@"MM/dd/yyyy HH:mm:ss aaa"];
        [dateFormatter setDateFormat:@"MM/dd/yyyy"];
        dateString=[[ NSString alloc]initWithString:[dateFormatter stringFromDate:date]];
        NSLog(@"date %@",dateString);
        
    }
    return  dateString;
}


+(NSString*)getFormattedTimeString:(NSDate*)date
{
    NSString *dateString=nil;
    if(date){
        NSDateFormatter *dateFormatter= [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"HH:mm"];
        dateString=[[ NSString alloc]initWithString:[dateFormatter stringFromDate:date]];
        
    }
    return  dateString;
}


/**
 Method to get formatted date from date
 Input Date:2012-09-10 18:30:00 +0000,
 Output String:08/23/2012
 */
+(NSString*)getFormattedStringFromDate:(NSDate*)date
{
    NSString *dateString=nil;
    if(date){
    NSDateFormatter *dateFormatter= [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    dateString=[[ NSString alloc]initWithString:[dateFormatter stringFromDate:date]];
    
    }
    return  dateString;
}


+ (NSDate*)getFormattedDateFromMilliseconds:(NSString*)unixTimeStamp {
    

    NSLog(@"%@",unixTimeStamp);
    
    if(unixTimeStamp){
        
        unixTimeStamp=[unixTimeStamp stringByReplacingOccurrencesOfString:@"/Date(" withString:@""];
        unixTimeStamp=[unixTimeStamp stringByReplacingOccurrencesOfString:@")/" withString:@""];
          NSLog(@"%@",unixTimeStamp);
    }
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[unixTimeStamp doubleValue] ];
    NSDate *convertedDate = [self getFormattedDateFromString:[self getFormattedDateString:date]];
    return convertedDate;
}




@end
