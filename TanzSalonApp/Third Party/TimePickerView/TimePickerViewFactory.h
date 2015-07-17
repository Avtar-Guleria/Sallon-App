//
//  PickerViewUtil.h
//  OTS
//
//  Created by Avtar Singh on 3/28/13.
//  Copyright (c) 2013 Xavient Information System. All rights reserved.
//

#import <Foundation/Foundation.h>



@protocol CustomTimePickerViewDelegate <NSObject>

@required

-(void)timePickerView:(UIDatePicker *)timePickerView didSelectDate:(NSDate*)date;
-(void)timePickerViewDidCancel:(UIDatePicker *)timePickerView;

@end


@interface TimePickerViewFactory : NSObject

{
    
}

@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) IBOutlet UIView *view;
@property (strong, nonatomic) IBOutlet UIDatePicker *pickerView;

@property (strong, nonatomic) id<CustomTimePickerViewDelegate> delegate;


//Public Methods.
+(TimePickerViewFactory*)addTimePickerViewWithTitle:(NSString*)title inContainerView:(UIView*)cView;



//public IBActions.
- (IBAction)toolbarCancelButtonClicked:(id)sender;
- (IBAction)toolbarDoneButtonClicked:(id)sender;

@end
