//
//  SalonDetailViewController.m
//  TanzSalonApp
//
//  Created by Avtar Guleria on 08/04/14.
//  Copyright (c) 2014 Avtar Guleria. All rights reserved.
//

#import "SalonDetailViewController.h"
#import "SingleLabelCell.h"
#import "ServiceData.h"
#import "UIImageView+WebCache.h"
#import "BookApptViewController.h"


@interface SalonDetailViewController ()
{
    
}
@property (weak, nonatomic) IBOutlet UILabel *navigationTitleLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UITableView *serviceTableView;

@property (weak, nonatomic) IBOutlet UILabel *m_f_time;
@property (weak, nonatomic) IBOutlet UILabel *sat_TimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *sunday_TimeLabel;

@end

@implementation SalonDetailViewController

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
    
    [self updateUI];
    
    
    self.scrollView.contentSize=CGSizeMake(self.scrollView.frame.size.width, 550);
}

-(void)updateUI{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kImageBaseURL,self.salon.imagePath]] placeholderImage:[UIImage imageNamed:@"img_header_logo@2x.png"]];
    self.navigationTitleLabel.text=self.salon.saloonName;
    self.addressLabel.text=self.salon.saloonAddress;
    self.phoneLabel.text=self.salon.phoneNumber;
    callButton = [[UIButton alloc] initWithFrame:self.phoneLabel.frame];
    [callButton addTarget:self action:@selector(callTheSalon) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:callButton];
    self.m_f_time.text=self.salon.timeMtoF;
    self.sat_TimeLabel.text=self.salon.timeSat;
    self.sunday_TimeLabel.text=self.salon.timeSun;
    
    [self.serviceTableView reloadData];
}

- (void)callTheSalon{
    NSLog(@"The phone number %@", self.phoneLabel.text);
    NSCharacterSet *notNumbers = [[NSCharacterSet characterSetWithCharactersInString:@"+0123456789"] invertedSet];
    NSString* phNumber = [[self.phoneLabel.text componentsSeparatedByCharactersInSet:notNumbers] componentsJoinedByString:@""];
    NSString *phoneNumber = [@"tel://" stringByAppendingString:phNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)bookAnAppointment:(id)sender {
    BookApptViewController *vc= [self.storyboard instantiateViewControllerWithIdentifier:@"BookApptViewController"];
    vc.salon  =self.salon;
    [self.navigationController pushViewController:vc animated:YES];

}


#pragma mark- TableView Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.salon.services.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   return 22;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    
    SingleLabelCell *cell=(SingleLabelCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    ServiceData *service=[self.salon.services objectAtIndex:indexPath.row];
    cell.titleLabel.text=[NSString stringWithFormat:@"%d) %@",indexPath.row+1, service.serviceName];
   
    
    return  cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
