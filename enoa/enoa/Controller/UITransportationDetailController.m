//
//  TestController.m
//  enoa
//
//  Created by admin on 14-11-18.
//  Copyright (c) 2014年 etourer. All rights reserved.
//


#import "UITransportationDetailController.h"
#import "ETColor.h"
#import "UINotificationController.h"
#import "ETRPLine.h"
#import "ETTransLocation.h"


#define HELVETICANEUE_FONT(s) [UIFont fontWithName:@"HelveticaNeue" size:s]
#define HELVETICANEUEMEDIUM_FONT(s) [UIFont fontWithName:@"HelveticaNeue-Bold" size:s]
#define HELVETICANEUEBOLD_FONT(s) [UIFont fontWithName:@"HelveticaNeue-Medium" size:s]

@interface UITransportationDetailController ()

@property ETRPLine *rpline;
@property NSMutableArray *locations;

@end

#define NAV_HEIGHT 60.0f
#define NAV_X 0
#define NAV_Y 20
#define NAV_BG @"#106bf8"

@implementation UITransportationDetailController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.rpline = [ETRPLine alloc];
    [self.rpline init];
    NSData *encodeObject = [self GetObjectByKey:@"DetailLine"];
    self.line = [NSKeyedUnarchiver unarchiveObjectWithData:encodeObject];
    ETTransLocation *location = [ETTransLocation alloc];
    [location init];
    self.locations = [location getTransLocationArrayByLine:self.line.OptionCode AndDate:self.line.Date];
    
    [self initTableView];
    
    //self.rpline = [self.rpline getRPLineByCode:self.lineCode];
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
    
    self.lblInfo.font = HELVETICANEUEBOLD_FONT(24);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    NSString *currentDate = [formatter stringFromDate:[NSDate date]];
    [self.lblInfo setText:[NSString stringWithFormat:@"Date: %@   Line: %@   VH: %@   PAX: %@", self.line.Date, self.line.OptionName, self.line.Vh, self.line.Pax]];
    [self.lblInfo setFrame:CGRectMake(leftMargin, 12, 602, 74)];
    self.lblInfo.lineBreakMode = UILineBreakModeWordWrap;
    self.lblInfo.numberOfLines = 3;
    [self.controlView setBackgroundColor:[ETColor colorWithHexString:@"#f6f6f6"]];
    [self.typeSegment setFrame:CGRectMake(btnLeftMargin, 32, btnWidth * 2, btnHeight)];
    [self.typeSegment setTitle:@"List" forSegmentAtIndex:0];
    [self.typeSegment setTitle:@"Map" forSegmentAtIndex:1];
    [self.typeSegment addTarget:self action:@selector(controlPressed:) forControlEvents:UIControlEventValueChanged];
    

    
    [self.tableView setFrame:CGRectMake(leftMargin, self.tabNav.frame.origin.y +self.tabNav.frame.size.height + ctrlViewHeight
                                             , self.view.frame.size.width - leftMargin * 2, listViewHeight)];
    [self.tableView setBackgroundColor:[ETColor colorWithHexString:@"#f6f6f6"]];
    
    [self.mapView setFrame:CGRectMake(0, self.tabNav.frame.origin.y +self.tabNav.frame.size.height + ctrlViewHeight, self.view.frame.size.width, self.view.frame.size.height - self.tabNav.frame.origin.y - self.tabNav.frame.size.height - ctrlViewHeight)];
    [self.mapView setHidden:YES];
    //self.mapView.
}

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

- (IBAction)toolBarItemTap:(id)sender {
    
    NSInteger tag = [sender tag];
    //UINotificationController *notifiController = nil;
    //notifiController = [[UINotificationController alloc] initWithStyle:UITableViewStylePlain];
    [super toolbarChange:tag BackTo:@"UITransportation"];
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
    return self.locations.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    ETTransLocation *location = self.locations[section];
    return location.OrderArray.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ETTransLocation *location = self.locations[section];
    UIView *myView = [[UIView alloc] init];
    //myView.backgroundColor = [ETColor colorWithHexString:@"#e1e1e1"];
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, self.tableView.frame.size.width, 72)];
    lbl.text = [NSString stringWithFormat:@"%@, %@, Location Total:%d",location.Time, location.Location, location.Pax];
    [myView addSubview:lbl];
    [myView setBackgroundColor:[ETColor colorWithHexString:@"#f6f6f6"]];
    return myView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        return 42;
    }
    else// if(indexPath.row == 1)
    {
        return 90;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    ETTransLocation *location = self.locations[indexPath.section];
    ETOrderInfo *order = location.OrderArray[indexPath.row];
    UIView *view = [[UIView alloc] init];
    UILabel *lblContactor = [[UILabel alloc] init];
    lblContactor.text = [NSString stringWithFormat:@"%@ %@",order.Contactor.FirstName, order.Contactor.LastName];
    [cell setBackgroundColor:[ETColor colorWithHexString:@"#f6f6f6"]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}


@end