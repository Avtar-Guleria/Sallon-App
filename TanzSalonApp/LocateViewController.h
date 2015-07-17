//
//  LocateViewController.h
//  TanzSalonApp
//
//  Created by Avtar Guleria on 07/04/14.
//  Copyright (c) 2014 Avtar Guleria. All rights reserved.
//

#import "BaseViewController.h"
#import "ServiceCell.h"
#import "LocationUtil.h"
@interface LocateViewController : BaseViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,checkBoxClicked,LocationRecieved>
{
    
    
    
}

//IBactions
- (IBAction)checkBoxClicked:(id)sender;

@end
