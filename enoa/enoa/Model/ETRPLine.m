//
//  Transportation.m
//  enoa
//
//  Created by admin on 14-11-7.
//  Copyright (c) 2014年 etourer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ETRPLine.h"

@implementation ETRPLine

-(void) init
{
    [super init];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    merchantCode = [userDefaults objectForKey:@"merchant"];
    token = [userDefaults objectForKey:@"token"];
    /*
    orderListUrl = [apiUrl stringByAppendingString:[NSString stringWithFormat:@"merchant/%@/orders",merchantCode]];
    //orderDetailUrl = [apiUrl stringByAppendingString:[NSString stringWithFormat:@"merchant/%@/orders/",merchantCode]];
    orderOverviewUrl = [apiUrl stringByAppendingString:@"overview"];
    recordGuestInfoUrl = [apiUrl stringByAppendingString:[NSString stringWithFormat:@"appsnapshot/%@/snapshot",merchantCode]];
     */
}

-(NSArray *)getRPLinesByDate:(NSString *)date ByOwner:(NSInteger) owner
{
    return nil;
}

@end