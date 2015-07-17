//
//  UIViewController+UIControllers.h
//  Template
//
//  Created by XAV-MAC13 on 17/12/13.
//  Copyright (c) 2013 XAV-MAC13. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
@interface UIViewController (UIControllers)<UIImagePickerControllerDelegate>
-(void)pickImage:(UIImagePickerControllerSourceType)sourceType;
-(void)pickVideo:(UIImagePickerControllerSourceType)sourceType;
-(void)didPickImage:(UIImage*)image;
-(void)didPickVideo:(NSString*)videoPath;
-(void)didCancel;
-(void)showAlert:(NSString*)message;
-(id)viewWithNib:(NSString*)nib owner:(id)owner;

@end
