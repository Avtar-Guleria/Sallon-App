//
//  ServicesViewController.m
//  TanzSalonApp
//
//  Created by Avtar Guleria on 14/06/14.
//  Copyright (c) 2014 Avtar Guleria. All rights reserved.
//

#import "ServicesViewController.h"
#import "ServiceRoot.h"
#import "ServiceParser.h"
#import "ServiceData.h"
#import "SingleLabelCell.h"
#import "ServiceDetailViewController.h"

@interface ServicesViewController ()
{
    ServiceRoot *serviceRoot;
    NSMutableArray *services;

}

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation ServicesViewController

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

    //Get all services
    NSString *serviceUrl=[NSString stringWithFormat:@"%@getAllServices",kBaseUrl];
    [self sendHttpGetRequest:serviceUrl andRequestId:101];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- TableView Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return services.count;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    
   
        SingleLabelCell *cell=(SingleLabelCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        ServiceData *service=[services objectAtIndex:indexPath.row];
        cell.titleLabel.text=service.serviceName;
        
    
        
        return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ServiceDetailViewController *vc= [self.storyboard instantiateViewControllerWithIdentifier:@"ServiceDetailViewController"];
    vc.service  =[services objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark- Network Method
-(void)didReceiveData:(NSData *)data error:(NSError *)error andRequestId:(int)requestId
{
    switch (requestId) {
            
        case 101:
        {
            serviceRoot=[ServiceParser parseServices:data];
            if(serviceRoot){
                if([serviceRoot.responseCode isEqualToString:@"200"]){
                    
                    if (serviceRoot && serviceRoot.data.count>0) {
                        services=serviceRoot.data;
                        [self.tableview reloadData];
                    }else{
                        [self showAlert:@"No Services found."];
                    }
                }
            }
        }
            
            break;
       
    }
}


@end
