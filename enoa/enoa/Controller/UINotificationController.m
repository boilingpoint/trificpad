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


#define NAV_HEIGHT 60.0f
#define NAV_X 0
#define NAV_Y 20
#define NAV_BG @"#106bf8"

@interface UINotificationController () {
    NSMutableArray *_testArray;
}
@end

@implementation UINotificationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 66;
    self.tableView.allowsSelection = NO; // We essentially implement our own selection
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0); // Makes the horizontal row seperator stretch the entire length of the table view
    
    _testArray = [[NSMutableArray alloc] init];
    
    // Add test data to our test array
    [_testArray addObject:[NSDate date]];
    [_testArray addObject:[NSDate date]];
    [_testArray addObject:[NSDate date]];
}

-(void) viewDidLayoutSubviews
{
    float leftMargin = 0.f;
    float listViewHeight = 544.0;
    
    [self.tabNav setFrame:CGRectMake(NAV_X, NAV_Y, self.view.frame.size.width, NAV_HEIGHT)];
    [self.tabNav setBackgroundColor:[ETColor colorWithHexString:NAV_BG]];
    
    [self.tableView setFrame:CGRectMake(leftMargin, self.tabNav.frame.origin.y +self.tabNav.frame.size.height 
                                        , self.view.frame.size.width - leftMargin * 2, listViewHeight)];
    [self.tableView setBackgroundColor:[ETColor colorWithHexString:@"#f6f6f6"]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _testArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"cell selected at index path %d", indexPath.row);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    SWTableViewCell *cell = (SWTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        NSMutableArray *leftUtilityButtons = [NSMutableArray new];
        NSMutableArray *rightUtilityButtons = [NSMutableArray new];
        
        //[leftUtilityButtons addUtilityButtonWithColor:
        // [UIColor colorWithRed:0.07 green:0.75f blue:0.16f alpha:1.0]
        //                                         icon:[UIImage imageNamed:@"check.png"]];
        //[leftUtilityButtons addUtilityButtonWithColor:
        //[UIColor colorWithRed:1.0f green:1.0f blue:0.35f alpha:1.0]
        //                                         icon:[UIImage imageNamed:@"clock.png"]];
        //[leftUtilityButtons addUtilityButtonWithColor:
         //[UIColor colorWithRed:1.0f green:0.231f blue:0.188f alpha:1.0]
          //                                       icon:[UIImage imageNamed:@"cross.png"]];
        //[leftUtilityButtons addUtilityButtonWithColor:
        //[UIColor colorWithRed:0.55f green:0.27f blue:0.07f alpha:1.0]
        //                                        icon:[UIImage imageNamed:@"list.png"]];
        
        //[rightUtilityButtons addUtilityButtonWithColor:
        //[UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
        //                                        title:@"More"];
        
    [leftUtilityButtons addUtilityButtonWithColor:
     [ETColor colorWithHexString:@"#007aff"] title:@"Mark as Read"];
        
        cell = [[SWTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellIdentifier
                                  containingTableView:_tableView // Used for row height and selection
                                   leftUtilityButtons:leftUtilityButtons
                                  rightUtilityButtons:rightUtilityButtons];
    
        [rightUtilityButtons addUtilityButtonWithColor:
         [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                 title:@"Delete"];
        
        cell = [[SWTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellIdentifier
                                  containingTableView:_tableView // Used for row height and selection
                                   leftUtilityButtons:leftUtilityButtons
                                  rightUtilityButtons:rightUtilityButtons];
        cell.delegate = self;
    }
    
    NSDate *dateObject = _testArray[indexPath.row];
    cell.textLabel.text = [dateObject description];
    cell.detailTextLabel.text = @"Some detail text";
    
    return cell;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSLog(@"scroll view did begin dragging");
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    // Set background color of cell here if you don't want white
}

#pragma mark - SWTableViewDelegate

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
            
            [_testArray removeObjectAtIndex:cellIndexPath.row];
            [self.tableView deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
            break;
        }
        default:
            break;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
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

@end
