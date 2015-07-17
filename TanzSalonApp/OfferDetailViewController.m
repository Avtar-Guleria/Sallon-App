//
//  OfferDetailViewController.m
//  TanzSalonApp
//
//  Created by Avtar Guleria on 26/07/14.
//  Copyright (c) 2014 Avtar Guleria. All rights reserved.
//

#import "OfferDetailViewController.h"

@interface OfferDetailViewController ()
{
    
}

@property (nonatomic,weak)IBOutlet UITextView *textView;
@property (nonatomic,weak)IBOutlet UILabel *navLabel;

@end

@implementation OfferDetailViewController

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


    self.navLabel.text=self.offer.offerName;
    self.textView.text=self.offer.offerDescription;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)shareButtonClicked:(id)sender {
    
    [self shareText:self.offer.offerName andImage:[UIImage imageNamed:@"img_logo@2x.png"]];
    
}

@end
