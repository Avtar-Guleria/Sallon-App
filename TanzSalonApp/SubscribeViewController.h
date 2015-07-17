//
//  SubscribeViewController.h
//  TanzSalonApp
//
//  Created by Avtar Guleria on 15/06/14.
//  Copyright (c) 2014 Avtar Guleria. All rights reserved.
//

#import "BaseViewController.h"
#import "SalonData.h"
#import "DatePickerViewFactory.h"
#import "TimePickerViewFactory.h"
#import "PickerViewFactory.h"
#import "OfferData.h"


@interface SubscribeViewController : BaseViewController<CustomPickerViewDelegate,CustomDatePickerViewDelegate>


@property(nonatomic,strong)OfferData *offerData;
@end
