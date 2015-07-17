//
//  HolidayViewController.m
//  TanzSalonApp
//
//  Created by Avtar Guleria on 06/07/14.
//  Copyright (c) 2014 Avtar Guleria. All rights reserved.
//

#import "HolidayViewController.h"
#import "WeatherParser.h"
#import "WeatherRoot.h"
#import "UIImageView+WebCache.h"
#import "Weather.h"
#import "Main.h"

@interface HolidayViewController ()
{
    
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *destinationTextField;
@property (weak, nonatomic) IBOutlet UIImageView *weatherIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *dateImageView;
@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;


@end

@implementation HolidayViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.scrollView.contentSize=CGSizeMake(280, 530);


    if ([self.destinationTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor colorWithRed:253.0/255.0 green:255.0/255.0 blue:49.0/255.0 alpha:1];
        self.destinationTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Holiday Destination" attributes:@{NSForegroundColorAttributeName: color}];
    }

    
    NSString *dest=(NSString*)[UserDefaultsUtil getNSObjectForKey:@"destination"];
    if(dest){
        self.destinationTextField.text=dest;
        
         [self getTemp];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)shareButtonClicked:(id)sender {
    
    
    UIImage *imageToBeShared=[self getScreenshot];
    
    if(!imageToBeShared){
        imageToBeShared=[UIImage imageNamed:@"img_logo@2x.png"];
    }
    
    [self shareOnFaceBookWithText:@"Keep Calm and Come to Tanz" url:@"http://www.tanztanning.co.uk/" image:imageToBeShared];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    if (self.destinationTextField.text) {
        [self getTemp];
    }
   
    
    return YES;
}


-(void)getTemp{
    NSString *url=[NSString stringWithFormat:@"%@%@",kWeatherBaseURL,self.destinationTextField.text];
    
     url= [url stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    
    [self sendHttpGetRequest:url andRequestId:100];
}

#pragma mark- Network Method
-(void)didReceiveData:(NSData *)data error:(NSError *)error andRequestId:(int)requestId
{
    switch (requestId) {
            
        case 100:
        {
            WeatherRoot *weather=[WeatherParser parseWeatherData:data];
            Weather *weath=nil;
          
            //Weather ICON.
            if(weather.weather && weather.weather.count>0){
                weath= [weather.weather objectAtIndex:0];
            }else{
                return;
            }
            
            [self.weatherIconImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@.png",kWeatherIconUrl,weath.icon]]];
            
            
            //Temprature.
            float temp=[weather.main.temp intValue]-273.15;//Kelvin temprature
            self.weatherLabel.text=[NSString stringWithFormat:@"%.1f\u00B0 C %@", temp,weath.main];
            
            // DATE
            
            int day=[[NSDate date] day];
            NSString *month=[ self getMonthString:[[NSDate date] month]];
            
            self.dateImageView.text=[NSString stringWithFormat:@"Today, %d %@",day,month];
            
            [UserDefaultsUtil saveNSObject:self.destinationTextField.text forKey:@"destination"];
            
        }
            break;
            
    }
}

-(NSString*)getMonthString:(int)month{
    
    switch (month) {
        case 1:return @"January";
        case 2: return @"Feburary";
        case 3: return @"March";
        case 4: return @"April";
        case 5: return @"May";
        case 6: return @"June";
        case 7: return @"July";
        case 8: return @"August";
        case 9: return @"September";
        case 10: return @"October";
        case 11: return @"November";
        case 12: return @"December";
            
        default:
            return nil;
            break;
    }
}




@end
