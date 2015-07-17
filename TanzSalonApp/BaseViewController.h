//
//  BaseViewController
//  OTS
//
//  Created by Avtar Singh on 3/21/13.
//  Copyright (c) 2013 Xavient Information System. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "Constants.h"
#import "NSString+Util.h"
#import "DatePickerViewFactory.h"

@protocol CustomAlertViewDelegate <NSObject>

@optional

-(void)alertViewLeftButtonClicked;
-(void)alertViewRightButtonClicked;
@end




@interface BaseViewController : UIViewController<UIActionSheetDelegate,MFMailComposeViewControllerDelegate,UIAlertViewDelegate,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    IBOutlet UIView *loadingViewBackground;
    IBOutlet UIActivityIndicatorView* loadingViewActivityIndicator;

    //city picker
    DatePickerViewFactory * cityPickerFactory;
    NSMutableArray *cities;
    
    
     NSMutableArray *events;
    

}

@property (nonatomic,strong)NSMutableArray *events;
@property(nonatomic,strong)id<CustomAlertViewDelegate> alertDelegate;

@property(nonatomic,strong)UIImageView *imageView;

//Controller specific methods.
-(void)initUIComponents;
-(BOOL)isValidForm;

//Class Level Methods
-(void) showLoadingView;
-(void) hideLoadingView;
-(void)setButtonTitle:(NSString*)title forButton:(UIButton*)button;
- (void)setButtonShadow:(UIButton*)button;
-(void)setButtonBackgroundImage:(NSString*)imageName forButton:(UIButton*)button;
-(void)setRoundedBorder:(UIView*)view;
- (UIActionSheet*)showViewInActionSheet:(UIView*)view withActionSheetTitle:(NSString*)title;
-(void)showAlertViewWithTitle:(NSString*) msg leftButtonTitle:(NSString*)leftTitle rightTitle:(NSString*)rightButtonTitle;
-(void)showAlert:(NSString*)message;
-(void)showAlertWithTitle:(NSString*)title message:(NSString*)message;
-(void)showAlertViewWithTitle:(NSString*) title message:(NSString*)message leftButtonTitle:(NSString*)leftTitle rightTitle:(NSString*)rightButtonTitle;
-(void) openBrowser:(NSString*)url;

-(void)sendMailWithEmailId:(NSString *)emailId messageBody:(NSString*)body subject:(NSString*)subject;
-(void)mailSentSuccessfully;


//Navigation Bar Methods
-(void)pushViewController:(UIViewController*)viewController withNib:(NSString*)nibName;
-(NSString*)getNibNameForNib:(NSString *)nibName;
-(IBAction)rightButtonClicked:(id)sender;
-(IBAction)leftButtonClicked:(id)sender;
-(BOOL)isIphone5Retina4InchDisplay;
-(BOOL)popToViewControllerWithNibName:(NSString*)nibName;


//Utility Methods
-(void)showMessageComposer:(NSString*)message;
- (void)shareText:(NSString *)string andImage:(UIImage *)image;
-(void)shareOnFaceBookWithText:(NSString*)text url:(NSString*)url image:(UIImage*)image;
- (void)shareOnTwitter:(NSString*)text;

-(void)getImageFromImagePicker:(UIImageView*)imageview isCamera:(BOOL)isCamera;

-(UIImage *) getScreenshot;

-(NSMutableDictionary *)getDictonaryFromString:(NSData*) data;
@end
