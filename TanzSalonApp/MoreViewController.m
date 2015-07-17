//
//  MoreViewController.m
//  TanzSalonApp
//
//  Created by Avtar Guleria on 07/04/14.
//  Copyright (c) 2014 Avtar Guleria. All rights reserved.
//

#import "MoreViewController.h"
#import "ServicesViewController.h"
#import "IconLabelCell.h"
#import "HolidayViewController.h"


@interface MoreViewController ()
{
    
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation MoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- TableView Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    
    IconLabelCell *cell=(IconLabelCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    switch (indexPath.row) {
        case 0:
            cell.titleLabel.text=@"Services";
          cell.cellImageView.image=[UIImage imageNamed:@"btn_home1.png"];
            
            break;
        
        case 1:
            cell.titleLabel.text=@"Visit our website";
            cell.cellImageView.image=[UIImage imageNamed:@"btn_shop1.png"];
            break;
            
        case 2:
            cell.titleLabel.text=@"Videos";
            cell.cellImageView.image=[UIImage imageNamed:@"btn_youtube1.png"];

            break;
        case 3:
            cell.titleLabel.text=@"Holiday Weather Watch";
            cell.cellImageView.image=[UIImage imageNamed:@"btn_home1.png"];
            
            break;
    }
 
    
    
    return  cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:{
            ServicesViewController *vc= [self.storyboard instantiateViewControllerWithIdentifier:@"ServicesViewController"];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        
        case 1:
           [self openBrowser:@"http://www.tanztanning.co.uk/"];
            break;
            
        case 2:
           [self openBrowser:@"https://www.youtube.com/user/TanzTanningSalons"];
            break;
        case 3:{
            HolidayViewController *vc1= [self.storyboard instantiateViewControllerWithIdentifier:@"HolidayViewController"];
            [self.navigationController pushViewController:vc1 animated:YES];
            }
            break;
    }
    
    

}

#pragma  mark-IBaction Methods.

@end
