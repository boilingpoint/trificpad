//
//  UITransportationController.m
//  enoa
//
//  Created by admin on 14-11-15.
//  Copyright (c) 2014年 etourer. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UITransportationController.h"
#import "ETColor.h"
#import "UINotificationController.h"
#import "ETRPLine.h"
#import "ETNRPLine.h"


#define TommrowDate [[NSDate alloc] initWithTimeIntervalSinceNow:24 *60 *60];

@interface UITransportationController ()

@property NSArray *rplineArray;
@property NSArray *nrplineArray;
@end


#define NAV_HEIGHT 60.0f
#define NAV_X 0
#define NAV_Y 20
#define NAV_BG @"#106bf8"

@implementation UITransportationController

- (void)viewDidLoad {
    [super viewDidLoad];
    cellCount = 20;
    [self initData];
    [self initCollectionView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    float ctrlViewHeight = 62.0f;
    float titleViewHeight = 55.0f;
    float listViewHeight = 544.0;
    float btnWidth = 87.0f;
    float btnHeight = 30.0f;
    float leftMargin = 64.0f;
    
    
    [self.tabNav setFrame:CGRectMake(NAV_X, NAV_Y, self.view.frame.size.width, NAV_HEIGHT)];
    [self.tabNav setBackgroundColor:[ETColor colorWithHexString:NAV_BG]];
    
    [self.controlView setFrame:CGRectMake(0, self.tabNav.frame.origin.y
                                        +self.tabNav.frame.size.height
                                        , self.view.frame.size.width, ctrlViewHeight)];
    [self.controlView setBackgroundColor:[ETColor colorWithHexString:@"#f6f6f6"]];
    [self.daySegment setFrame:CGRectMake(leftMargin, 32, btnWidth * 2, btnHeight)];
    [self.daySegment setTitle:@"Today" forSegmentAtIndex:0];
    [self.daySegment setTitle:@"Tomorrow" forSegmentAtIndex:1];

    [self.ownerSegment setFrame:CGRectMake(self.view.frame.size.width / 2 - btnWidth, 32, btnWidth * 2, btnHeight)];
    [self.ownerSegment setTitle:@"Me" forSegmentAtIndex:0];
    [self.ownerSegment setTitle:@"All" forSegmentAtIndex:1];
    [self.planSegment setFrame:CGRectMake(self.view.frame.size.width - leftMargin - btnWidth*2, 32, btnWidth * 2, btnHeight)];
    [self.planSegment setTitle:@"RP" forSegmentAtIndex:0];
    [self.planSegment setTitle:@"NRP" forSegmentAtIndex:1];
    
    [self.titleView setFrame:CGRectMake(0, self.tabNav.frame.origin.y
                                        +self.tabNav.frame.size.height + ctrlViewHeight
                                        , self.view.frame.size.width, titleViewHeight)];
    [self.titleView setBackgroundColor:[ETColor colorWithHexString:@"#f6f6f6"]];
    [self.lblTitle setFrame:CGRectMake(leftMargin, 28, 300, 24)];
    self.lblTitle.font = [self HELVETICANEUEBOLD_FONT:24];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    NSString *currentDate = [formatter stringFromDate:[NSDate date]];
    [self.lblTitle setText:[NSString stringWithFormat:@"All RP lines on %@", currentDate]];
    
    [self.collectionView setFrame:CGRectMake(leftMargin, self.tabNav.frame.origin.y +self.tabNav.frame.size.height + ctrlViewHeight + titleViewHeight
                                          , self.view.frame.size.width - leftMargin * 2, listViewHeight)];
    
    [self.daySegment addTarget:self action:@selector(controlPressed:) forControlEvents:UIControlEventValueChanged];
    
    //[self.daySegment setMomentary:YES];
    //[self.daySegment setSelectedSegmentIndex:1];
    [self.ownerSegment addTarget:self action:@selector(controlPressed:) forControlEvents:UIControlEventValueChanged];
    
    [self.planSegment addTarget:self action:@selector(controlPressed:) forControlEvents:UIControlEventValueChanged];
    
    //[self.collectionView setBackgroundColor:[UIColor blackColor]];
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

- (IBAction)controlPressed:(id)sender {
    UISegmentedControl *control = (UISegmentedControl *)sender;
    
    [self initData];
    [self initCollectionView];
    [self.collectionView reloadData];
    /*
    if(control == self.daySegment)
    {
        [self initCollectionView];
        [self.collectionView reloadData];
    }
    else if(control == self.ownerSegment)
    {
        [self initCollectionView];
        [self.collectionView reloadData];
    }
    else
    {
        [self initCollectionView];
        [self.collectionView reloadData];
    }
     */
}

-(void) initData
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    NSDate *date = nil;
    if(self.daySegment.selectedSegmentIndex == 0)
    {
        date = [NSDate date];
    }
    else
    {
        date = TommrowDate;
    }
    NSString *strDate = [formatter stringFromDate:date];
    
    ETRPLine *rpline = [ETRPLine alloc];
    [rpline init];
    
    ETNRPLine *nrpline = [ETNRPLine alloc];
    [nrpline init];
    
    if(self.ownerSegment.selectedSegmentIndex == 0 && self.planSegment.selectedSegmentIndex == 0)
    {
        self.rplineArray = [rpline getRPLinesByDate:strDate ByOwner:0];
        cellCount = self.rplineArray.count * 6;
    } else if(self.ownerSegment.selectedSegmentIndex == 1 && self.planSegment.selectedSegmentIndex == 0)
    {
        self.rplineArray = [rpline getRPLinesByDate:strDate ByOwner:1];
        cellCount = self.rplineArray.count * 6;
    } else if(self.ownerSegment.selectedSegmentIndex == 0 && self.planSegment.selectedSegmentIndex == 1)
    {
        self.nrplineArray = [nrpline getNRPLinesByDate:strDate ByOwner:0];
        cellCount = self.nrplineArray.count * 4;
    } else if(self.ownerSegment.selectedSegmentIndex == 1 && self.planSegment.selectedSegmentIndex == 1)
    {
        self.nrplineArray = [nrpline getNRPLinesByDate:strDate ByOwner:1];
        cellCount = self.nrplineArray.count * 5;
    }
    
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
    if(indexPath.row % 6 == 5 && self.planSegment.selectedSegmentIndex != 1)
    {
        [textView setTextColor:[ETColor colorWithHexString:@"#007aff"]];
    }
    [cell.contentView addSubview:textView];
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
    if(self.ownerSegment.selectedSegmentIndex == 0 && self.planSegment.selectedSegmentIndex == 0)
    {
        row = indexPara / 6;
        ETRPLine *line = (ETRPLine *)self.rplineArray[row];
        switch(indexPara % 6)
        {
            case 0:
                result = row == 0 ? @"Line": line.OptionName;
                break;
            case 1:
                result = row == 0 ? @"PAX":[NSString stringWithFormat:@"%d", line.Pax];
                break;
            case 2:
                result = row == 0 ? @"VH":line.Vh;
                break;
            case 3:
                result = row == 0 ? @"1st PU Time":line.FirstTime;
                break;
            case 4:
                result = row == 0 ? @"1st Pickup Location":line.FirstLocation;
                break;
            case 5:
                result = row == 0 ? @"":@"View Detail";
                break;
        }
    } else if(self.ownerSegment.selectedSegmentIndex == 1 && self.planSegment.selectedSegmentIndex == 0)
    {
        row = indexPara / 6;
        ETRPLine *line = (ETRPLine *)self.rplineArray[row];
        switch(indexPara % 6)
        {
            case 0:
                result = row == 0 ? @"Line":line.OptionName;
                break;
            case 1:
                result = row == 0 ? @"PAX":[NSString stringWithFormat:@"%d", line.Pax];
                break;
            case 2:
                result = row == 0 ? @"Driver":line.Driver;
                break;
            case 3:
                result = row == 0 ? @"VH":line.Vh;
                break;
            case 4:
                result = row == 0 ? @"1st PU Time":line.FirstTime;
                break;
            case 5:
                result = row == 0 ? @"":@"View Detail";
                break;
        }
    } else if(self.ownerSegment.selectedSegmentIndex == 0 && self.planSegment.selectedSegmentIndex == 1)
    {
        row = indexPara / 4;
        ETNRPLine *line = (ETNRPLine *)self.nrplineArray[row];
        switch(indexPara % 4)
        {
            case 0:
                result = row == 0 ? @"Line":line.OptionName;
                break;
            case 1:
                result = row == 0 ? @"VH":line.Vh;
                break;
            case 2:
                result = row == 0 ? @"Start Time":line.StartTime;
                break;
            case 3:
                result = row == 0 ? @"End Time":line.EndTime;
                break;
        }
    } else if(self.ownerSegment.selectedSegmentIndex == 1 && self.planSegment.selectedSegmentIndex == 1)
    {
        row = indexPara / 5;
        ETNRPLine *line = (ETNRPLine *)self.nrplineArray[row];
        switch(indexPara % 5)
        {
            case 0:
                result = row == 0 ? @"Line":line.OptionName;
                break;
            case 1:
                result = row == 0 ? @"Driver":line.Driver;
                break;
            case 2:
                result = row == 0 ? @"VH":line.Vh;
                break;
            case 3:
                result = row == 0 ? @"Start Time":line.StartTime;
                break;
            case 4:
                result = row == 0 ? @"End Time":line.EndTime;
                break;
        }
    }
    return result;
}

-(NSInteger) getCellWidth:(NSInteger) indexPara
{
    float line = 160.0f;
    float pax = 96.0f;
    float vh = 97.0f;
    float fpt = 160.0f;
    float fpl = 251.0f;
    float detail = 130.0f;
    
    if(self.ownerSegment.selectedSegmentIndex == 0 && self.planSegment.selectedSegmentIndex == 0)
    {
        switch(indexPara % 6)
        {
            case 0:
                currentWidth = line;
                break;
            case 1:
                currentWidth = pax;
                break;
            case 2:
                currentWidth = vh;
                break;
            case 3:
                currentWidth = fpt;
                break;
            case 4:
                currentWidth = fpl;
                break;
            case 5:
                currentWidth = detail;
                break;
        }
    } else if(self.ownerSegment.selectedSegmentIndex == 0 && self.planSegment.selectedSegmentIndex == 1)
    {
        switch(indexPara % 4)
        {
            case 0:
                currentWidth = 252;
                break;
            case 1:
                currentWidth = 190;
                break;
            case 2:
                currentWidth = 223;
                break;
            case 3:
                currentWidth = 223;
                break;
        }
    } else if(self.ownerSegment.selectedSegmentIndex == 1 && self.planSegment.selectedSegmentIndex == 0)
    {
        switch(indexPara % 6)
        {
            case 0:
                currentWidth = 192;
                break;
            case 1:
                currentWidth = 96;
                break;
            case 2:
                currentWidth = 223;
                break;
            case 3:
                currentWidth = 129;
                break;
            case 4:
                currentWidth = 107;
                break;
            case 5:
                currentWidth = 147;
                break;
        }
    } else if(self.ownerSegment.selectedSegmentIndex == 1 && self.planSegment.selectedSegmentIndex == 1)
    {
        switch(indexPara % 5)
        {
            case 0:
                currentWidth = 214;
                break;
            case 1:
                currentWidth = 244;
                break;
            case 2:
                currentWidth = 116;
                break;
            case 3:
                currentWidth = 150;
                break;
            case 4:
                currentWidth = 150;
                break;
        }
    }
    return currentWidth;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row % 6 == 5)
    {
        ETRPLine *line = (ETRPLine *)self.rplineArray[indexPath.row / 6];
        
        NSData *archiveData = [NSKeyedArchiver archivedDataWithRootObject:line];
        [self SetObject:archiveData ByKey:@"DetailLine"];
        
        [self gotoView:[self.storyboard instantiateViewControllerWithIdentifier:@"UITransportationDetail"]];
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