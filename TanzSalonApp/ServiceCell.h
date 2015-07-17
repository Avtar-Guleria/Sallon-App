//
//  ServiceCell.h
//  TanzSalonApp
//
//  Created by Avtar Guleria on 07/06/14.
//  Copyright (c) 2014 Avtar Guleria. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol checkBoxClicked <NSObject>

-(void)checkBoxClickedWithIndex:(int)index isSelected:(BOOL)isSelected;

@end

@interface ServiceCell : UITableViewCell


@property(nonatomic,strong)id<checkBoxClicked> checkBoxDelegate;

@property (weak, nonatomic) IBOutlet UILabel *serviceName;
@property (weak, nonatomic) IBOutlet UIButton *checkBox;
- (IBAction)checkBoxButtonClicked:(id)sender;



@end
