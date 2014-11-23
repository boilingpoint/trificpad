//
//  ETTransportation.h
//  enoa
//
//  Created by admin on 14-11-7.
//  Copyright (c) 2014年 etourer. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "ETBase.h"
#define Me 0
#define All 1

@interface ETRPLine : ETBase
{
    NSString *merchantCode;
    NSString *token;
    
    NSString *OptionCode;
    NSString *OptionName;
    NSString *Driver;
    NSString *Vh;
    NSString *Pax;
    NSString *FirstTime;
    NSString *FirstLocation;
}
-(void)init;
-(NSArray *)getRPLinesByDate:(NSString *)date ByOwner:(NSInteger) owner;

@end
