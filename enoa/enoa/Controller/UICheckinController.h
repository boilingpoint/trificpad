//
//  UICheckinController.h
//  enoa
//
//  Created by admin on 14-11-15.
//  Copyright (c) 2014年 etourer. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "UIBaseController.h"
//#import "ETButton.h"

@interface UICheckinController : UIBaseController<UICollectionViewDelegate, UICollectionViewDataSource>
{
    float currentWidth;
    float cellCount;
    float height;
}
@property (strong, nonatomic) IBOutlet UIToolbar *tabNav;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *alertLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *daySegment;
@property (weak, nonatomic) IBOutlet UIView *controlView;


- (IBAction)toolBarItemTap:(id)sender;

@end