//
//  FeedbackViewController.m
//  TanzSalonApp
//
//  Created by Avtar Guleria on 07/06/14.
//  Copyright (c) 2014 Avtar Guleria. All rights reserved.
//

#import "FeedbackViewController.h"
#import "SalonRoot.h"
#import "SalonParser.h"
#import "SalonData.h"
#import "ValidationUtil.h"
#import "JsonUtil.h"


@interface FeedbackViewController ()
{
     AutoScroller *scroller;
    
    NSMutableArray *salonNames;
    PickerViewFactory *pickerViewFactory;
    NSMutableArray *salons;
    SalonData *selectedSalon;
    
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *telephoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@property (weak, nonatomic) IBOutlet UIButton *nearestSalonButton;
@property (weak, nonatomic) IBOutlet UITextView *feedbackTextView;
@end

@implementation FeedbackViewController

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
    [self.firstNameTextField setPadding:10];
    [self.lastNameTextField setPadding:10];
    [self.telephoneNumberTextField setPadding:10];
    [self.emailTextField setPadding:10];
    
    scroller=[AutoScroller addAutoScrollTo:self.scrollview];
    scroller.topPadding=-10;
    
    self.scrollview.contentSize=CGSizeMake(self.scrollview.frame.size.width, 530);
    
    //Get all salons
    NSString *url=[NSString stringWithFormat:@"%@getAllSaloons",kBaseUrl];
    [self sendHttpGetRequest:url andRequestId:100];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-IBAction Methods.
- (IBAction)salonButtonClicked:(id)sender {
    if(salonNames.count>0){
        pickerViewFactory=[PickerViewFactory addPickerViewForArray:salonNames withTitle:@"Select Salon" inContainerView:self.view];
        pickerViewFactory.delegate=self;
   
          self.scrollview.userInteractionEnabled=NO;
    }else{
        [self showAlert:@"No nearby salon available."];
    }
    
}
- (IBAction)submitButtonClicked:(id)sender {
   
    if ([self isValidForm]) {
        //Get all services
        NSString *url=[NSString stringWithFormat:@"%@sendFeedback&saloonID=%@&firstName=%@&lastName=%@&mobileNumber=%@&emailID=%@&feedback=%@",kBaseUrl,selectedSalon.saloonID,self.firstNameTextField.text,self.lastNameTextField.text,self.telephoneNumberTextField.text,self.emailTextField.text,self.feedbackTextView.text];
        
        url= [url stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
        
        [self sendHttpGetRequest:url andRequestId:101];

        
    }
    
}
-(BOOL)isValidForm{
    BOOL isValid=NO;
    
    if([ValidationUtil isValidTextInTextField:self.firstNameTextField] && [ValidationUtil isValidTextInTextField:self.telephoneNumberTextField] && [ValidationUtil isValidTextInTextField:self.emailTextField]){
        
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

#pragma mark- Picker Delegate.
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row{
    
    selectedSalon=[salons objectAtIndex:row];
    
    [self setButtonTitle:selectedSalon.saloonName forButton:self.nearestSalonButton];
    
    self.scrollview.userInteractionEnabled=YES;
    
}

-(void)pickerViewDidCancel:(UIPickerView *)pickerView
{
    self.scrollview.userInteractionEnabled=YES;
}



@end
