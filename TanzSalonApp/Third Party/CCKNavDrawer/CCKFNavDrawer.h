//
//  CCKFNavDrawer.h
//  CCKFNavDrawer
//
//  Created by calvin on 23/1/14.
//  Copyright (c) 2014年 com.calvin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawerView.h"
#import "DrawerCellItem.h"
@protocol CCKFNavDrawerDelegate <NSObject>
@required
- (void)CCKFNavDrawerSelection:(NSInteger)selectionIndex type:(BOOL)left;
@end

@interface CCKFNavDrawer : UINavigationController<UIGestureRecognizerDelegate, UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray* rightItems;
    NSMutableArray* leftItems;
}
@property (nonatomic, strong) UIPanGestureRecognizer *pan_gr;
@property (nonatomic, strong) UIPanGestureRecognizer *pan_gr1;
@property (nonatomic, strong) UIPanGestureRecognizer *pan_gr2;
@property (nonatomic, strong) UITapGestureRecognizer*tapGest;
@property (nonatomic, strong) UITapGestureRecognizer*tapGest1;
@property (nonatomic, strong) UITapGestureRecognizer*tapGest2;

@property (nonatomic) BOOL isOpen;
@property (nonatomic) float meunHeight;
@property (nonatomic) float menuWidth;
@property (nonatomic) CGRect outFrame;
@property (nonatomic) CGRect inFrame;
@property (strong, nonatomic) UIView *shawdowView;
@property (strong, nonatomic) DrawerView *drawerView;

@property (strong, nonatomic) UIView *shawdowView2;
@property (strong, nonatomic) DrawerView *drawerView2;
@property (nonatomic) CGRect outFrame2;
@property (nonatomic) CGRect inFrame2;
@property (nonatomic) BOOL isOpen2;

@property (strong, nonatomic) UIView *shawdowView1;
@property (strong, nonatomic) DrawerView *drawerView1;
@property (nonatomic) CGRect outFrame1;
@property (nonatomic) CGRect inFrame1;
@property (nonatomic) BOOL isOpen1;
@property (weak, nonatomic)id<CCKFNavDrawerDelegate> CCKFNavDrawerDelegate;

- (void)drawerToggle:(BOOL)right;

@end
