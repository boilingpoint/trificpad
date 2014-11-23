//
//  ETButton.m
//  enoa
//
//  Created by admin on 14-11-14.
//  Copyright (c) 2014年 etourer. All rights reserved.
//
/*
#import <UIKit/UIKit.h>

#define HELVETICSNEUEMEDIUM_FONT(s) [UIFont fontWithName:@"ArialMT" size:s]

@implementation UIButton (UIButtonImageWithLable)

-(void) setImage:(UIImage *) image withTitle:(NSString *)title forState:(UIControlState) stateType {
    CGSize titleSize = [title sizeWithFont:HELVETICSNEUEMEDIUM_FONT(12.0f)];
    [self.imageView setContentMode:UIViewContentModeCenter];
    [self setImageEdgeInsets:UIEdgeInsetsMake(
                                              -8.0,
                                              0.0,
                                              0.0,
                                              -titleSize.width
                                              )];
    [self setImage:image forState:stateType];
    
    [self.titleLabel setContentMode:UIViewContentModeCenter];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
    [self setTitleColor:[UIColor blueColor] forState:stateType];
    if(stateType == UIControlStateSelected) {
        [self setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    } else {
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    [self setTitleEdgeInsets:UIEdgeInsetsMake(35.0,
                                              -image.size.width,
                                              0.0,
                                              0.0)];
    [self setTitle:title forState:stateType];
}

@end
*/