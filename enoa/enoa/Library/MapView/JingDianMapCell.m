//
//  JingDianMapCell.m
//  IYLM
//
//  Created by Jian-Ye on 12-11-8.
//  Copyright (c) 2012年 Jian-Ye. All rights reserved.
//

#import "JingDianMapCell.h"
#import "ETColor.h"

@implementation JingDianMapCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initdata];
        // Initialization code
    }
    return self;
}

//初始化Cell
- (void)initdata
{
    UIView *viewLeft = [[UIView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, 50, self.frame.size.height - 10)];
    viewLeft.backgroundColor = [ETColor colorWithHexString:@"#007aff"];
    UIView *viewCenter = [[UIView alloc] initWithFrame:CGRectMake(40, self.frame.origin.y, 20, self.frame.size.height - 10)];
    viewCenter.backgroundColor = [UIColor whiteColor];
    UIView *viewRight = [[UIView alloc] initWithFrame:CGRectMake(40, self.frame.origin.y, self.frame.size.width - 40, self.frame.size.height - 10)];
    viewRight.backgroundColor = [UIColor whiteColor];
    
    viewLeft.layer.cornerRadius = 7;
    viewRight.layer.cornerRadius = 7;
    
    self.lblPinNum = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 30, 24)];
    self.lblPinNum.text = [NSString stringWithFormat:@"%d", self.location.Pax];
    [viewLeft addSubview:self.lblPinNum];
    
    self.lblPinTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 197, 24)];
    self.lblPinTitle.text = self.location.Location;
    [viewRight addSubview:self.lblPinTitle];
    
    self.imgPinGo = [[UIImageView alloc] initWithFrame:CGRectMake(181, 10, 12, 12)];
    self.imgPinGo.image = [UIImage imageNamed:@"icon_map_but.png"];
    [viewRight addSubview:self.imgPinGo];
    //UIButton *btn = [[UIButton alloc] initWithFrame:self.frame];
    [self addSubview:viewLeft];
    [self addSubview:viewCenter];
    [self addSubview:viewRight];
    //[self addSubview:btn];
}
//自动布局 将model传给自定义View
- (void)layoutSubviews
{
    [super layoutSubviews];
    //
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
