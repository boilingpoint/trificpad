//
//  OrderInfoCell.m
//  enoa
//
//  Created by admin on 14-11-20.
//  Copyright (c) 2014年 etourer. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "OrderInfoCell.h"
#import "OrderDetailView.h"
@implementation OrderInfoCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        [self initdata];
    }
    
    return self;
}
- (id)init
{
    self = [super init];
    
    if (self)
    {
        [self initdata];
    }
    
    return self;
}
//初始化Cell
- (void)initdata
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    NSString *currentDate = [formatter stringFromDate:[NSDate date]];
    
    lblPhone = [[UILabel alloc]initWithFrame:CGRectZero];
    lblPhone.text = @"Phone Number";
    lblPhone.frame = CGRectMake(32, 10, 100, 32);
    [self addSubview:lblPhone];
    lblEmail = [[UILabel alloc]initWithFrame:CGRectZero];
    lblEmail.text = @"Email";
    lblEmail.frame = CGRectMake(232, 10, 100, 32);
    [self addSubview:lblEmail];
    lblSaleDate = [[UILabel alloc]initWithFrame:CGRectZero];
    lblSaleDate.text = currentDate;
    lblSaleDate.frame = CGRectMake(432, 10, 100, 32);
    [self addSubview:lblSaleDate];
    lblType = [[UILabel alloc]initWithFrame:CGRectZero];
    lblType.text = @"Name of Agency";
    lblType.frame = CGRectMake(32, 32, 100, 32);
    [self addSubview:lblType];
    lblPax = [[UILabel alloc]initWithFrame:CGRectZero];
    lblPax.text = @"12";
    lblPax.frame = CGRectMake(432, 30, 100, 32);
    [self addSubview:lblPax];
    
    
    
    /*
    self.detailView = [[OrderDetailView alloc]initWithFrame:CGRectZero];
    [self addSubview:self.detailView];
    //    self.detialView.frame=CGRectMake(0, 1, 0, 1);
    //此处label无论单元格展开与否都显示 应通过另外的数据源赋值 此处写死了
    self.TitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 44)];
    self.TitleLabel.text=@"详细";
    [self addSubview:self.TitleLabel];
     */
    
}
//自动布局 将model传给自定义View
- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.model != nil ) {
        self.detailView.model = self.model;
        //下面这行代码只是为了开始自动布局
        [self.detailView layoutSubviews];
        //        _detialView.hidden=NO;
    }else{
        self.detailView.model = nil;
        self.detailView.frame = CGRectZero;
        //        _detialView.hidden=YES;
        
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end