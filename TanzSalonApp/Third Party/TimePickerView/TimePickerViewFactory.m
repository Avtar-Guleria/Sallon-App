//
//  PickerViewUtil.m
//  OTS
//
//  Created by Avtar Singh on 3/28/13.
//  Copyright (c) 2013 Xavient Information System. All rights reserved.
//

#import "TimePickerViewFactory.h"
#import "AnimationUtil.h"


@implementation TimePickerViewFactory

@synthesize  delegate, containerView,pickerView,view;

#pragma mark- init Methods.


-(id)initWithTitle:(NSString*)title containerView:(UIView*)cView
{
    self=[super init];
    if(self){
        [[NSBundle mainBundle]loadNibNamed:@"TimePickerView" owner:self options:nil];
        self.containerView=cView;
       
        
        //show picker view in Action sheet.
       [AnimationUtil addSubViewWithAnimation:self.view containerView:self.containerView];
    }
    return self;
}





#pragma mark- IBAction Methods.
- (IBAction)toolbarCancelButtonClicked:(id)sender {

    [self dismissActionSheet];
   
    [delegate timePickerViewDidCancel:self.pickerView];
}

- (IBAction)toolbarDoneButtonClicked:(id)sender {

    [self dismissActionSheet];
    
    [delegate timePickerView:self.pickerView didSelectDate:self.pickerView.date];
    
}



#pragma mark- BL Methods.


+(TimePickerViewFactory*)addTimePickerViewWithTitle:(NSString*)title inContainerView:(UIView*)cView
{
   
    TimePickerViewFactory *instance=[[TimePickerViewFactory alloc]initWithTitle:title containerView:cView];
    
    return instance;
}


-(void)dismissActionSheet
{
    [AnimationUtil removeViewWithAnimation:self.view containerView:self.containerView];
}


@end
