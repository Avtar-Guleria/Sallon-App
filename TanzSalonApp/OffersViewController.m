//
//  OffersViewController.m
//  TanzSalonApp
//
//  Created by Avtar Guleria on 07/04/14.
//  Copyright (c) 2014 Avtar Guleria. All rights reserved.
//

#import "OffersViewController.h"
#import "OfferRoot.h"
#import "OfferParser.h"
#import "OfferData.h"
#import "SubscribeViewController.h"
#import "OfferDetailViewController.h"

@interface OffersViewController ()

{
    NSMutableArray *offers;
    OfferData *selectedOffer;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation OffersViewController

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
    //Get all salons
    NSString *url=[NSString stringWithFormat:@"%@getAllOffers",kBaseUrl];
    [self sendHttpGetRequest:url andRequestId:100];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark- TableView Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return offers.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    
    SingleLabelCell *cell=(SingleLabelCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    OfferData *data=[offers objectAtIndex:indexPath.row];
    
    cell.titleLabel.text=data.offerName;
    
    if(data.isSubscribable){
//        cell.titleLabel.textColor=[UIColor whiteColor];
//        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }else{
//        cell.titleLabel.textColor=[UIColor greenColor];
//        cell.accessoryType=UITableViewCellAccessoryNone;
    }
        cell.accessoryType=UITableViewCellAccessoryNone;    
    
    return  cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    selectedOffer=[offers objectAtIndex:indexPath.row];

    if([selectedOffer isSubscribable]){
        [self showAlertViewWithTitle:selectedOffer.offerName message:selectedOffer.offerDescription  leftButtonTitle:@"Cancel" rightTitle:@"Subscribe"];
        self.alertDelegate=self;
    }else{
        [self showAlertWithTitle:selectedOffer.offerName message:selectedOffer.offerDescription];
    }
    
}



-(void)alertViewRightButtonClicked{
    SubscribeViewController *vc= [self.storyboard instantiateViewControllerWithIdentifier:@"SubscribeViewController"];
    vc.offerData  =selectedOffer;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark- Network Method
-(void)didReceiveData:(NSData *)data error:(NSError *)error andRequestId:(int)requestId
{
    switch (requestId) {
        case 100:
        {
            OfferRoot *offerRoot=[OfferParser parseOffers:data];
            
            if(offerRoot){
                
                
                if([offerRoot.responseCode isEqualToString:@"200"]){
                    
                    if (offerRoot && offerRoot.data.count>0) {
                        offers=offerRoot.data;
                        
                        [self.tableView reloadData];
                    }else{
                        [self showAlert:@"No Offers found."];
                    }
                    
                }
            }
        }
            
            break;
    }
}

@end
