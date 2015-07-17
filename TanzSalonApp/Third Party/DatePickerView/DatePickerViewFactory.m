//
//  PickerViewUtil.m
//  OTS
//
//  Created by Avtar Singh on 3/28/13.
//  Copyright (c) 2013 Xavient Information System. All rights reserved.
//

#import "DatePickerViewFactory.h"
#import "AnimationUtil.h"


@implementation DatePickerViewFactory

@synthesize  delegate, containerView,pickerView,view;

#pragma mark- init Methods.


-(id)initWithTitle:(NSString*)title containerView:(UIView*)cView
{
    self=[super init];
    if(self){
        [[NSBundle mainBundle]loadNibNamed:@"DatePickerView" owner:self options:nil];
        self.containerView=cView;
       
        self.pickerView.minimumDate=[NSDate dateTomorrow];
        
        //show picker view in Action sheet.
       [AnimationUtil addSubViewWithAnimation:self.view containerView:self.containerView];
    }
    return self;
}





#pragma mark- IBAction Methods.
- (IBAction)toolbarCancelButtonClicked:(id)sender {

    [self dismissActionSheet];
   
    [delegate datePickerViewDidCancel:self.pickerView];
}

- (IBAction)toolbarDoneButtonClicked:(id)sender {

    [self dismissActionSheet];
    
    [delegate datePickerView:self.pickerView didSelectDate:self.pickerView.date];
    
}



#pragma mark- BL Methods.


+(DatePickerViewFactory*)addDatePickerViewWithTitle:(NSString*)title inContainerView:(UIView*)cView
{
   
    DatePickerViewFactory *instance=[[DatePickerViewFactory alloc]initWithTitle:title containerView:cView];
    
    return instance;
}


-(void)dismissActionSheet
{
    [AnimationUtil removeViewWithAnimation:self.view containerView:self.containerView];}


@end
