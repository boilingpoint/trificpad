//
//  CheckInCell.h
//  enoa
//
//  Created by admin on 14-11-20.
//  Copyright (c) 2014年 etourer. All rights reserved.
//

#ifndef enoa_CheckInCell_h
#define enoa_CheckInCell_h

#import <UIKit/UIKit.h>
#import "Model.h"
#import "CheckInDetailView.h"

@interface CheckInCell : UITableViewCell

//此处label无论单元格展开与否都显示
@property(nonatomic,strong) UILabel *TitleLabel;

@property(nonatomic,strong)Model *model;
@property(nonatomic,strong  )CheckInDetailView *detailView;

@end

#endif
