//
//  ETLine.m
//  enoa
//
//  Created by admin on 14-11-24.
//  Copyright (c) 2014年 etourer. All rights reserved.
//

#import "ETLine.h"
#import <Foundation/Foundation.h>

@implementation ETLine

-(void) init
{
    [super init];
    getLinesUrl = [apiUrl stringByAppendingString:@"login"];
}

-(NSArray *)getLinesByDate:(NSString *)date ByOwner:(NSInteger) owner ByType:(NSInteger) type
{
    return nil;
}

@end