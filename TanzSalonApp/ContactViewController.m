//
//  ContactViewController.m
//  TanzSalonApp
//
//  Created by Avtar Guleria on 07/04/14.
//  Copyright (c) 2014 Avtar Guleria. All rights reserved.
//

#import "ContactViewController.h"
#import "FeedbackViewController.h"
#import "MakeABookingViewController.h"
#import "IconLabelCell.h"

@interface ContactViewController ()
{
    
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ContactViewController

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
    return 6;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    
    IconLabelCell *cell=(IconLabelCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.titleLabel.text=[self getLabel:indexPath.row];
    cell.cellImageView.image=[self getImageForCell:indexPath.row];
    
    return  cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [self.tabBarController setSelectedIndex:1];
            
            break;
        case 1:{
        //Open Facebook Page URL
            [self openBrowser:@"https://www.facebook.com/tanztanning"];
            
        }
            break;
        case 2:{
            //Open Twitter Page URL
            [self openBrowser:@"https://twitter.com/TanzTanning"];
            
        }
            break;

            
        case 3:{
            //Open Mail Composer
           [self sendMailWithEmailId:@"info@tanztanning.co.uk" messageBody:@"" subject:@""];
        }
            break;

        
        case 4:{
            FeedbackViewController *vc= [self.storyboard instantiateViewControllerWithIdentifier:@"FeedbackViewController"];
           
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 5:{
            MakeABookingViewController *vc= [self.storyboard instantiateViewControllerWithIdentifier:@"MakeABookingViewController"];
            
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
    }

}

#pragma mark- BL Methods
-(NSString *)getLabel:(int)index{
    
    
    switch (index) {
        case 0:
            return @"Salon Details";
            break;
        case 1:
            return @"Facebook";
            break;
        case 2:
            return @"Twitter";
            break;
        case 3:
            return @"Email";
            break;
        case 4:
            return @"Feedback";
            break;
        case 5:
            return @"Make a Booking";
            break;
    }
    
    return nil;
}

-(UIImage*)getImageForCell:(int)index{
    
    
    switch (index) {
        case 0:
            return [UIImage imageNamed:@"btn_home1.png"];
            break;
        case 1:
            return [UIImage imageNamed:@"btn_facebook1.png"];
            break;
        case 2:
           return [UIImage imageNamed:@"btn_twitter1.png"];
            break;
        case 3:
            return [UIImage imageNamed:@"btn_mail1.png"];
            break;
        case 4:
           return [UIImage imageNamed:@"btn_feedback1.png"];
            break;
        case 5:
            return [UIImage imageNamed:@"btn_booking1.png"];
            break;
    }
    
    return nil;
}


- (IBAction)shareButtonClicked:(id)sender {

    [self shareText:@"Keep Calm and Come to Tanz" andImage:[UIImage imageNamed:@"img_logo@2x.png"]];
    
}


@end
