//
//  UITransportationController.h
//  enoa
//
//  Created by admin on 14-11-15.
//  Copyright (c) 2014年 etourer. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "UIBaseController.h"
//#import "ETButton.h"

@interface UITransportationController : UIBaseController<UICollectionViewDelegate, UICollectionViewDataSource>
{
    int index;
    float currentWidth;
    float height;
    float cellCount;
}
@property (strong, nonatomic) IBOutlet UIToolbar *tabNav;
@property (strong, nonatomic) IBOutlet UIView *controlView;
@property (strong, nonatomic) IBOutlet UIView *titleView;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) IBOutlet UISegmentedControl *daySegment;
@property (strong, nonatomic) IBOutlet UISegmentedControl *ownerSegment;
@property (strong, nonatomic) IBOutlet UISegmentedControl *planSegment;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;

- (IBAction)toolBarItemTap:(id)sender;
- (IBAction)controlPressed:(id)sender;


@end