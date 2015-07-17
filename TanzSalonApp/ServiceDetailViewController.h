//
//  ServiceDetailViewController.h
//  TanzSalonApp
//
//  Created by Avtar Guleria on 14/06/14.
//  Copyright (c) 2014 Avtar Guleria. All rights reserved.
//

#import "BaseViewController.h"
#import "ServiceData.h"


@interface ServiceDetailViewController : BaseViewController<UIWebViewDelegate>


@property(nonatomic,strong)ServiceData *service;

@end
