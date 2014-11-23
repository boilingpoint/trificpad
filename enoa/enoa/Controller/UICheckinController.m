//
//  UICheckinController.m
//  enoa
//
//  Created by admin on 14-11-15.
//  Copyright (c) 2014年 etourer. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UICheckinController.h"
#import "ETColor.h"
#import "UINotificationController.h"


#define HELVETICANEUE_FONT(s) [UIFont fontWithName:@"HelveticaNeue" size:s]
#define HELVETICANEUEMEDIUM_FONT(s) [UIFont fontWithName:@"HelveticaNeue-Bold" size:s]
#define HELVETICANEUEBOLD_FONT(s) [UIFont fontWithName:@"HelveticaNeue-Medium" size:s]

@interface UICheckinController ()

@end


#define NAV_HEIGHT 60.0f
#define NAV_X 0
#define NAV_Y 20
#define NAV_BG @"#106bf8"

@implementation UICheckinController

- (void)viewDidLoad {
    [super viewDidLoad];
    cellCount = 20;
    [self initCollectionView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    float ctrlViewHeight = 154.0f;
    float listViewHeight = 544.0;
    float btnWidth = 87.0f;
    float btnHeight = 30.0f;
    float btnLeftMargin = 766.0f;
    float leftMargin = 64.0f;
    
    [self.tabNav setFrame:CGRectMake(NAV_X, NAV_Y, self.view.frame.size.width, NAV_HEIGHT)];
    [self.tabNav setBackgroundColor:[ETColor colorWithHexString:NAV_BG]];
    
    [self.controlView setFrame:CGRectMake(0, self.tabNav.frame.origin.y
                                          +self.tabNav.frame.size.height
                                          , self.view.frame.size.width, ctrlViewHeight)];
    self.timeLabel.font = HELVETICANEUEBOLD_FONT(24);
    self.alertLabel.font = HELVETICANEUEBOLD_FONT(24);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    NSString *currentDate = [formatter stringFromDate:[NSDate date]];
    [self.timeLabel setText:[NSString stringWithFormat:@"Today, %@,", currentDate]];
    [self.timeLabel setFrame:CGRectMake(leftMargin, 32, 502, 34)];
    
    [self.alertLabel setText:@"These activities are waiting for check in"];
    [self.alertLabel setFrame:CGRectMake(leftMargin, 64, 502, 34)];
    
    [self.controlView setBackgroundColor:[ETColor colorWithHexString:@"#f6f6f6"]];
    [self.daySegment setFrame:CGRectMake(btnLeftMargin, 32, btnWidth * 2, btnHeight)];
    [self.daySegment setTitle:@"Today" forSegmentAtIndex:0];
    [self.daySegment setTitle:@"Tomorrow" forSegmentAtIndex:1];
    [self.daySegment addTarget:self action:@selector(controlPressed:) forControlEvents:UIControlEventValueChanged];
    
    
    [self.collectionView setFrame:CGRectMake(leftMargin, self.tabNav.frame.origin.y +self.tabNav.frame.size.height + ctrlViewHeight
                                             , self.view.frame.size.width - leftMargin * 2, listViewHeight)];
}

- (IBAction)controlPressed:(id)sender {
    UISegmentedControl *control = (UISegmentedControl *)sender;
    
    if(control == self.daySegment)
    {
        [self initCollectionView];
        [self.collectionView reloadData];
    }
}

- (IBAction)toolBarItemTap:(id)sender {
    
    NSInteger tag = [sender tag];
    //UINotificationController *notifiController = nil;
    //notifiController = [[UINotificationController alloc] initWithStyle:UITableViewStylePlain];
    [super toolbarChange:tag BackTo:@""];
    /*
    NSInteger tag = [sender tag];
    switch(tag)
    {
        case 1:
            [self gotoView:[self.storyboard instantiateViewControllerWithIdentifier:@"UITransportation"]];
            break;
        case 2:
            [self gotoView:[self.storyboard instantiateViewControllerWithIdentifier:@"UICheckin"]];
            break;
        case 3:
            break;
        case 4:
            //UINotificationController *notifiController = [[UINotificationController alloc] initWithStyle:UITableViewStylePlain];
            //UINotificationController *tableViewController = [[UINotificationController alloc] initWithStyle:UITableViewStylePlain];
            
            //[self gotoView: notifiController];
            break;
        case 5:
            break;
        default:
            [self gotoView:[self.storyboard instantiateViewControllerWithIdentifier:@"UIHome"]];
            break;
    }
     */
}


-(void)initCollectionView {
    //UICollectionViewLayout *layout = [[UICollectionViewLayout alloc] init];
    //self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(64, self.tabNav.frame.origin.y +self.tabNav.frame.size.height + 117.0f, self.view.frame.size.width - 64 * 2, 70.0f) collectionViewLayout:layout];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    self.collectionView.backgroundColor = [ETColor colorWithHexString:@"#f6f6f6"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    //[self.view addSubview:self.collectionView];
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return cellCount;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    for (UIView*view in cell.contentView.subviews) {
        if (view) {
            [view removeFromSuperview];
        }
    }//self.view.frame.origin.y * indexPath.row
    UILabel *textView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [self getCellWidth:indexPath.row], height)];
    textView.text = [self getCellText:indexPath.row];
    //textView.break = YES;
    if(indexPath.row % 4 == 3)
    {
        [textView setTextColor:[ETColor colorWithHexString:@"#007aff"]];

    }
    [cell.contentView addSubview:textView];
    //index++;
    //if(index == cellCount) {
    //    index = 0;
    //}
    return  cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    height = 56.0f;
    float width = [self getCellWidth:indexPath.row];
    //index++;
    //if(index == cellCount) {
    //    index = 0;
    //}
    return CGSizeMake(width, height);
}

-(NSString *) getCellText:(NSInteger) indexPara
{
    NSInteger row = 0;
    NSString *result = @"";
    
    row = indexPara / 4;
    switch(indexPara % 4)
    {
         case 0:
             result = row == 0 ? @"Activity":[NSString stringWithFormat:@"text %d", (int)indexPara];
             break;
         case 1:
             result = row == 0 ? @"Time":[NSString stringWithFormat:@"text %d", (int)indexPara];
             break;
         case 2:
             result = row == 0 ? @"Pax":[NSString stringWithFormat:@"%d", (int)indexPara];
             break;
         case 3:
             result = row == 0 ? @"":@"Start Checck In";
             break;
     }
     return result;
}

-(NSInteger) getCellWidth:(NSInteger) indexPara
{
    float time = 193.0f;
    float pax = 40.0f;
    float leftMargin = 64.0f;
    float btn = 237.0f;
    float activity = self.view.frame.size.width - leftMargin * 2 - pax - btn - time;
    
    switch(indexPara % 4)
        {
            case 0:
                currentWidth = activity;
                break;
            case 1:
                currentWidth = time;
                break;
            case 2:
                currentWidth = pax;
                break;
            case 3:
                currentWidth = btn;
                break;
        }
    
    return currentWidth;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row % 4 == 3)
    {
        [self gotoView:[self.storyboard instantiateViewControllerWithIdentifier:@"UICheckinDetail"]];
    }
}


-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    //
}
-(void)gotoView:(UIViewController *)goController
{
    int flag = 0;
    
    for(UIViewController *controller in self.navigationController.viewControllers)
    {
        if([controller isKindOfClass:[goController class]])
        {
            flag = 1;
            [self.navigationController popToViewController:controller animated:YES];
            break;
        }
    }
    if(flag == 0)
    {
        [self.navigationController pushViewController:goController animated:YES];
    }
}

-(UIEdgeInsets) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //UIEdgeInsets top = {0, 0, 0, 0};
    return UIEdgeInsetsMake(0,0,0,0);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


@end