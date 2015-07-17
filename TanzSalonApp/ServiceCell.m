//
//  ServiceCell.m
//  TanzSalonApp
//
//  Created by Avtar Guleria on 07/06/14.
//  Copyright (c) 2014 Avtar Guleria. All rights reserved.
//

#import "ServiceCell.h"

@implementation ServiceCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)checkBoxButtonClicked:(id)sender {
    
    UIButton *button=(UIButton*)sender;
    
    ([button isSelected])?[button setSelected:NO]:[button setSelected:YES];
    
    [self.checkBoxDelegate checkBoxClickedWithIndex:button.tag isSelected:[button isSelected]];
}
@end
