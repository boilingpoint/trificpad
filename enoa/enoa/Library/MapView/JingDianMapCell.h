//
//  JingDianMapCell.h
//  IYLM
//
//  Created by Jian-Ye on 12-11-8.
//  Copyright (c) 2012年 Jian-Ye. All rights reserved.
//

#import "ETTransLocation.h"
#import <UIKit/UIKit.h>

@interface JingDianMapCell : UIView

@property ETTransLocation *location;

@property(nonatomic,strong) UILabel *lblPinTitle;
@property(nonatomic,strong) UILabel *lblPinNum;
@property(nonatomic,strong) UIImageView *imgPinGo;
@end
