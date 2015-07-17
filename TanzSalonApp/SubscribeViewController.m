//
//  SubscribeViewController.m
//  TanzSalonApp
//
//  Created by Avtar Guleria on 15/06/14.
//  Copyright (c) 2014 Avtar Guleria. All rights reserved.
//

#import "SubscribeViewController.h"
#import "ValidationUtil.h"
#import "JsonUtil.h"
#import "SalonRoot.h"
#import "SalonParser.h"
#import "SalonData.h"
#import "DatePickerViewFactory.h"
#import "DateUtil.h"


@interface SubscribeViewController ()
{
    
    AutoScroller *scroller;
    DatePickerViewFactory *datePickerFactory;
    NSDate *selectedDate;
    
    NSMutableArray *salonNames;
    PickerViewFactory *salonPickerViewFactory;
    NSMutableArray *salons;
    SalonData *selectedSalon;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *salonTextField;

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *dateTextField;
@property (weak, nonatomic) IBOutlet UITextField *monthTextField;
@property (weak, nonatomic) IBOutlet UITextField *yearTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;


@property (weak, nonatomic) IBOutlet UILabel *navTextField;

@property (weak, nonatomic) IBOutlet UITextView *descTextView;

@end

@implementation SubscribeViewController

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
    
    scroller= [AutoScroller addAutoScrollTo:self.scrollView];
    scroller.topPadding=-20;
    
    [self.firstNameTextField setPadding:10];
    [self.lastNameTextField setPadding:10];
    [self.dateTextField setPadding:8];
    [self.monthTextField setPadding:8];
    [self.yearTextField setPadding:8];
    [self.emailTextField setPadding:10];
    [self.salonTextField setPadding:10];
    
    
    //Get all salons
    NSString *url=[NSString stringWithFormat:@"%@getAllSaloons",kBaseUrl];
    [self sendHttpGetRequest:url andRequestId:100];
    
    self.navTextField.text=self.offerData.offerName;
    self.descTextView.text=self.offerData.offerDescription;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark- IBAction Methods.

- (IBAction)shareButtonClicked:(id)sender {
    
    [self shareText:self.offerData.offerName andImage:[UIImage imageNamed:@"img_logo@2x.png"]];
    
}

- (IBAction)chooseSalon:(id)sender {
    self.scrollView.userInteractionEnabled=NO;
    
    salonPickerViewFactory=[PickerViewFactory addPickerViewForArray:salonNames withTitle:@"Select Salon" inContainerView:self.view];
    salonPickerViewFactory.delegate=self;
    
}
- (IBAction)dateButtonClicked:(id)sender {
    [self resignAllTextField];
    self.scrollView.userInteractionEnabled=NO;
    
    
    datePickerFactory=[DatePickerViewFactory addDatePickerViewWithTitle:@"Select Date" inContainerView:self.view];
    datePickerFactory.delegate=self;
    datePickerFactory.pickerView.minimumDate=nil;
    datePickerFactory.pickerView.maximumDate=[NSDate date];
}

-(void)resignAllTextField{
    [self.firstNameTextField resignFirstResponder];
    [self.lastNameTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];
}

#pragma mark- Date Picker Delegate.
-(void)datePickerView:(UIDatePicker *)datePickerView didSelectDate:(NSDate *)date
{
    selectedDate=date;
    
    self.dateTextField.text=[NSString stringWithFormat:@"%d",date.day];
    self.monthTextField.text=[NSString stringWithFormat:@"%d",date.month];
    self.yearTextField.text=[NSString stringWithFormat:@"%d",date.year];
    
    
    self.scrollView.userInteractionEnabled=YES;
}
-(void)datePickerViewDidCancel:(UIDatePicker *)datePickerView
{
    self.scrollView.userInteractionEnabled=YES;
}


- (IBAction)subscribeButtonClicked:(id)sender {
    
    if([self isValidForm]){
        //Subscribe
        
        NSString *dob=[NSString stringWithFormat:@"%@-%@-%@",self.dateTextField.text, self.monthTextField.text, self.yearTextField.text];
        
        NSString *url=[NSString stringWithFormat:@"%@subscribeOffer&offerID=%@&firstName=%@&lastName=%@&emailID=%@&saloonID=%@&dateOfBirth=%@",kBaseUrl,self.offerData.offerID,self.firstNameTextField.text,self.lastNameTextField.text,self.emailTextField.text,selectedSalon.saloonID,dob];

         url= [url stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
        
        [self sendHttpGetRequest:url andRequestId:101];
    }
    
}

-(BOOL)isValidForm{
    
    BOOL isValid=NO;
    
    if([ValidationUtil isValidTextInTextField:self.firstNameTextField] && [ValidationUtil isValidTextInTextField:self.lastNameTextField] && [ValidationUtil isValidTextInTextField:self.dateTextField] && [ValidationUtil isValidTextInTextField:self.monthTextField] && [ValidationUtil isValidTextInTextField:self.yearTextField] && [ValidationUtil isValidTextInTextField:self.emailTextField] && [ValidationUtil isValidTextInTextField:self.salonTextField]){
     
        if ([ValidationUtil isValidEmail:self.emailTextField.text]) {
            
            isValid=YES;
            
        }else{
             [self showAlert:@"Please enter valid email id."];
        }
        
    }else{
        [self showAlert:@"All fields are compulsory."];
    }

    
    
    return  isValid;
}


#pragma mark- Picker Delegate.
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row{
    selectedSalon=[salons objectAtIndex:row];
    self.salonTextField.text=selectedSalon.saloonName;
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
                    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                    
                }else{
                    [self showAlert:[JsonUtil getString:dict forKey:@"msg"]];
                }
            }
        }
            
            break;
    }
}


@end
