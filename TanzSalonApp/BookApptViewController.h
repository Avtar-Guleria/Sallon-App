//
//  BookApptViewController.h
//  TanzSalonApp
//
//  Created by Avtar Guleria on 08/04/14.
//  Copyright (c) 2014 Avtar Guleria. All rights reserved.
//

#import "BaseViewController.h"
#import "SalonData.h"
#import "DatePickerViewFactory.h"
#import "TimePickerViewFactory.h"
#import "PickerViewFactory.h"


@interface BookApptViewController : BaseViewController<CustomDatePickerViewDelegate,CustomTimePickerViewDelegate,CustomPickerViewDelegate>



@property(nonatomic,strong)SalonData *salon;

@end
