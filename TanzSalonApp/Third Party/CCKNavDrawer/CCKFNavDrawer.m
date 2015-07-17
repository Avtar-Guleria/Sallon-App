//
//  CCKFNavDrawer.m
//  CCKFNavDrawer
//
//  Created by calvin on 23/1/14.
//  Copyright (c) 2014年 com.calvin. All rights reserved.
//

#import "CCKFNavDrawer.h"

#define SHAWDOW_ALPHA 0.5
#define MENU_DURATION 0.3
#define MENU_TRIGGER_VELOCITY 350

@interface CCKFNavDrawer ()



@end

@implementation CCKFNavDrawer

#pragma mark - VC lifecycle

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
    rightItems=[[NSMutableArray alloc]init];
    leftItems=[[NSMutableArray alloc]init];
    DrawerCellItem* item=[[DrawerCellItem alloc]init];
    item.title=@"Jobs";
    item.image=@"ic_action_event";
    [leftItems addObject:item];
    
    item=[[DrawerCellItem alloc]init];
    item.title=@"Messages";
    item.image=@"ic_action_email";
    [leftItems addObject:item];
    
    item=[[DrawerCellItem alloc]init];
    item.title=@"Schedules";
    item.image=@"ic_action_go_to_today";
    [leftItems addObject:item];
    
    item=[[DrawerCellItem alloc]init];
    item.title=@"Clinics";
    item.image=@"ic_action_clinic";
    [leftItems addObject:item];
    
    
    item=[[DrawerCellItem alloc]init];
    item.title=@"Profile";
    item.image=@"ic_action_person";
    [rightItems addObject:item];
    
    item=[[DrawerCellItem alloc]init];
    item.title=@"Help";
    item.image=@"ic_action_help";
    [rightItems addObject:item];
    
    
    item=[[DrawerCellItem alloc]init];
    item.title=@"About";
    item.image=@"ic_action_about";
    [rightItems addObject:item];
    
    item=[[DrawerCellItem alloc]init];
    item.title=@"Sign Out";
    item.image=@"ic_action_not_secure";
    [rightItems addObject:item];
    
    item=[[DrawerCellItem alloc]init];
    item.title=@"Search for a job";
    item.image=@"ic_action_search";
    [rightItems addObject:item];
    
    item=[[DrawerCellItem alloc]init];
    item.title=@"Post a job";
    item.image=@"ic_action_new_event";
    [rightItems addObject:item];
	// Do any additional setup after loading the view.
    
    [self setUpDrawer:NO];
    [self setUpDrawer:YES];
    [self.drawerView1.drawerTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - push & pop

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    
    // disable gesture in next vc
    [self.pan_gr setEnabled:NO];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    UIViewController *vc = [super popViewControllerAnimated:animated];
    
    // enable gesture in root vc
    if ([self.viewControllers count]==1){
        [self.pan_gr setEnabled:YES];
    }
    return vc;
}

#pragma mark - drawer

- (void)setUpDrawer:(BOOL)right
{
    self.isOpen = NO;
    
    // load drawer view
    self.drawerView = [[[NSBundle mainBundle] loadNibNamed:@"DrawerView" owner:self options:nil] objectAtIndex:0];
    if (self.view.frame.size.height<=480) {
        CGRect rect=self.drawerView.frame;
        rect.size.height=rect.size.height-88;
        self.drawerView.frame=rect;
    }
    self.meunHeight = self.drawerView.frame.size.height;
    self.menuWidth = self.drawerView.frame.size.width;
    self.outFrame = CGRectMake(-self.menuWidth,0,self.menuWidth,self.meunHeight);
    
    self.inFrame = CGRectMake (0,0,self.menuWidth,self.meunHeight);
    if (right) {
        self.outFrame = CGRectMake(320,0,self.menuWidth,self.meunHeight);
         self.inFrame = CGRectMake (320-self.menuWidth,0,self.menuWidth,self.meunHeight);
    }
    
    // drawer shawdow and assign its gesture
    self.shawdowView = [[UIView alloc] initWithFrame:self.view.frame];
    CGRect rect=self.shawdowView.frame;
    rect.size.height=rect.size.height-50;
    self.shawdowView.frame=rect;
    self.shawdowView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
    self.shawdowView.hidden = YES;
    self.tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                            action:@selector(tapOnShawdow:)];
    
    [self.shawdowView addGestureRecognizer:self.tapGest];
    self.shawdowView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.shawdowView];
    
    // add drawer view
    [self.drawerView setFrame:self.outFrame];
    [self.view addSubview:self.drawerView];
    
    // drawer list
    [self.drawerView.drawerTableView setContentInset:UIEdgeInsetsMake(64, 0, 0, 0)]; // statuesBarHeight+navBarHeight
    self.drawerView.drawerTableView.dataSource = self;
    self.drawerView.drawerTableView.delegate = self;
    
    // gesture on self.view
    self.pan_gr = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveDrawer:)];
    self.pan_gr.maximumNumberOfTouches = 1;
    self.pan_gr.minimumNumberOfTouches = 1;
    //self.pan_gr.delegate = self;
    //[self.view addGestureRecognizer:self.pan_gr];
    
    UISwipeGestureRecognizer* gest=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    [gest setDirection:UISwipeGestureRecognizerDirectionLeft ];
    
    [self.view addGestureRecognizer:gest];
    
    gest=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    [gest setDirection:UISwipeGestureRecognizerDirectionRight ];
    
    [self.view addGestureRecognizer:gest];
    
    [self.view bringSubviewToFront:self.navigationBar];
    if (!right) {
        self.shawdowView1=self.shawdowView;
        self.drawerView1=self.drawerView;
        self.inFrame1=self.inFrame;
        self.outFrame1=self.outFrame;
        self.pan_gr1=self.pan_gr;
        self.tapGest1=self.tapGest;
    }
    else
    {
        self.shawdowView2=self.shawdowView;
        self.drawerView2=self.drawerView;
        self.inFrame2=self.inFrame;
        self.outFrame2=self.outFrame;
        self.outFrame2=self.outFrame;
        self.pan_gr2=self.pan_gr;
        self.tapGest2=self.tapGest;
    }
    

//    for (id x in self.view.subviews){
//        NSLog(@"%@",NSStringFromClass([x class]));
//    }
}
-(void)swipe:(UISwipeGestureRecognizer*)recognizer
{
    if (recognizer.direction==UISwipeGestureRecognizerDirectionLeft) {
        if (self.isOpen1) {
             [self closeNavigationDrawer:self.drawerView1 :self.shawdowView1 :self.outFrame1];
            return;
        }
        [self drawerToggle:YES];
    }
    else  if (recognizer.direction==UISwipeGestureRecognizerDirectionRight) {
        if (self.isOpen2) {
            [self closeNavigationDrawer:self.drawerView2 :self.shawdowView2 :self.outFrame2];
            return;
        }
        [self drawerToggle:NO];
    }

}
- (void)drawerToggle:(BOOL)right
{
    self.drawerView=self.drawerView1;
    self.shawdowView=self.shawdowView1;
    self.inFrame=self.inFrame1;
    self.outFrame=self.outFrame1;
    if (right) {
        self.drawerView=self.drawerView2;
        self.shawdowView=self.shawdowView2;
        self.inFrame=self.inFrame2;
        self.outFrame=self.outFrame2;
    }
    if (right) {
        if (!self.isOpen2) {
            [self openNavigationDrawer:self.drawerView2 shadow:self.shawdowView2 frame:self.inFrame2];
            if (self.isOpen1) {
                  [self closeNavigationDrawer:self.drawerView1 :self.shawdowView1 :self.outFrame1];
            }
        }else{
           [self closeNavigationDrawer:self.drawerView2 :self.shawdowView2 :self.outFrame2];
        }
    }
    else
    {
        if (!self.isOpen1) {
            [self openNavigationDrawer:self.drawerView1 shadow:self.shawdowView1 frame:self.inFrame1];
             if (self.isOpen2) {
                  [self closeNavigationDrawer:self.drawerView2 :self.shawdowView2 :self.outFrame2];
             }
        }else{
            [self closeNavigationDrawer:self.drawerView1 :self.shawdowView1 :self.outFrame1];
        }
    }
    
}

#pragma open and close action

- (void)openNavigationDrawer:(UIView*)view shadow:(UIView*)shadowView frame:(CGRect)frame{
    if (view==self.drawerView1) {
        //[self.view addGestureRecognizer:self.pan_gr1];
         [self closeNavigationDrawer:self.drawerView2 :self.shawdowView2 :self.outFrame2];
    }
    else
    {
        //[self.view addGestureRecognizer:self.pan_gr2];
         [self closeNavigationDrawer:self.drawerView1 :self.shawdowView1 :self.outFrame1];
    }
//    NSLog(@"open x=%f",self.menuView.center.x);
    float duration = MENU_DURATION/self.menuWidth*abs(view.center.x)+MENU_DURATION/2; // y=mx+c
    duration=.3;
    // shawdow
     shadowView.hidden = NO;
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         shadowView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:SHAWDOW_ALPHA];
//                         if (self.shawdowView2==shadowView) {
//                             shadowView.backgroundColor = [UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:SHAWDOW_ALPHA];
//                         }
                     }
                     completion:nil];
    
    // drawer
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         view.frame = frame;
                     }
                     completion:nil];
    if (view==self.drawerView1) {
        self.isOpen1= YES;

    }
    if (view==self.drawerView2) {
        self.isOpen2= YES;
        
    }
}

- (void)closeNavigationDrawer:(UIView*)drawerView :(UIView*)shawdowView :(CGRect)outFrame{
//    NSLog(@"close x=%f",self.menuView.center.x);
    float duration = MENU_DURATION/self.menuWidth*abs(drawerView.center.x)+MENU_DURATION/2; // y=mx+c
     duration=.3;
    //[self.view removeGestureRecognizer:self.pan_gr1];
   // [self.view removeGestureRecognizer:self.pan_gr2];
    if (drawerView==self.drawerView1) {
       // [self.view addGestureRecognizer:self.pan_gr2];
        
    }
    else
    {
       // [self.view addGestureRecognizer:self.pan_gr1];
        
    }
   
    // shawdow
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         shawdowView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0f];
                     }
                     completion:^(BOOL finished){
                         shawdowView.hidden = YES;
                         
                     }];
    
    // drawer
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         drawerView.frame = outFrame;
                     }
                     completion:nil];
    if (drawerView==self.drawerView2) {
        self.isOpen2= NO;
    }
    else
    {
        self.isOpen1= NO;
    }
    
}

#pragma gestures

- (void)tapOnShawdow:(UITapGestureRecognizer *)recognizer {
    if (recognizer==self.tapGest1) {
        [self closeNavigationDrawer:self.drawerView1 :self.shawdowView1 :self.outFrame1];
    }
    else
    {
         [self closeNavigationDrawer:self.drawerView2 :self.shawdowView2 :self.outFrame2];
    }
    
}

-(void)moveDrawer:(UIPanGestureRecognizer *)recognizer
{
    CGPoint translation = [recognizer translationInView:self.view];
    CGPoint velocity = [(UIPanGestureRecognizer*)recognizer velocityInView:self.view];
//    NSLog(@"velocity x=%f",velocity.x);
    
    if([(UIPanGestureRecognizer*)recognizer state] == UIGestureRecognizerStateBegan) {
//        NSLog(@"start");
        if (recognizer==self.pan_gr1) {
                        if ( velocity.x > MENU_TRIGGER_VELOCITY && !self.isOpen1) {
                            [self openNavigationDrawer:self.drawerView1 shadow:self.shawdowView1 frame:self.inFrame1];

            }else if (velocity.x < -MENU_TRIGGER_VELOCITY && self.isOpen1) {
               [self closeNavigationDrawer:self.drawerView1 :self.shawdowView1 :self.outFrame1];
            }

        }
        if (recognizer==self.pan_gr2) {
            if ( velocity.x <- MENU_TRIGGER_VELOCITY && !self.isOpen2) {
                [self openNavigationDrawer:self.drawerView2 shadow:self.shawdowView2 frame:self.inFrame2];
                
            }else if (velocity.x > MENU_TRIGGER_VELOCITY && self.isOpen2) {
                [self closeNavigationDrawer:self.drawerView2 :self.shawdowView2 :self.outFrame2];
            }
            
        }
    }
    
    if([(UIPanGestureRecognizer*)recognizer state] == UIGestureRecognizerStateChanged) {
//        NSLog(@"changing");
        if (recognizer==self.pan_gr1) {
            float movingx = self.drawerView1.center.x + translation.x;
            if ( movingx > -self.menuWidth/2 && movingx < self.menuWidth/2){
                
                self.drawerView1.center = CGPointMake(movingx, self.drawerView1.center.y);
                [recognizer setTranslation:CGPointMake(0,0) inView:self.view];
                
                float changingAlpha = SHAWDOW_ALPHA/self.menuWidth*movingx+SHAWDOW_ALPHA/2; // y=mx+c
                self.shawdowView1.hidden = NO;
                self.shawdowView1.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:changingAlpha];
            }

        }
        if (recognizer==self.pan_gr2) {
            float movingx = self.drawerView2.center.x + translation.x;
            if ( movingx <320+self.menuWidth/2 && movingx > 320){
                
                self.drawerView2.center = CGPointMake(movingx, self.drawerView2.center.y);
                [recognizer setTranslation:CGPointMake(0,0) inView:self.view];
                
                float changingAlpha = SHAWDOW_ALPHA/self.menuWidth*movingx+SHAWDOW_ALPHA/2; // y=mx+c
                self.shawdowView2.hidden = NO;
                self.shawdowView2.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:changingAlpha];
            }
            
        }

    }
    
    if([(UIPanGestureRecognizer*)recognizer state] == UIGestureRecognizerStateEnded) {
//        NSLog(@"end");
        if (recognizer==self.pan_gr1) {
            if (self.drawerView1.center.x>0){
                 [self openNavigationDrawer:self.drawerView1 shadow:self.shawdowView1 frame:self.inFrame1];
            }else if (self.drawerView1.center.x<0){
                [self closeNavigationDrawer:self.drawerView1 :self.shawdowView1 :self.outFrame1];
            }
        }
        if (recognizer==self.pan_gr2) {
            if (self.drawerView2.center.x>320){
                [self openNavigationDrawer:self.drawerView2 shadow:self.shawdowView2 frame:self.inFrame2];
            }else if (self.drawerView2.center.x<320){
                [self closeNavigationDrawer:self.drawerView2 :self.shawdowView2 :self.outFrame2];
            }
        }

       
    }

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (self.drawerView1.drawerTableView==tableView) {
       return  leftItems.count;
    }
    return  rightItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
    {
        NSArray* array=[[NSBundle mainBundle]loadNibNamed:@"DrawerTableViewCell" owner:self options:nil];
        cell=[array objectAtIndex:0];
    }
    UIImageView* imageView=(UIImageView*)[cell viewWithTag:200];
    UILabel* label=(UILabel*)[cell viewWithTag:201];
    DrawerCellItem* item=nil;
    if (self.drawerView1.drawerTableView==tableView) {
        item=[leftItems objectAtIndex:indexPath.row];
    }    // Configure the cell...
    if (self.drawerView2.drawerTableView==tableView) {
        item=[rightItems objectAtIndex:indexPath.row];
    }
    imageView.image=[UIImage imageNamed:item.image];
    label.text=item.title;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.drawerView1.drawerTableView==tableView) {
        DrawerCellItem* item=[leftItems objectAtIndex:indexPath.row];
        self.navigationItem.title=item.title;
    }
    [self.CCKFNavDrawerDelegate CCKFNavDrawerSelection:[indexPath row] type:self.drawerView1.drawerTableView==tableView];
    if (tableView==self.drawerView1.drawerTableView) {
        [self closeNavigationDrawer:self.drawerView1 :self.shawdowView1 :self.outFrame1];
    }
    else
    {
        [self closeNavigationDrawer:self.drawerView2 :self.shawdowView2 :self.outFrame2];
    }
    
}

@end
