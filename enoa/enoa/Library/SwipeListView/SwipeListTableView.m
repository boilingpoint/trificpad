//
//  SwipeListTableView.m
//  enoa
//
//  Created by admin on 14-11-21.
//  Copyright (c) 2014年 etourer. All rights reserved.
//
//

#import "SwipeListTableView.h"
#import <objc/runtime.h>

const static CGFloat kDeleteButtonWidth = 80.f;
const static CGFloat kDeleteButtonHeight = 44.f;
const static CGFloat kMarkReadButtonWidth = 80.0f;
const static CGFloat kMarkReadButtonHeight = 44.0f;

#define screenWidth() (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)


const static char * kSwipeListTableViewCellIndexPathKey = "SwipeListTableViewCellIndexPathKey";

@interface UIButton (NSIndexPath)

- (void)setIndexPath:(NSIndexPath *)indexPath;
- (NSIndexPath *)indexPath;

@end

@implementation UIButton (NSIndexPath)

- (void)setIndexPath:(NSIndexPath *)indexPath {
    objc_setAssociatedObject(self, kSwipeListTableViewCellIndexPathKey, indexPath, OBJC_ASSOCIATION_RETAIN);
}

- (NSIndexPath *)indexPath {
    id obj = objc_getAssociatedObject(self, kSwipeListTableViewCellIndexPathKey);
    if([obj isKindOfClass:[NSIndexPath class]]) {
        return (NSIndexPath *)obj;
    }
    return nil;
}

@end

@interface SwipeListTableView() {
    UISwipeGestureRecognizer * _leftGestureRecognizer;
    UISwipeGestureRecognizer * _rightGestureRecognizer;
    UITapGestureRecognizer * _tapGestureRecognizer;
    
    UIButton * _deleteButton;
    
    UIButton *_markReadButton;
    
    NSIndexPath * _editingIndexPath;
}

@end

@implementation SwipeListTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        _leftGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swiped:)];
        _leftGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
        _leftGestureRecognizer.delegate = self;
        [self addGestureRecognizer:_leftGestureRecognizer];
        
        _rightGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swiped:)];
        _rightGestureRecognizer.delegate = self;
        _rightGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:_rightGestureRecognizer];
        
        _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
        _tapGestureRecognizer.delegate = self;
        //_tapGestureRecognizer.delegate = self;
        // Don't add this yet
        
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteButton.frame = CGRectMake(screenWidth(), 0, kDeleteButtonWidth, kDeleteButtonHeight);
        _deleteButton.backgroundColor = [UIColor redColor];
        _deleteButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        [_deleteButton setTitle:@"insert" forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(deleteItem:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_deleteButton];
        
        _markReadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _markReadButton.frame = CGRectMake(0-kMarkReadButtonWidth, 0, kMarkReadButtonWidth, kMarkReadButtonHeight);
        _markReadButton.backgroundColor = [UIColor greenColor];
        _markReadButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;//UIViewAutoresizingFlexibleLeftMargin;
        [_markReadButton setTitle:@"Mark as Read" forState:UIControlStateNormal];
        [_markReadButton addTarget:self action:@selector(markReadItem:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_markReadButton];
        
        
        [self setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame style:UITableViewStylePlain];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // drawing code
 }
 */

- (void)swiped:(UISwipeGestureRecognizer *)gestureRecognizer {
    NSIndexPath * indexPath = [self cellIndexPathForGestureRecognizer:gestureRecognizer];
    if(indexPath == nil)
        return;
    
    if(![self.dataSource tableView:self canEditRowAtIndexPath:indexPath]) {
        return;
    }
    
    if(gestureRecognizer == _leftGestureRecognizer && ![_editingIndexPath isEqual:indexPath]) {
        UITableViewCell * cell = [self cellForRowAtIndexPath:indexPath];
        [self setEditing:YES atIndexPath:indexPath cell:cell];
    } else if (gestureRecognizer == _rightGestureRecognizer && [_editingIndexPath isEqual:indexPath]){
        UITableViewCell * cell = [self cellForRowAtIndexPath:indexPath];
        [self setEditing:NO atIndexPath:indexPath cell:cell];
    }
}

- (void)tapped:(UIGestureRecognizer *)gestureRecognizer
{
    if(_editingIndexPath) {
        UITableViewCell * cell = [self cellForRowAtIndexPath:_editingIndexPath];
        [self setEditing:NO atIndexPath:_editingIndexPath cell:cell];
    }
}

- (NSIndexPath *)cellIndexPathForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer {
    UIView * view = gestureRecognizer.view;
    if(![view isKindOfClass:[UITableView class]]) {
        return nil;
    }
    
    CGPoint point = [gestureRecognizer locationInView:view];
    NSIndexPath * indexPath = [self indexPathForRowAtPoint:point];
    return indexPath;
}

- (void)setEditing:(BOOL)editing atIndexPath:indexPath cell:(UITableViewCell *)cell {
    
    if(editing) {
        if(_editingIndexPath) {
            UITableViewCell * editingCell = [self cellForRowAtIndexPath:_editingIndexPath];
            [self setEditing:NO atIndexPath:_editingIndexPath cell:editingCell];
        }
        [self addGestureRecognizer:_tapGestureRecognizer];
    } else {
        [self removeGestureRecognizer:_tapGestureRecognizer];
    }
    
    CGRect frame = cell.frame;
    
    CGFloat cellXOffset;
    CGFloat deleteButtonXOffsetOld;
    CGFloat deleteButtonXOffset;
    CGFloat markReadButtonXOffsetOld;
    CGFloat markReadButtonXOffset;
    
    if(editing) {
        cellXOffset = -kDeleteButtonWidth;
        deleteButtonXOffset = screenWidth() - kDeleteButtonWidth;
        deleteButtonXOffsetOld = screenWidth();
        _editingIndexPath = indexPath;
    } else {
        cellXOffset = 0;
        markReadButtonXOffset = 0;
        markReadButtonXOffsetOld = - kDeleteButtonWidth;
        _editingIndexPath = indexPath;
    }
    
    CGFloat cellHeight = [self.delegate tableView:self heightForRowAtIndexPath:indexPath];
    _deleteButton.frame = (CGRect) {deleteButtonXOffsetOld, frame.origin.y, _deleteButton.frame.size.width, cellHeight};
    _deleteButton.indexPath = indexPath;
    
    _markReadButton.frame = (CGRect){markReadButtonXOffsetOld, frame.origin.y, _markReadButton.frame.size.width, cellHeight};
    _markReadButton.indexPath = indexPath;
    
    [UIView animateWithDuration:0.2f animations:^{
        cell.frame = CGRectMake(cellXOffset, frame.origin.y, frame.size.width, frame.size.height);
        _deleteButton.frame = (CGRect) {deleteButtonXOffset, frame.origin.y, _deleteButton.frame.size.width, cellHeight};
        _markReadButton.frame = (CGRect) {markReadButtonXOffset, frame.origin.y, _markReadButton.frame.size.width, cellHeight};
    }];
}

#pragma mark - Interaciton
- (void)deleteItem:(id)sender {
    UIButton * deleteButton = (UIButton *)sender;
    NSIndexPath * indexPath = deleteButton.indexPath;
    
    [self.dataSource tableView:self commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:indexPath];
    
    _editingIndexPath = nil;
    
    [UIView animateWithDuration:0.2f animations:^{
        CGRect frame = _deleteButton.frame;
        _deleteButton.frame = (CGRect){frame.origin, frame.size.width, 0};
    } completion:^(BOOL finished) {
        CGRect frame = _deleteButton.frame;
        _deleteButton.frame = (CGRect){screenWidth(), frame.origin.y, frame.size.width, kDeleteButtonHeight};
    }];
}

-(void)markReadItem:(id)sender
{
    UIButton * deleteButton = (UIButton *)sender;
    NSIndexPath * indexPath = deleteButton.indexPath;
    
    [self.dataSource tableView:self commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:indexPath];
    
    _editingIndexPath = nil;
    
    [UIView animateWithDuration:0.2f animations:^{
        CGRect frame = _deleteButton.frame;
        _deleteButton.frame = (CGRect){frame.origin, frame.size.width, 0};
    } completion:^(BOOL finished) {
        CGRect frame = _deleteButton.frame;
        _deleteButton.frame = (CGRect){screenWidth(), frame.origin.y, frame.size.width, kDeleteButtonHeight};
    }];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return NO; // Recognizers of this class are the first priority
}

@end
