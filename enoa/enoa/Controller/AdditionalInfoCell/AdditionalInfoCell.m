//
//  AdditionalInfoCell.m
//  enoa
//
//  Created by admin on 14-11-20.
//  Copyright (c) 2014年 etourer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AdditionalInfoCell.h"
#import "AdditionalDetailView.h"
#import "ETColor.h"

@implementation AdditionalInfoCell


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
    self.detailView = [[AdditionalDetailView alloc]initWithFrame:CGRectZero];
    [self addSubview:self.detailView];
    
    for(int i=0;i<5;i++)
    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(12, 35*(i+1), 32, 32)];
        
        [btn setTitle:[NSString stringWithFormat:@"%d", i] forState:UIControlStateNormal];
        
        [btn setTitleColor:[ETColor colorWithHexString:@"#007aff"] forState:UIControlStateNormal];
        [btn.layer setBorderWidth:1];
        btn.layer.borderColor = [ETColor colorRefWithR:0 G:122 B:255 A:255];
        [self addSubview:btn];
    }
    
    
    
    [self addSubview:self.TitleLabel];
    
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