//
//  SearchResultViewController.h
//  TanzSalonApp
//
//  Created by Avtar Guleria on 08/04/14.
//  Copyright (c) 2014 Avtar Guleria. All rights reserved.
//

#import "BaseViewController.h"
#import "SalonData.h"


@interface SearchResultViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray *salons;
@property(nonatomic, strong)NSString *searchFilterString;

@end
