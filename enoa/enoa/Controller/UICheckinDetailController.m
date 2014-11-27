//
//  UICheckinDetailController.m
//  enoa
//
//  Created by admin on 14-11-20.
//  Copyright (c) 2014年 etourer. All rights reserved.
//



#import "UICheckinDetailController.h"
#import "ETColor.h"
#import "UINotificationController.h"

#import "AdditionalInfoCell.h"
#import "OrderInfoCell.h"
#import "Model.h"
//#import "AdditionalDetailView.h"


@interface UICheckinDetailController ()

@end

#define NAV_HEIGHT 60.0f
#define NAV_X 0
#define NAV_Y 20
#define NAV_BG @"#106bf8"

@implementation UICheckinDetailController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    
    //test
    _array = [[NSMutableArray alloc] initWithCapacity:0];
    for(int i=0;i<3;i++)
    {
        NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:0];
        for(int j=0;j<2;j++)
        {
            Model *model = [[Model alloc] init];
            model.str1 = [NSString stringWithFormat:@"张三%d", i];
            model.str2 = [NSString stringWithFormat:@"aaaa%d", j];
            model.isExpand = NO;
            [arr addObject:model];
        }
        [_array addObject:arr];
    }
    
    _CurrentArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    for(int i=0;i<_array.count;i++)
    {
        [_CurrentArray addObject:@[]];
    }
    
    //self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 30, 300, 500) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)initTableView {
    //UICollectionViewLayout *layout = [[UICollectionViewLayout alloc] init];
    //self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(64, self.tabNav.frame.origin.y +self.tabNav.frame.size.height + 117.0f, self.view.frame.size.width - 64 * 2, 70.0f) collectionViewLayout:layout];
    //[self.tableView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    self.tableView.backgroundColor = [ETColor colorWithHexString:@"#f6f6f6"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //[self.view addSubview:self.collectionView];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    float ctrlViewHeight = 94.0f;
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
    
    self.lblInfo.font = [self HELVETICANEUEBOLD_FONT:24];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    NSString *currentDate = [formatter stringFromDate:[NSDate date]];
    [self.lblInfo setText:[NSString stringWithFormat:@"Current Activity: %@   %@   Waiting: %@", @"1C", currentDate, @"#"]];
    [self.lblInfo setFrame:CGRectMake(leftMargin, 12, 602, 74)];
    self.lblInfo.lineBreakMode = UILineBreakModeWordWrap;
    self.lblInfo.numberOfLines = 3;
    
    self.lblInventory.font = [self HELVETICANEUE_FONT:18];
    [self.lblInventory setText:[NSString stringWithFormat:@"Inventory Availability: %d  of %d ", 5, 200]];
    [self.lblInventory setFrame:CGRectMake(leftMargin, 42, 602, 74)];
    
    [self.controlView setBackgroundColor:[ETColor colorWithHexString:@"#f6f6f6"]];
    //[self.typeSegment setFrame:CGRectMake(btnLeftMargin, 32, btnWidth * 2, btnHeight)];
    //[self.typeSegment setTitle:@"List" forSegmentAtIndex:0];
    //[self.typeSegment setTitle:@"Map" forSegmentAtIndex:1];
    //[self.typeSegment addTarget:self action:@selector(controlPressed:) forControlEvents:UIControlEventValueChanged];
    
    
    
    [self.tableView setFrame:CGRectMake(leftMargin, self.tabNav.frame.origin.y +self.tabNav.frame.size.height + ctrlViewHeight , self.view.frame.size.width - leftMargin * 2, listViewHeight)];
    [self.tableView setBackgroundColor:[ETColor colorWithHexString:@"#f6f6f6"]];
    
}
/*
- (IBAction)controlPressed:(id)sender {
    UISegmentedControl *control = (UISegmentedControl *)sender;
    
    if(control.selectedSegmentIndex == 0)
    {
        [self.mapView setHidden:YES];
        [self.tableView setHidden:NO];
        [self.tableView reloadData];
    } else
    {
        [self.mapView setHidden:NO];
        [self.tableView setHidden:YES];
    }
}
*/
- (IBAction)toolBarItemTap:(id)sender {
    
    NSInteger tag = [sender tag];
    //UINotificationController *notifiController = nil;
    //notifiController = [[UINotificationController alloc] initWithStyle:UITableViewStylePlain];
    [super toolbarChange:tag BackTo:@"UICheckin"];
    /*
    NSInteger tag = [sender tag];
    UINotificationController *notifiController = nil;
    switch(tag)
    {
        case 1:
            //[self gotoView:[self.storyboard instantiateViewControllerWithIdentifier:@"UITransportation"]];
            break;
        case 2:
            [self gotoView:[self.storyboard instantiateViewControllerWithIdentifier:@"UICheckin"]];
            break;
        case 3:
            break;
        case 4:
            notifiController = [[UINotificationController alloc] initWithStyle:UITableViewStylePlain];
            [self gotoView: notifiController];
            break;
        case 5:
            break;
        case 6:
            [self gotoView:[self.storyboard instantiateViewControllerWithIdentifier:@"UITransportation"]];
            break;
        default:
            [self gotoView:[self.storyboard instantiateViewControllerWithIdentifier:@"UIHome"]];
            break;
    }
     */
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    //return 4;
    return _CurrentArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_CurrentArray objectAtIndex:section] count];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    float expendIconWidth = 61;
    float height = 64;
    float operatorWidth = 424;
    float contactorWidth = 207;
    float paxWidth = 62;
    float paxTypeWidth = 130;
    float priceWidth = 151;
    float stateWidth = 20;
    float waitingWidth = 65;
    float checkinWidth = 83;
    float noshowWidth = 65;
    float leftMargin = 64;
    
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, height)];
    view.backgroundColor = [ETColor colorWithHexString:@"#f6f6f6"];
    UIView *expendHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width - operatorWidth, height)];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, expendIconWidth,height);
    [btn setImage:[UIImage imageNamed:@"icon_expansion.png"] forState:UIControlStateNormal];
    btn.tag = section;
    [btn addTarget:self action:@selector(expand:) forControlEvents:UIControlEventTouchUpInside];
    if(![[_CurrentArray objectAtIndex:section] isEqualToArray:@[]])
    {
        expendHeaderView.backgroundColor = [ETColor colorWithHexString:@"#007aff"];
        [btn setImage:[UIImage imageNamed:@"icon_expansion_white.png"] forState:UIControlStateNormal];
    }
    
    UILabel *contactLabel = [[UILabel alloc] initWithFrame:CGRectMake(expendIconWidth, 0, contactorWidth,height)];
    contactLabel.text = @"FirstName LastName";
    contactLabel.font = [self HELVETICANEUE_FONT:18];
    UILabel *paxLabel = [[UILabel alloc] initWithFrame:CGRectMake(expendIconWidth + contactorWidth, 0, paxWidth,height)];
    paxLabel.text = @"12";
    paxLabel.font = [self HELVETICANEUE_FONT:18];
    for(int i=0;i<2;i++)
    {
        UILabel *paxTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(expendIconWidth + contactorWidth + paxWidth, i*18, paxTypeWidth,height)];
        paxTypeLabel.text = @"Adult-12";
        paxTypeLabel.font = [self HELVETICANEUE_FONT:18];
        [expendHeaderView addSubview:paxTypeLabel];
    }
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.tableView.frame.size.width - operatorWidth, 0, priceWidth,height)];
    priceLabel.text = @"US$ 240.00";
    priceLabel.font = [self HELVETICANEUE_FONT:18];
    UIImageView *waitingImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.tableView.frame.size.width - leftMargin - noshowWidth - checkinWidth - (waitingWidth - stateWidth)/2, 20, stateWidth, stateWidth)];
    [waitingImage setImage:[UIImage imageNamed:@"icon_input_gray.png"]];
    UIImageView *checkinImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.tableView.frame.size.width - leftMargin - noshowWidth - (checkinWidth - stateWidth)/2, 20, stateWidth, stateWidth)];
    [checkinImage setImage:[UIImage imageNamed:@"icon_input_white.png"]];
    UIImageView *noshowImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.tableView.frame.size.width - leftMargin - (noshowWidth - stateWidth) / 2, 20, stateWidth, stateWidth)];
    [noshowImage setImage:[UIImage imageNamed:@"icon_input_white.png"]];
    
    [expendHeaderView addSubview:btn];
    [expendHeaderView addSubview:contactLabel];
    [expendHeaderView addSubview:paxLabel];
    [view addSubview:expendHeaderView];
    [view addSubview:priceLabel];
    [view addSubview:waitingImage];
    [view addSubview:checkinImage];
    [view addSubview:noshowImage];
    return view;
    /*
    UIView *myView = [[UIView alloc] init];
    //myView.backgroundColor = [ETColor colorWithHexString:@"#e1e1e1"];
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, self.tableView.frame.size.width, 72)];
    [myView addSubview:lbl];
    [myView setBackgroundColor:[ETColor colorWithHexString:@"#f6f6f6"]];
    return myView;
     */
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        return 64;
    }
    else
    {
        return 400;
    }
    /*
    Model *model = [[_array objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if(!model.isExpand)
    {
        return 44;
    }
    else
    {
        return 124;
    }
     */
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    CheckInCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell)
    {
        if(indexPath.row == 0)
        {
            cell = [[OrderInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        else
        {
            cell = [[AdditionalInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
    }
    else
    {
        if(cell.model)
        {
            if(cell.model != [[_CurrentArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row])
            {
                cell.model = [[_CurrentArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
                if(cell.model.isExpand == NO)
                {
                    cell.model = nil;
                }
            }
        }
        else
        {
            cell.model = [[_CurrentArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            if(cell.model.isExpand == NO)
            {
                cell.model = nil;
            }
        }
    }
    cell.layer.borderWidth = 1;
    cell.layer.borderColor = [ETColor colorRefWithR:0 G:122 B:255 A:255];
    
    [cell layoutSubviews];
    return cell;
    /*
    static NSString *CellIdentifier = @"dynamicCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    else
    {
        while([cell.contentView.subviews lastObject] != nil)
        {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    [cell setBackgroundColor:[ETColor colorWithHexString:@"#f6f6f6"]];
    
    return cell;
     */
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 64;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AdditionalInfoCell *cell = (AdditionalInfoCell *)[tableView cellForRowAtIndexPath:indexPath];
    Model *model = [[_array objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    model.isExpand = !model.isExpand;
    
    if(cell.model)
    {
        cell.model = nil;
    }
    else
    {
        cell.model = model;
    }
    [cell layoutSubviews];
    [tableView reloadData];
}

//点击区头按钮 修改数据源数组 展开区
- (void)expand:(UIButton*)btn
{
    if([[_CurrentArray objectAtIndex:btn.tag] isEqualToArray:@[]])
    {
        [_CurrentArray replaceObjectAtIndex:btn.tag withObject:[_array objectAtIndex:btn.tag]];
        
    }else
    {
        
        
        [_CurrentArray replaceObjectAtIndex:btn.tag withObject:@[]];
    }
    [self.tableView reloadData];
}

@end