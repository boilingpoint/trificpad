//
//  OrderInfoCell.h
//  enoa
//
//  Created by admin on 14-11-20.
//  Copyright (c) 2014年 etourer. All rights reserved.
//

#ifndef enoa_OrderInfoCell_h
#define enoa_OrderInfoCell_h

#import <UIKit/UIKit.h>
//#import "Model.h"
//#import "CheckInDetailView.h"
#import "CheckInCell.h"
@interface OrderInfoCell : CheckInCell
{
    //根据model需求 创建所需控件
    UILabel *lblPhone;
    UILabel *lblEmail;
    UILabel *lblSaleDate;
    UILabel *lblType;
    UILabel *lblPax;
    
}

//此处label无论单元格展开与否都显示
@property(nonatomic,strong) UILabel *TitleLabel;

//@property(nonatomic,strong)Model *model;
//@property(nonatomic,strong  )CheckInDetailView *detailView;

@end

#endif
