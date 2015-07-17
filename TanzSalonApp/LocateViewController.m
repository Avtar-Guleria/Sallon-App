//
//  LocateViewController.m
//  TanzSalonApp
//
//  Created by Avtar Guleria on 07/04/14.
//  Copyright (c) 2014 Avtar Guleria. All rights reserved.
//

#import "LocateViewController.h"
#import "SalonParser.h"
#import "SalonRoot.h"
#import "SalonData.h"
#import "SearchResultViewController.h"
#import "ServiceRoot.h"
#import "ServiceParser.h"
#import "ServiceData.h"
#import "LocationUtil.h"
#import "MBProgressHUD.h"
#import "SalonDetailViewController.h"

@interface LocateViewController ()
{
    SalonRoot * salonRoot;
    NSMutableArray  *salons;
    
    ServiceRoot *serviceRoot;
    NSMutableArray *services;
    
    SalonRoot * searchedSalonRoot;
    NSMutableArray  *searchedSalons;
    
    NSMutableArray *selectedServices;
    
   LocationUtil *locationUtil;
}


@property (weak, nonatomic) IBOutlet UITextField *locationTextFieldDelegate;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableView *serviceTableView;

@end

@implementation LocateViewController

int SERVICE_TABLE_TAG=17;
int SALON_TABLE_TAG=18;

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
    
    selectedServices=[[NSMutableArray alloc]init];
    
    //Get all salons
    NSString *url=[NSString stringWithFormat:@"%@getAllSaloons",kBaseUrl];
    [self sendHttpGetRequest:url andRequestId:100];
    
    //Get all services
    NSString *serviceUrl=[NSString stringWithFormat:@"%@getAllServices",kBaseUrl];
    [self sendHttpGetRequest:serviceUrl andRequestId:101];
}

-(void)initUIComponents{
    [self.locationTextFieldDelegate setPadding:10];
}


#pragma mark-IBaction methods.


- (IBAction)searchButtonClicked:(id)sender {

    NSMutableString *selectedServiceString=[[NSMutableString alloc]init];
    NSString *formmatedService=@"";

    if(selectedServices && selectedServices.count>0){
        for(ServiceData *service in selectedServices){
            [selectedServiceString appendString:[NSString stringWithFormat:@"%@,",service.serviceID]];
        }
        
        formmatedService=[selectedServiceString substringToIndex:selectedServiceString.length-1];
     }

    //Search salons
    NSString *url=[NSString stringWithFormat:@"%@searchSaloons&servicesID=%@&nearBy=%@",kBaseUrl,formmatedService,self.locationTextFieldDelegate.text];
    url= [url stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    [self sendHttpGetRequest:url andRequestId:102];
}

- (IBAction)locationButtonClicked:(id)sender {
      if ([self isInternetAvailable]) {
          locationUtil=[[LocationUtil alloc]init];
          locationUtil.locationDelegate=self;
          [locationUtil startLocationManagerForViewController:self];
      }
    
}


-(void)addressRetrievedSuccessfully:(NSString *)formattedAddress{
    self.locationTextFieldDelegate.text=formattedAddress;
}

-(void)failedToGetLocation{
    [self showAlert:@"Unable to get your current location."];
}

#pragma mark-TextField Delegates.

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return  YES;
}



#pragma mark- TableView Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag==SERVICE_TABLE_TAG){
       return services.count;
    }else if(tableView.tag==SALON_TABLE_TAG){
       return salons.count;
    }
    
    return 0;
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag==SERVICE_TABLE_TAG){
        return 25;
    }else if(tableView.tag==SALON_TABLE_TAG){
        return 44;
    }
    
    return 0;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    
    if(tableView.tag==SERVICE_TABLE_TAG){
        ServiceCell *cell=(ServiceCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        ServiceData *service=[services objectAtIndex:indexPath.row];
        cell.serviceName.text=service.serviceName;
        
        if(service.isSelected){
            [cell.checkBox setSelected:YES];
        }else{
            [cell.checkBox setSelected:NO];
        }
        
        cell.checkBox.tag=indexPath.row;
        cell.checkBoxDelegate=self;
        
        return  cell;
        
    }else if(tableView.tag==SALON_TABLE_TAG){
        SingleLabelCell *cell=(SingleLabelCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        SalonData *salon=[salons objectAtIndex:indexPath.row];
        cell.titleLabel.text=salon.saloonName;
        
        return  cell;
    }
    
    return nil;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag==SERVICE_TABLE_TAG){
        
    }else if (tableView.tag==SALON_TABLE_TAG){
        SalonDetailViewController *vc= [self.storyboard instantiateViewControllerWithIdentifier:@"SalonDetailViewController"];
        vc.salon  =[salons objectAtIndex:indexPath.row];
       [self.navigationController pushViewController:vc animated:YES];

    }
}

-(void)checkBoxClickedWithIndex:(int)index isSelected:(BOOL)isSelected
{
    ServiceData *service=[services objectAtIndex:index];
    service.isSelected=isSelected;
 
    if(service.isSelected){
        [selectedServices addObject:service];
    }else{
        [selectedServices removeObject:service];
    }
    
    [services replaceObjectAtIndex:index withObject:service];
}

#pragma mark-Network Methods.
#pragma mark- Network Method
-(void)didReceiveData:(NSData *)data error:(NSError *)error andRequestId:(int)requestId
{
    switch (requestId) {
        case 100:
        {
            salonRoot=[SalonParser parseSalons:data];
            
            if(salonRoot){
              
                
                if([salonRoot.responseCode isEqualToString:@"200"]){
                    
                    if (salonRoot && salonRoot.data.count>0) {
                        salons=salonRoot.data;
                        
                        [self.tableView reloadData];
                    }else{
                        [self showAlert:@"No Salon found."];
                    }
                    
                }
            }
        }
            
            break;

        case 101:
        {
            serviceRoot=[ServiceParser parseServices:data];
            
            if(serviceRoot){
                
                
                if([serviceRoot.responseCode isEqualToString:@"200"]){
                    
                    if (serviceRoot && serviceRoot.data.count>0) {
                        services=serviceRoot.data;
                        
                        [self.serviceTableView reloadData];
                       
                    }else{
                        [self showAlert:@"No Services found."];
                    }
                    
                }
            }
        }
            
            break;
        case 102:
        {
            searchedSalonRoot=[SalonParser parseSalons:data];
            
            if(searchedSalonRoot){
                
                
                if([searchedSalonRoot.responseCode isEqualToString:@"200"]){
                    
                    if (searchedSalonRoot && searchedSalonRoot.data.count>0) {
                        searchedSalons=searchedSalonRoot.data;
                     
                       SearchResultViewController *vc= [self.storyboard instantiateViewControllerWithIdentifier:@"SearchResultViewController"];
                        vc.salons  =searchedSalons;
                        vc.searchFilterString=[NSString stringWithFormat:@"Salon near %@",self.locationTextFieldDelegate.text];
                        [self.navigationController pushViewController:vc animated:YES];
                        
                    }else{
                        [self showAlert:@"No Salon found."];
                    }
                    
                }
            }
        }
            
            break;

    
    
    }
   [MBProgressHUD hideHUDForView:self.view animated:YES];
}


@end
