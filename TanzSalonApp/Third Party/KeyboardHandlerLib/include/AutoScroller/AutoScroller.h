
//  Created by Sukhpal on 9/9/12.
//  Copyright (c) Sukhpal. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface AutoScroller : NSObject<UITextFieldDelegate,UITextViewDelegate>
{
    NSMutableArray* textFields;
    CGPoint scrollPoint;
    CGPoint initialScrollPoint;
    int topPadding;
    UIInterfaceOrientation currentOrientation;
    
    
}
@property (retain, nonatomic) IBOutlet UIToolbar *doneToolBar;
@property (unsafe_unretained, nonatomic) id<UITextFieldDelegate> delegate;
@property (unsafe_unretained, nonatomic) id<UITextViewDelegate>  textViewsDelegate;
@property (unsafe_unretained, nonatomic)UIScrollView* scrollView;
@property(nonatomic,readwrite)int topPadding;


-(void) setToolbarStyle:(UIBarStyle)barStyle;
-(void) setTabBarApplication:(BOOL)isTabbarApplication;

+(AutoScroller*) addAutoScrollTo:(UIScrollView*)scroll;
+(AutoScroller*) addAutoScrollTo:(UIScrollView*)scroll :(BOOL)showDoneButtonToolbar :(id<UITextFieldDelegate>)textFieldsDelegate;
+(AutoScroller*) addAutoScrollTo:(UIScrollView*)scroll :(BOOL)showDoneButtonToolbar :(id<UITextFieldDelegate>)textFieldsDelegate :(id<UITextViewDelegate>)textViewsDelegate;
+(AutoScroller*) addAutoScrollTo:(UIScrollView*)scroll :(BOOL)showDoneButtonToolbar;
-(void)pause;
-(void)resume;
- (IBAction)doneClicked:(id)sender;

@end
