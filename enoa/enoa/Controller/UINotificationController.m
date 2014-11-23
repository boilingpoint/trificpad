//
//  UINotificationController.m
//  enoa
//
//  Created by admin on 14-11-15.
//  Copyright (c) 2014年 etourer. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UINotificationController.h"
//#import "MCSwipeTableViewCell.h"
#import "SWTableViewCell.h"
#import "ETColor.h"



#define HELVETICANEUE_FONT(s) [UIFont fontWithName:@"HelveticaNeue" size:s]
#define HELVETICANEUEMEDIUM_FONT(s) [UIFont fontWithName:@"HelveticaNeue-Bold" size:s]
#define HELVETICANEUEBOLD_FONT(s) [UIFont fontWithName:@"HelveticaNeue-Medium" size:s]

#define NAV_HEIGHT 60.0f
#define NAV_X 0
#define NAV_Y 0
#define NAV_BG @"#106bf8"

static NSUInteger const kMCNumItems = 20;

@interface UINotificationController () //<MCSwipeTableViewCellDelegate, UIAlertViewDelegate>
{
    NSMutableArray *_dataArray;
}
/*{
    NSMutableArray *_dataArray;
    UIButton *_deleteButton;
    NSIndexPath *_editingIndexPath;
    
    UISwipeGestureRecognizer *_leftGestureRecognizer;
    UISwipeGestureRecognizer *_rightGestureRecognizer;
    UITapGestureRecognizer *_tapGestureRecognizer;
}
@property (nonatomic, assign) NSUInteger nbItems;
//@property (nonatomic, strong) MCSwipeTableViewCell *cellToDelete;

*/
@end

@implementation UINotificationController
/*
-(id)initWithStyle:(UITableViewStyle) style {
    self = [super initWithStyle:style];

    if(self) {
        _nbItems = kMCNumItems;
    }
    return self;
}
 */

-(id)init
{
    self = [super init];
    if(self)
    {
        _dataArray = [@[@(1), @(2), @(3), @(4), @(5), @(6), @(7), @(8), @(9), @(10)]mutableCopy];
    }
    return self;
}
/*
-(void)loadView
{
    if(self)
    {
        _dataArray = [@[@(1), @(2), @(3), @(4), @(5), @(6), @(7), @(8), @(9), @(10)]mutableCopy];
    }
}*/


-(void)initTableView {
    _dataArray = [[NSMutableArray alloc] init];
    
    // Add test data to our test array
    [_dataArray addObject:[NSDate date]];
    [_dataArray addObject:[NSDate date]];
    [_dataArray addObject:[NSDate date]];
    CGRect frame = self.view.frame;
    self.tableView = [[UITableView alloc] initWithFrame:frame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self; // Makes the horizontal row seperator stretch the entire length of the table view    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.view addSubview:self.tableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    
    /*
    self.title = @"Swipe Table View";
    self.navigationController.navigationBarHidden = YES;
    //self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reload:)];
    
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
    [backgroundView setBackgroundColor:[UIColor colorWithRed:227.0 / 255.0 green:227.0 / 255.0 blue:227.0 / 255.0 alpha:1.0]];
    [self.tableView setBackgroundView:backgroundView];
    
    
    [self.tableView setTableHeaderView:self.toolbarView];
     */
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.view.backgroundColor = [ETColor colorWithHexString:@"#f6f6f6" ];
    
    //[self.tabNav setFrame:CGRectMake(NAV_X, NAV_Y, self.view.frame.size.width, NAV_HEIGHT)];
    //[self.tabNav setBackgroundColor:[ETColor colorWithHexString:NAV_BG]];
    
    //[self.tableView setFrame:CGRectMake(0,0,1024,768)];//(self.tabNav.frame.origin.x, self.tabNav.frame.origin.y + self.tabNav.frame.size.height, self.tableView.frame.size.width, self.tableView.frame.size.height)];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{static NSString *cellIdentifier = @"Cell";
    
    SWTableViewCell *cell = (SWTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        NSMutableArray *leftUtilityButtons = [NSMutableArray new];
        NSMutableArray *rightUtilityButtons = [NSMutableArray new];
        
        [leftUtilityButtons addUtilityButtonWithColor:
         [UIColor colorWithRed:0.07 green:0.75f blue:0.16f alpha:1.0]
                                                 icon:[UIImage imageNamed:@"cross.png"]];
        [rightUtilityButtons addUtilityButtonWithColor:
         [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                 title:@"Delete"];
        
        cell = [[SWTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellIdentifier
                                  containingTableView:self.tableView // Used for row height and selection
                                   leftUtilityButtons:leftUtilityButtons
                                  rightUtilityButtons:rightUtilityButtons];
        cell.delegate = self;
    }
    
    NSDate *dateObject = _dataArray[indexPath.row];
    cell.textLabel.text = [dateObject description];
    cell.detailTextLabel.text = @"Some detail text";
    
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        [_dataArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if(editingStyle == UITableViewCellEditingStyleInsert)
    {
        //
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSLog(@"scroll view did begin dragging");
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    // Set background color of cell here if you don't want white
}

- (void)swippableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index {
    switch (index) {
        case 0:
            NSLog(@"left button 0 was pressed");
            break;
        case 1:
            NSLog(@"left button 1 was pressed");
            break;
        case 2:
            NSLog(@"left button 2 was pressed");
            break;
        case 3:
            NSLog(@"left btton 3 was pressed");
        default:
            break;
    }
}

- (void)swippableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    switch (index) {
        case 0:
        {
            NSLog(@"More button was pressed");
            UIAlertView *alertTest = [[UIAlertView alloc] initWithTitle:@"Hello" message:@"More more more" delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles: nil];
            [alertTest show];
            
            [cell hideUtilityButtonsAnimated:YES];
            break;
        }
        case 1:
        {
            // Delete button was pressed
            NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
            
            [_dataArray removeObjectAtIndex:cellIndexPath.row];
            [self.tableView deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
            break;
        }
        default:
            break;
    }
}

- (IBAction)toolBarItemTap:(id)sender {
    NSInteger tag = [sender tag];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryBoard_iPad" bundle:nil];
    switch(tag)
    {
        case 1:
            
            [self gotoView:[storyboard instantiateViewControllerWithIdentifier:@"UITransportation"]];
            break;
        case 2:
            [self gotoView:[storyboard instantiateViewControllerWithIdentifier:@"UICheckin"]];
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
            [self gotoView:[storyboard instantiateViewControllerWithIdentifier:@"UIHome"]];
            break;
    }
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
@end
