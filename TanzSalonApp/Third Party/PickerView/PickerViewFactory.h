//
//  PickerViewUtil.h
//  OTS
//
//  Created by Avtar Singh on 3/28/13.
//  Copyright (c) 2013 Xavient Information System. All rights reserved.
//

#import <Foundation/Foundation.h>



@protocol CustomPickerViewDelegate <NSObject>

@required
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row;
-(void)pickerViewDidCancel:(UIPickerView *)pickerView;

@end


@interface PickerViewFactory : NSObject<UIPickerViewDataSource,UIPickerViewDelegate>

{
    int selectedRowIndex;
    
}

@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) IBOutlet UIView *view;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;

@property (strong, nonatomic) NSMutableArray *contents;
@property (strong, nonatomic) id<CustomPickerViewDelegate> delegate;


//constructor.
-(id)initWithArray:(NSMutableArray*)items andTitle:(NSString*)title containerView:(UIView*)cView;

//Public Methods.
+(PickerViewFactory*)addPickerViewForArray:(NSMutableArray*)array withTitle:(NSString*)title inContainerView:(UIView*)cView;



//public IBActions.
- (IBAction)toolbarCancelButtonClicked:(id)sender;
- (IBAction)toolbarDoneButtonClicked:(id)sender;

@end
