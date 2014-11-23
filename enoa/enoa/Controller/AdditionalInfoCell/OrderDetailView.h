//
//  OrderDetailView.h
//  enoa
//
//  Created by admin on 14-11-20.
//  Copyright (c) 2014年 etourer. All rights reserved.
//

#ifndef enoa_OrderDetailView_h
#define enoa_OrderDetailView_h


#import <UIKit/UIKit.h>
#import "Model.h"
#import "CheckInDetailView.h"

@interface OrderDetailView : CheckInDetailView
{
    //根据model需求 创建所需控件
    UILabel *lblPhone;
    UILabel *lblEmail;
    UILabel *lblSaleDate;
    UILabel *lblType;
    UILabel *lblPax;
    
}

//下边方法可以自己实现 用于计算view高度 或者单元格高度

//+(CGFloat)getHeightByModel:(Model*)model;

@property(nonatomic,strong)Model *model;
@end


#endif
