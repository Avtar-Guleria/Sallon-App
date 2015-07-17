//
//  UIViewController+UIControllers.m
//  Template
//
//  Created by XAV-MAC13 on 17/12/13.
//  Copyright (c) 2013 XAV-MAC13. All rights reserved.
//

#import "UIViewController+UIControllers.h"
#import <MobileCoreServices/MobileCoreServices.h>
@implementation UIViewController (UIControllers)
-(void)pickImage:(UIImagePickerControllerSourceType)sourceType
{
    UIImagePickerController* picker=[[UIImagePickerController alloc]init];
    picker.sourceType=sourceType;
    [self presentViewController:picker animated:YES completion:^{
        
    }];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
       [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    if (picker.mediaTypes.count>1) {
        UIImage* image=[info valueForKey:UIImagePickerControllerEditedImage];
        [self didPickImage:image];
    }
    else
    {
         NSString *moviePath = [(NSURL*)[info objectForKey:UIImagePickerControllerMediaURL] path];
        [self didPickVideo:moviePath];
        
    }
  

    
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    [self didCancel];
}
-(void)didPickImage:(UIImage*)image
{
    
}
-(void)didPickVideo:(NSString*)videoPath
{
    
}
-(void)didCancel
{
    
}

-(void)pickVideo:(UIImagePickerControllerSourceType)sourceType
{
    UIImagePickerController* picker=[[UIImagePickerController alloc]init];
    picker.sourceType=sourceType;
    picker.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie,      nil];
    [self presentViewController:picker animated:YES completion:^{
        
    }];
   
}
-(void)showAlert:(NSString*)message
{
    UIAlertView* alert=[[UIAlertView alloc]initWithTitle:Nil message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}
-(id)viewWithNib:(NSString*)nib owner:(id)owner
{
    NSArray* array=[[NSBundle mainBundle]loadNibNamed:nib owner:owner options:nil];
    return [array objectAtIndex:0];
}
@end
