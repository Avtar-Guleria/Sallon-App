//
//  SearchResultCell.h
//  TanzSalonApp
//
//  Created by Avtar Guleria on 07/06/14.
//  Copyright (c) 2014 Avtar Guleria. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@end
