//
//  PickerViewUtil.m
//  OTS
//
//  Created by Avtar Singh on 3/28/13.
//  Copyright (c) 2013 Xavient Information System. All rights reserved.
//

#import "PickerViewFactory.h"
#import "AnimationUtil.h"

@implementation PickerViewFactory

@synthesize contents, delegate, containerView,pickerView,view;

#pragma mark- init Methods.


-(id)initWithArray:(NSMutableArray*)items andTitle:(NSString*)title containerView:(UIView*)cView
{
    self=[super init];
    if(self){
        [[NSBundle mainBundle]loadNibNamed:@"PickerView" owner:self options:nil];
        self.contents=items;
        self.containerView=cView;
       
        //show picker view in Action sheet.
        [AnimationUtil addSubViewWithAnimation:self.view containerView:self.containerView];
    }
    return self;
}




#pragma mark- IBAction Methods.
- (IBAction)toolbarCancelButtonClicked:(id)sender {

    [self dismissActionSheet];
   
    [delegate pickerViewDidCancel:self.pickerView];
}

- (IBAction)toolbarDoneButtonClicked:(id)sender {

    [self dismissActionSheet];
    
    [delegate pickerView:self.pickerView didSelectRow:selectedRowIndex];
    
}


#pragma mark- PickerView Delegate Methods.
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}


-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.contents.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
        return [self.contents objectAtIndex:row];
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    selectedRowIndex=row;
    
}


#pragma mark- BL Methods.


+(PickerViewFactory*)addPickerViewForArray:(NSMutableArray*)array withTitle:(NSString*)title inContainerView:(UIView*)cView
{
       
    PickerViewFactory *instance=[[PickerViewFactory alloc]initWithArray:array andTitle:title containerView:cView];
    return instance;
}


-(void)dismissActionSheet
{
     [AnimationUtil removeViewWithAnimation:self.view containerView:self.containerView];
}


@end
