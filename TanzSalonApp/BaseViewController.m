//
//  BaseViewController
//  OTS
//
//  Created by Avtar Singh on 3/21/13.
//  Copyright (c) 2013 Xavient Information System. All rights reserved.
//

#import "BaseViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UserDefaultsUtil.h"
#import "UserDefaultsUtil.h"
#import "KeyChainUtil.h"
#import "JsonUtil.h"
#import "SBJSON.h"
#import <Social/Social.h>





@implementation BaseViewController

@synthesize alertDelegate,events;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor=[UIColor blackColor];
    self.automaticallyAdjustsScrollViewInsets=false;
    
    

       
}

- (void)viewDidUnload
{
    alertDelegate=nil;
    [super viewDidUnload];
}

-(void)viewWillAppear:(BOOL)animated {   
    [super viewWillAppear:animated];
     self.navigationController.navigationBar.hidden=NO;
     [self initUIComponents];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
//    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);    

    return NO;
}


-(void) showLoadingView
{
    [self.view setUserInteractionEnabled:NO];
    [self.view addSubview:loadingViewBackground];
    loadingViewBackground.hidden=NO;
    loadingViewActivityIndicator.hidden=NO;
    [loadingViewActivityIndicator startAnimating];
}


-(void) hideLoadingView
{
    loadingViewBackground.hidden=YES;
    loadingViewActivityIndicator.hidden=YES;
    [loadingViewActivityIndicator stopAnimating];
    [self.view setUserInteractionEnabled:YES];
}




#pragma mark - Action Sheet Delegate Methods

-(void) openBrowser:(NSString*)url
{
    NSURL *appStoreUrl = [NSURL URLWithString:url];
    [[UIApplication sharedApplication] openURL:appStoreUrl];
}

/*
 * @description: Method is used to push a view controller with animation
 * @parameters: 
 * viewController: Object of ViewController that need to be pushed.
 * nibName: Name of the nib file of the ViewController
 */
-(void)pushViewController:(UIViewController*)viewController withNib:(NSString*)nibName
{
    
    
    if(nibName){
        
        nibName=[self getNibNameForNib:nibName];
        
        viewController=[viewController initWithNibName:nibName bundle:nil];
        [self setTitle:@"Back"];
        
        [self.navigationController pushViewController:viewController animated:YES];
    
//        [self pushViewControllerWithCustomAnimation:viewController withTranisitonAnimation:UIViewAnimationTransitionCurlUp];
    }
 
    
}





-(void)pushViewControllerWithCustomAnimation:(UIViewController*)controller withTranisitonAnimation:(UIViewAnimationTransition)animation
{
    if(animation){
        
        [UIView  beginAnimations: @"CustomAnimation"context: nil];
        [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.75];
        [self.navigationController pushViewController: controller animated:NO];
        [UIView setAnimationTransition:animation forView:self.navigationController.view cache:NO];
        [UIView commitAnimations];
    
    }else{
        //push view with default animation.
        [self.navigationController pushViewController: controller animated:YES];
    }
}

-(NSString*)getNibNameForNib:(NSString *)nibName
{
    NSString *newNibName=nil;
    
    if([self isIphone5Retina4InchDisplay]){
        newNibName=[nibName stringByAppendingString:@"-568h"];
    }
    
    if(newNibName && [[NSBundle mainBundle] pathForResource:newNibName ofType:@"nib"] != nil)
    {
        //if iphone 5 and nib is also present for that resolution.
        nibName=newNibName;
    }
   
    return nibName;
}

/**
 Method to get if device is 4 inch iphone 5 retina device or not.
 */
-(BOOL)isIphone5Retina4InchDisplay
{   
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 568) {
        // code for 4-inch screen
        return YES;
    } else {
        // code for 3.5-inch screen
        return NO;
    }
}



-(BOOL)popToViewControllerWithNibName:(NSString*)nibName
{
    
    @try {
        if(nibName){
            
            nibName=[self getNibNameForNib:nibName];
            
            for(UIViewController* viewController in self.navigationController.viewControllers) {
                
                if ([viewController.nibName isEqualToString:nibName]) {
                    
                    [self.navigationController popToViewController:viewController animated:YES];
                    
                    return YES;
                }
                
            }
        }

    }
    @catch (NSException *exception) {
        NSLog(@"Exception occurred:%@",exception.description);
    }
   
    
       return NO;
}


-(void)setButtonTitle:(NSString*)title forButton:(UIButton*)button
{
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateSelected];
    [button setTitle:title forState:UIControlStateHighlighted];
    
}


- (void)setButtonShadow:(UIButton*)button
{
    [button.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [button.layer setShadowOffset:CGSizeMake(0, 3)];
    [button.layer setShadowOpacity:0.125];
    [button.layer setCornerRadius:3];
}


-(void)setButtonBackgroundImage:(NSString*)imageName forButton:(UIButton*)button
{
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateSelected];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
    
}


-(void)setRoundedBorder:(UIView*)view
{
    view.layer.cornerRadius=10;
    view.layer.masksToBounds=YES;
}


- (UIActionSheet*)showViewInActionSheet:(UIView*)view withActionSheetTitle:(NSString*)title
{
    UIActionSheet *actionSheet=[[UIActionSheet alloc]init];
    [actionSheet setTitle:title];
    [actionSheet setDelegate:self];
    
    [actionSheet addSubview:view];
    [actionSheet showInView:self.view];
    
    
    CGRect actionSheetRect = actionSheet.frame;
    CGFloat orgHeight = actionSheetRect.size.height;

    actionSheetRect.origin.y -= view.frame.size.height; //height of view added
    actionSheetRect.size.height = orgHeight+view.frame.size.height;
    actionSheet.frame = actionSheetRect;
    
    CGRect pickerRect = view.frame;
    pickerRect.origin.y = orgHeight;
    view.frame = pickerRect;
    
    return actionSheet;
}


-(void)showAlert:(NSString*)message
{
    if(message){
        
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        
        [alertView show];
        
    }
    
}

-(void)showAlertWithTitle:(NSString*)title message:(NSString*)message
{
    if(message){
        
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        
        [alertView show];
        
    }
    
}



-(void)showAlertViewWithTitle:(NSString*) msg leftButtonTitle:(NSString*)leftTitle rightTitle:(NSString*)rightButtonTitle
{
    if(msg){
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:leftTitle otherButtonTitles:rightButtonTitle,nil];

        alertView.tag=1987;
        
        [alertView show];
        
    }
}

-(void)showAlertViewWithTitle:(NSString*) title message:(NSString*)message leftButtonTitle:(NSString*)leftTitle rightTitle:(NSString*)rightButtonTitle
{
    
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:leftTitle otherButtonTitles:rightButtonTitle,nil];
        alertView.tag=1987;
        [alertView show];
        
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==1987){
        
        if(buttonIndex==alertView.cancelButtonIndex){
            [self.alertDelegate alertViewLeftButtonClicked];
        }else{
            [self.alertDelegate alertViewRightButtonClicked];
        }
    }
}

-(void)alertViewLeftButtonClicked
{
   //empty implementaion.
}
-(void)alertViewRightButtonClicked
{
    //empty implementaion.
}


#pragma mark- Navigation Bar button.


/**
 
 *Method to add custom filter button on navigation bar.
 
 */
-(UIButton*)setLeftHeaderButton:(NSString*)imageName withTitle:(NSString*)title
{
    UIImage* image = [UIImage imageNamed:imageName];
    
    CGRect frameimg = CGRectMake(0, 0, image.size.width, image.size.height);
    
    UIButton *button = [[UIButton alloc] initWithFrame:frameimg];
    
    [button setBackgroundImage:image forState:UIControlStateNormal];
    
    //set button font size and style.
    button.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
    button.titleLabel.textAlignment = UITextAlignmentCenter;
    button.titleLabel.font=[UIFont boldSystemFontOfSize:14.0];
    [button setTitle:title forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(leftButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [button setShowsTouchWhenHighlighted:YES];
    
    
    UIBarButtonItem *leftBarButton =[[UIBarButtonItem alloc] initWithCustomView:button ];
    
    self.navigationItem.leftBarButtonItem=leftBarButton;
    return button;
}


/*
 *Method to handle right bar Button clicked
 Overide this method to handle click on right button on navigation bar.
 */
-(IBAction)rightButtonClicked:(id)sender
{
    //empty body to over-ride.
}


/**
 Method to be overided to handle button click on left bar button on navigation bar.
 */
-(IBAction)leftButtonClicked:(id)sender
{
    //over-ride this method to handle click. 
}



- (IBAction)backButtonClicked:(id)sender {
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma mark- Utility Methods
#pragma Send Mail.
-(void)sendMailWithEmailId:(NSString *)emailId messageBody:(NSString*)body subject:(NSString*)subject{
    if(emailId && (NSNull*)emailId!=[NSNull null]){
        
        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
        picker.mailComposeDelegate = self;
        
        [picker setSubject:subject];
        
        
        picker.navigationBar.tintColor = [UIColor colorWithRed:84.0/255.0 green:5.0/255.0 blue:144.0/255.0 alpha:1.0];
        
        // Set up recipients
        NSArray *toRecipients = [NSArray arrayWithObject:emailId];
        
        [picker setToRecipients:toRecipients];
        
        [picker setMessageBody:body isHTML:NO];
        
        if([MFMailComposeViewController canSendMail]){
            [self.navigationController presentViewController:picker animated:YES completion:nil];
        }
        
    }
    else
    {
        [self showAlert:@"Email id is not available."];
    }
    
}


-(void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail send canceled.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved.");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent.");
            
            [self mailSentSuccessfully];
            
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail send error: %@.", [error localizedDescription]);
            break;
        default:
            break;
    }
    [controller dismissViewControllerAnimated:YES completion:nil];
}


/**
 Override method to use after mail is send successfully
 */

-(void)mailSentSuccessfully
{
    
}



-(void)showMessageComposer:(NSString*)message{
    MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];

    if(picker && [MFMessageComposeViewController canSendText]){
        //    picker.messageComposeDelegate = self;
        //    picker.recipients = [NSArray arrayWithObjects:@"1234", @"2345", nil];
        
        if(message){
            picker.body = message;
        }
        
        [self presentViewController:picker animated:YES completion:nil];
  
    }
    
    
   }

- (void)shareText:(NSString *)string andImage:(UIImage *)image
{
    NSMutableArray *sharingItems = [NSMutableArray new];
    
    if (string) {
        [sharingItems addObject:string];
    }
    if (image) {
        [sharingItems addObject:image];
    }
    
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:sharingItems applicationActivities:nil];
    [self presentViewController:activityController animated:YES completion:nil];
}


#pragma mark- Controller specific. 




-(BOOL)isValidForm
{
    //override this method
    return YES;
}



-(void)initUIComponents
{
    //override this method to provide your custom implementation of UI components
}






#pragma mark- Table View Delegates
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    // Add your Colour.
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor blueColor]];  //highlight colour
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    // Reset Colour.
    UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor colorWithRed:100/255.0 green:78/255.0 blue:155/255.0 alpha:1]]; //normal color
    
}

- (void)setCellColor:(UIColor *)color ForCell:(UITableViewCell *)cell {
    cell.contentView.backgroundColor = color;
    cell.backgroundColor = color;
}


-(void)getImageFromImagePicker:(UIImageView*)imageview isCamera:(BOOL)isCamera{
    self.imageView=imageview;
    
    if(isCamera){
        [self selectPhotosFromCamera];
    }else{
        [self selectPhotosFromGallery];
    }
}
- (void)selectPhotosFromCamera
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}


- (void)selectPhotosFromGallery
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo
{
    self.imageView.image = image;
    [[picker parentViewController] dismissModalViewControllerAnimated:YES];
}
-(NSMutableDictionary *)getDictonaryFromString:(NSData*) data{
    SBJSON * jsonParser = [[SBJSON alloc] init];
    NSString* jsonString=[[NSString alloc]initWithData:data encoding:NSASCIIStringEncoding];
    jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSMutableDictionary *jsonObject = [jsonParser objectWithString:jsonString];
    
    return jsonObject;
}


-(void)shareOnFaceBookWithText:(NSString*)text url:(NSString*)url image:(UIImage*)image{
//    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
    
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [controller setInitialText:text];
        [controller addURL:[NSURL URLWithString:url]];
        [controller addImage:image];
        
        [self presentViewController:controller animated:YES completion:Nil];
        
//    }else{
//        [self showAlert:@"Facebook service is not available."];
//    }
}
- (void)shareOnTwitter:(NSString*)text {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:text];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }else{
                [self showAlert:@"Twitter service is not available."];
    }
}


-(UIImage *) getScreenshot
{
//    CGImageRef UIGetScreenImage(void);
//    CGImageRef screen = UIGetScreenImage();
//    UIImage* screenImage = [UIImage imageWithCGImage:screen];
//    CGImageRelease(screen); // you need to call this.
//    return screenImage;
    
    
    
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, self.view.opaque, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *imageView = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *imageData = UIImageJPEGRepresentation(imageView, 1.0 ); //you can use PNG too
//    [imageData writeToFile:@"image1.jpeg" atomically:YES];
    UIImage *image = [UIImage imageWithData:imageData];
    return image;
    
}
@end
