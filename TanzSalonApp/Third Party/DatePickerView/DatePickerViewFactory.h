//
//  PickerViewUtil.h
//  OTS
//
//  Created by Avtar Singh on 3/28/13.
//  Copyright (c) 2013 Xavient Information System. All rights reserved.
//

#import <Foundation/Foundation.h>



@protocol CustomDatePickerViewDelegate <NSObject>

@required
-(void)datePickerView:(UIDatePicker *)datePickerView didSelectDate:(NSDate*)date;
-(void)datePickerViewDidCancel:(UIDatePicker *)datePickerView;

@end


@interface DatePickerViewFactory : NSObject

{
    
}

@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) IBOutlet UIView *view;
@property (strong, nonatomic) IBOutlet UIDatePicker *pickerView;

@property (strong, nonatomic) id<CustomDatePickerViewDelegate> delegate;


//Public Methods.
+(DatePickerViewFactory*)addDatePickerViewWithTitle:(NSString*)title inContainerView:(UIView*)cView;



//public IBActions.
- (IBAction)toolbarCancelButtonClicked:(id)sender;
- (IBAction)toolbarDoneButtonClicked:(id)sender;

@end
