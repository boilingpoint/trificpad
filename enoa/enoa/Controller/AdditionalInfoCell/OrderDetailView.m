//
//  OrderDetailView.m
//  enoa
//
//  Created by admin on 14-11-20.
//  Copyright (c) 2014年 etourer. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "OrderDetailView.h"

@implementation OrderDetailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initdata];
    }
    return self;
}

//初始化View 创建展开后控件！并将frame初始化为（0，0，0，0）包括要写死的控件
- (void)initdata
{
    lblPhone = [[UILabel alloc]initWithFrame:CGRectZero];
    [self addSubview:lblPhone];
    lblEmail = [[UILabel alloc]initWithFrame:CGRectZero];
    [self addSubview:lblEmail];
    lblSaleDate = [[UILabel alloc]initWithFrame:CGRectZero];
    [self addSubview:lblSaleDate];
    lblType = [[UILabel alloc]initWithFrame:CGRectZero];
    [self addSubview:lblType];
    lblPax = [[UILabel alloc]initWithFrame:CGRectZero];
    [self addSubview:lblPax];
    
}
//自动布局 通过model 给展开后控件复制！！（详细控件在该方法内创建 在else中隐藏 包括要写死的控件）
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    NSString *currentDate = [formatter stringFromDate:[NSDate date]];
    if (self.model != nil && self.model.isExpand==YES) {
        self.backgroundColor=[UIColor greenColor];
        lblPhone.text = @"Phone Number";
        lblPhone.frame = CGRectMake(32, 10, 100, 32);
        
        lblEmail.text = @"Email";
        lblEmail.frame = CGRectMake(232, 10, 100, 32);
        
        lblSaleDate.text = currentDate;
        lblSaleDate.frame = CGRectMake(432, 10, 100, 32);
        
        lblType.text = @"Name of Agency";
        lblType.frame = CGRectMake(32, 32, 100, 32);
        
        lblPax.text = @"12";
        lblPax.frame = CGRectMake(432, 30, 100, 32);
        
        //控件必须改为不隐藏
        lblPhone.hidden = NO;
        lblEmail.hidden = NO;
        lblSaleDate.hidden = NO;
        lblType.hidden = NO;
        lblPax.hidden = NO;
        //高度可以通过实现计算高度的方法来获得
        self.frame = CGRectMake(0, 44, 300, 80);
        
        
    }else {
        self.backgroundColor=[UIColor clearColor];
        lblPhone.hidden = YES;
        lblEmail.hidden = YES;
        lblSaleDate.hidden = YES;
        lblType.hidden = YES;
        lblPax.hidden = YES;
    }
}

//+(CGFloat)getHeightByModel:(Model*)model
//{
//    if (model) {
//        return 124;
//    }else
//    {
//        return 44;
//    }
//
//}
@end