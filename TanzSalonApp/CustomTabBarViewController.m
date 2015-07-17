////
////  CustomTabBarViewController.m
////  Template
////
////  Created by Sukhpal on 4/26/14.
////  Copyright (c) 2014 XAV-MAC13. All rights reserved.
////
//
//#import "CustomTabBarViewController.h"
//
//@interface CustomTabBarViewController ()
//
//@end
//
//@implementation CustomTabBarViewController
//
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    self.tabBar.tintColor = [UIColor blackColor];
//    
//    // set color of selected text
//    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], UITextAttributeTextColor, nil] forState:UIControlStateSelected];
//    
//    
//    // set color of unselected text
//    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, nil]
//                                             forState:UIControlStateNormal];
//    
//    // set selected and unselected icons
//    UITabBarItem *item = [self.tabBar.items objectAtIndex:0];
//    
//    // this way, the icon gets rendered as it is (thus, it needs to be green in this example)
//    item.image = [[UIImage imageNamed:@"img_tab_home.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    item.selectedImage = [[UIImage imageNamed:@"img_tab_home.png"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    
//    // this icon is used for selected tab and it will get tinted as defined in self.tabBar.tintColor
//   // item0.selectedImage = [UIImage imageNamed:@"tab_clockin.png"];
//	// Do any additional setup after loading the view.
//    
//    item = [self.tabBar.items objectAtIndex:1];
//    
//    // this way, the icon gets rendered as it is (thus, it needs to be green in this example)
//    item.image = [[UIImage imageNamed:@"img_tab_locate.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    item.selectedImage = [[UIImage imageNamed:@"img_tab_locate.png"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    
//    item = [self.tabBar.items objectAtIndex:2];
//    
//    // this way, the icon gets rendered as it is (thus, it needs to be green in this example)
//    item.image = [[UIImage imageNamed:@"img_tab_offer.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    item.selectedImage = [[UIImage imageNamed:@"img_tab_offer.png"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    
//    
//    item = [self.tabBar.items objectAtIndex:3];
//    
//    
//    // this way, the icon gets rendered as it is (thus, it needs to be green in this example)
//    item.image = [[UIImage imageNamed:@"img_tab_contact.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    item.selectedImage = [[UIImage imageNamed:@"img_tab_contact.png"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    
//    
//    item = [self.tabBar.items objectAtIndex:4];
//    
//    
//    // this way, the icon gets rendered as it is (thus, it needs to be green in this example)
//    item.image = [[UIImage imageNamed:@"img_tab_more.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    item.selectedImage = [[UIImage imageNamed:@"img_tab_more.png"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//}
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//@end
