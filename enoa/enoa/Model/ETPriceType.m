//
//  ETPriceType.m
//  enoa
//
//  Created by admin on 14-11-24.
//  Copyright (c) 2014年 etourer. All rights reserved.
//

#import "ETPriceType.h"
#import <Foundation/Foundation.h>



@implementation ETPriceType

+(ETBase *)transformToObjectFromDictionary:(NSDictionary *)dic
{
    ETPriceType *priceType = [ETPriceType alloc];
    priceType.Title = [ETBase getStringFromDic:dic Key:@"Title"];
    priceType.Num = [ETBase getIntegerFromDic:dic Key:@"Num"];
    
    return priceType;
}

+(NSArray *)transformToObjectArrayFromDictionary:(NSDictionary *)dic
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (NSDictionary *dicOrder in dic) {
        [result addObject:[self transformToObjectFromDictionary:dicOrder]];
    }
    return result;
}

@end