//
//  BookApptViewController.m
//  TanzSalonApp
//
//  Created by Avtar Guleria on 08/04/14.
//  Copyright (c) 2014 Avtar Guleria. All rights reserved.
//

#import "BookApptViewController.h"
#import "DatePickerViewFactory.h"
#import "DateUtil.h"
#import "TimePickerViewFactory.h"
#import "ServiceData.h"
#import "ValidationUtil.h"
#import "JsonUtil.h"


@interface BookApptViewController ()
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

@end

@implementation BookApptViewController

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
    scroller.topPadding=90;
    
    self.scrollView.contentSize=CGSizeMake(self.scrollView.frame.size.width, 630);


    
    //init UI
    self.navigationTitleLabel.text=self.salon.saloonName;

  
    serviceNames=[[NSMutableArray alloc]init];
    bookableServices=[[NSMutableArray alloc]init];
    
    for(ServiceData *service in self.salon.services){
        if(service.isBookable){
             [serviceNames addObject:service.serviceName];
            [bookableServices addObject:service];
        }
        
    }
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- IBAction Methods.
- (IBAction)submitButtonClicked:(id)sender {
    
    if ([self isValidForm]) {
        //Get all services
        NSString *serviceUrl=[NSString stringWithFormat:@"%@bookAppointment&saloonID=%@&serviceID=%@&dateTime=%@&firstName=%@&lastName=%@&mobileNumber=%@&emailID=%@",kBaseUrl,self.salon.saloonID,selectedService.serviceID,self.dateTextField.text,self.firstNameTextField.text,self.lastNameTextField.text,self.telephoneNumberTextField.text,self.emailTextField.text];
        
        [self sendHttpGetRequest:serviceUrl andRequestId:100];
        
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


- (IBAction)treatmentButtonClicked:(id)sender {

    [self resignAllTextField];
    self.scrollView.userInteractionEnabled=NO;
    
    
    pickerViewFactory=[PickerViewFactory addPickerViewForArray:serviceNames withTitle:@"Select Service" inContainerView:self.view];
    pickerViewFactory.delegate=self;

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
  
    selectedService=[bookableServices objectAtIndex:row];
    
    [self setButtonTitle:selectedService.serviceName forButton:self.treatmentButton];
    
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
