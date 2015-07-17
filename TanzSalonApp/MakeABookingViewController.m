//
//  BookApptViewController.m
//  TanzSalonApp
//
//  Created by Avtar Guleria on 08/04/14.
//  Copyright (c) 2014 Avtar Guleria. All rights reserved.
//

#import "MakeABookingViewController.h"
#import "DatePickerViewFactory.h"
#import "DateUtil.h"
#import "TimePickerViewFactory.h"
#import "ServiceData.h"
#import "ValidationUtil.h"
#import "JsonUtil.h"
#import "SalonRoot.h"
#import "SalonParser.h"
#import "SalonData.h"



@interface MakeABookingViewController ()
{
    AutoScroller *scroller;
    
    DatePickerViewFactory *datePickerFactory;
    NSDate *selectedDate;
    
    TimePickerViewFactory *timePickerFactory;
    NSDate *selectedTime;
    
    NSMutableArray *serviceNames;
    NSMutableArray *bookableServices;
    
    PickerViewFactory *pickerViewFactory;
    ServiceData *selectedService;
    
    
    NSMutableArray *salonNames;
    PickerViewFactory *salonPickerViewFactory;
    NSMutableArray *salons;
    SalonData *selectedSalon;
}

@property (weak, nonatomic) IBOutlet UILabel *navigationTitleLabel;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UITextField *dateTextField;
@property (weak, nonatomic) IBOutlet UITextField *timeTextField;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *telephoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;


@property (weak, nonatomic) IBOutlet UIButton *treatmentButton;
@property (weak, nonatomic) IBOutlet UIButton *salonButton;

@end

@implementation MakeABookingViewController

int SALON_PICKER_TAG=17;
int SERVICE_PICKER_TAG=18;


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
	
    [self.dateTextField setPadding:10];
    [self.timeTextField setPadding:10];
    [self.firstNameTextField setPadding:10];
    [self.lastNameTextField setPadding:10];
    [self.telephoneNumberTextField setPadding:10];
    [self.emailTextField setPadding:10];
    
    scroller=[AutoScroller addAutoScrollTo:self.scrollView];
    scroller.topPadding=40;
    
    self.scrollView.contentSize=CGSizeMake(self.scrollView.frame.size.width, 630);

    bookableServices=[[NSMutableArray alloc]init];
    
    //Get all salons
    NSString *url=[NSString stringWithFormat:@"%@getAllSaloons",kBaseUrl];
    [self sendHttpGetRequest:url andRequestId:100];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- IBAction Methods.
- (IBAction)submitButtonClicked:(id)sender {
    
    if(!selectedSalon){
        [self showAlert:@"Please select Salon"];
        return;
    }
    
    if(!selectedService){
        [self showAlert:@"Please select treatment."];
        return;
    }
    
    if ([self isValidForm]) {
        //Get all services
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM:dd:yyyy"];
        
        NSLog(@"Ke:%@",self.dateTextField.text);
        
        NSString *serviceUrl=[NSString stringWithFormat:@"%@bookAppointment&saloonID=%@&serviceID=%@&dateTime=%@&firstName=%@&lastName=%@&mobileNumber=%@&emailID=%@",kBaseUrl,selectedSalon.saloonID,selectedService.serviceID,[NSString stringWithFormat:@"%@ %@",self.dateTextField.text,self.timeTextField.text],self.firstNameTextField.text,self.lastNameTextField.text,self.telephoneNumberTextField.text,self.emailTextField.text];
        serviceUrl = [serviceUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        [self sendHttpGetRequest:serviceUrl andRequestId:101];
        NSLog(@"%@",serviceUrl);
    }
    
}

-(BOOL)isValidForm{
    BOOL isValid=NO;
    
    if([ValidationUtil isValidTextInTextField:self.dateTextField] && [ValidationUtil isValidTextInTextField:self.timeTextField] && [ValidationUtil isValidTextInTextField:self.firstNameTextField] && [ValidationUtil isValidTextInTextField:self.telephoneNumberTextField] && [ValidationUtil isValidTextInTextField:self.emailTextField]){
        
        if([ValidationUtil isValidEmail:self.emailTextField.text]){
            isValid=YES;
        }else{
            [self showAlert:@"Please enter valid Email Address."];
        }
    }else{
        [self showAlert:@"All fields are compulsory."];
    }
    
    return isValid;
}
- (IBAction)chooseSalon:(id)sender {
    selectedService=nil;
    [self setButtonTitle:@"Choose a Treatment" forButton:self.treatmentButton];
    
    [self resignAllTextField];
    self.scrollView.userInteractionEnabled=NO;
    
    salonPickerViewFactory=[PickerViewFactory addPickerViewForArray:salonNames withTitle:@"Select Salon" inContainerView:self.view];
    salonPickerViewFactory.delegate=self;
    
    salonPickerViewFactory.pickerView.tag=SALON_PICKER_TAG;
}


- (IBAction)treatmentButtonClicked:(id)sender {

    if(!selectedSalon){
        [self showAlert:@"Please select salon first."];
        return;
    }
    
    
    serviceNames=[[NSMutableArray alloc]init];
    for(ServiceData *service in selectedSalon.services){
         if(service.isBookable){
             [serviceNames addObject:service.serviceName];
             [bookableServices addObject:service];
         }
    }
    
    if(serviceNames.count==0){
        [self showAlert:@"No Treatments are available for this salon."];
        return;
    }
    
    [self resignAllTextField];
    self.scrollView.userInteractionEnabled=NO;
    
    
    pickerViewFactory=[PickerViewFactory addPickerViewForArray:serviceNames withTitle:@"Select Service" inContainerView:self.view];
    pickerViewFactory.delegate=self;
    pickerViewFactory.pickerView.tag=SERVICE_PICKER_TAG;

}


- (IBAction)dateButtonClicked:(id)sender {
    [self resignAllTextField];
    self.scrollView.userInteractionEnabled=NO;
    
    
    datePickerFactory=[DatePickerViewFactory addDatePickerViewWithTitle:@"Select Date" inContainerView:self.view];
    datePickerFactory.delegate=self;
}
- (IBAction)timeButtonClicked:(id)sender {
    [self resignAllTextField];
    self.scrollView.userInteractionEnabled=NO;
    
    
    timePickerFactory=[TimePickerViewFactory addTimePickerViewWithTitle:@"Select Time" inContainerView:self.view];
    timePickerFactory.delegate=self;
}

-(void)resignAllTextField{
    [self.firstNameTextField resignFirstResponder];
    [self.lastNameTextField resignFirstResponder];
    [self.telephoneNumberTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];
}


#pragma mark- Date Picker Delegate.
-(void)datePickerView:(UIDatePicker *)datePickerView didSelectDate:(NSDate *)date
{
    selectedDate=date;
    
   self.dateTextField.text=[DateUtil getFormattedDateString:date];
    
    self.scrollView.userInteractionEnabled=YES;
}
-(void)datePickerViewDidCancel:(UIDatePicker *)datePickerView
{
      self.scrollView.userInteractionEnabled=YES;
}
#pragma mark- Time Picker Delegate.
-(void)timePickerView:(UIDatePicker *)timePickerView didSelectDate:(NSDate *)date
{
    selectedTime=date;
    
    self.timeTextField.text=[DateUtil getFormattedTimeString:date];
      self.scrollView.userInteractionEnabled=YES;
}
-(void)timePickerViewDidCancel:(UIDatePicker *)timePickerView{
      self.scrollView.userInteractionEnabled=YES;
}
#pragma mark- Picker Delegate.
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row{
    
    if (pickerView.tag==SALON_PICKER_TAG) {
       
        selectedSalon=[salons objectAtIndex:row];
        [self setButtonTitle:selectedSalon.saloonName forButton:self.salonButton];

    }else if (pickerView.tag==SERVICE_PICKER_TAG){
       
        selectedService=[bookableServices objectAtIndex:row];
        [self setButtonTitle:selectedService.serviceName forButton:self.treatmentButton];
       
    }
    self.scrollView.userInteractionEnabled=YES;
}

-(void)pickerViewDidCancel:(UIPickerView *)pickerView
{
    self.scrollView.userInteractionEnabled=YES;
}


#pragma mark- Network Method
-(void)didReceiveData:(NSData *)data error:(NSError *)error andRequestId:(int)requestId
{
    switch (requestId) {
        case 100:
        {
            SalonRoot *salonRoot=[SalonParser parseSalons:data];
            
            if(salonRoot){
                
                
                if([salonRoot.responseCode isEqualToString:@"200"]){
                    
                    if (salonRoot && salonRoot.data.count>0) {
                        salons=salonRoot.data;
                        
                        salonNames=[[NSMutableArray alloc]init];
                        for(SalonData *salon in salons){
                            [salonNames addObject:salon.saloonName];
                        }
                      
                    }else{
                        [self showAlert:@"No Salon found."];
                    }
                    
                }
            }
        }
            
            break;
            
        case 101:
        {
            NSMutableDictionary *dict=[self getDictonaryFromString:data];
            
            if(dict){
                
                if([[JsonUtil getString:dict forKey:@"responseCode"] isEqualToString:@"200"]){
                    [self showAlert:[JsonUtil getString:dict forKey:@"msg"]];
                    
                }else{
                    [self showAlert:[JsonUtil getString:dict forKey:@"msg"]];
                }
            }
        }
            
            break;
    }
}

@end
