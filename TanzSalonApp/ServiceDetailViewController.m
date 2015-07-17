//
//  ServiceDetailViewController.m
//  TanzSalonApp
//
//  Created by Avtar Guleria on 14/06/14.
//  Copyright (c) 2014 Avtar Guleria. All rights reserved.
//

#import "ServiceDetailViewController.h"
#import "MakeABookingViewController.h"
#import "MBProgressHUD.h"

@interface ServiceDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *navTitleLabel;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *infoButton;

@end

@implementation ServiceDetailViewController

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
    
    self.navTitleLabel.text=self.service.serviceName;
  
    self.webView.delegate=self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.service.serviceURL.trim]]];
    
    if(self.service.isBookable){
        self.infoButton.hidden=NO;
    }else{
        self.infoButton.hidden=YES;
    }
        
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)infoButtonClicked:(id)sender{
    MakeABookingViewController *vc= [self.storyboard instantiateViewControllerWithIdentifier:@"MakeABookingViewController"];
    
    [self.navigationController pushViewController:vc animated:YES];

}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    MBProgressHUD* hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText=@"Loading...";
    
    hud.detailsLabelText = @"Tap to cancel";
    [hud addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hudWasCancelled)]];
  }

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}
- (void)hudWasCancelled {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}


@end
