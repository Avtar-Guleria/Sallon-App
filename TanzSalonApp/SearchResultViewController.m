//
//  SearchResultViewController.m
//  TanzSalonApp
//
//  Created by Avtar Guleria on 08/04/14.
//  Copyright (c) 2014 Avtar Guleria. All rights reserved.
//

#import "SearchResultViewController.h"
#import "SearchResultCell.h"
#import "SalonDetailViewController.h"

@interface SearchResultViewController ()
{
    
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *searchFilterLabel;

@end

@implementation SearchResultViewController

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

-(void)initUIComponents
{
      self.searchFilterLabel.text=self.searchFilterString;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark- TableView Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.salons.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    
    SearchResultCell *cell=(SearchResultCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    SalonData *salon=[self.salons objectAtIndex:indexPath.row];
    cell.titleLabel.text=salon.saloonName;
    cell.addressLabel.text=salon.saloonAddress;
    
    if(salon.distance && salon.distance.intValue >0){
        cell.distanceLabel.hidden=NO;
        
        cell.distanceLabel.text=[NSString stringWithFormat:@"%@ m",salon.distance  ];
        
//        cell.addressLabel.frame=CGRectMake(cell.addressLabel.frame.origin.x, cell.addressLabel.frame.origin.y, cell.addressLabel.frame.size.width+20, cell.addressLabel.frame.size.height);
        
    }else{
        cell.distanceLabel.hidden=YES;
        
       cell.addressLabel.frame=CGRectMake(cell.addressLabel.frame.origin.x, cell.addressLabel.frame.origin.y, 160, cell.addressLabel.frame.size.height);
    }
   
    
    return  cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SalonDetailViewController *vc= [self.storyboard instantiateViewControllerWithIdentifier:@"SalonDetailViewController"];
    vc.salon  =[self.salons objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];

}

@end
