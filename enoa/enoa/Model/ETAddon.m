//
//  ETAddon.m
//  enoa
//
//  Created by admin on 14-11-25.
//  Copyright (c) 2014年 etourer. All rights reserved.
//

#import "ETAddon.h"
#import <Foundation/Foundation.h>

@implementation ETAddon


+(ETBase *)transformToObjectFromDictionary:(NSDictionary *)dic
{
    ETAddon *addon = [ETAddon alloc];
    [addon init];
    addon.Name = [ETBase getStringFromDic:dic Key:@"Name"];
    addon.Num = [ETBase getIntegerFromDic:dic Key:@"Num"];
    
    
    return addon;
}
+(NSArray *)transformToObjectArrayFromDictionary:(NSDictionary *)dic
{
    NSMutableArray *result = nil;
    
    NSArray *arOrders = [dic valueForKey:@"orders"];
    NSString *total =[dic valueForKey:@"total"];
    NSString *totalPage =[dic valueForKey:@"totalPage"];
    NSString *page =[dic valueForKey:@"page"];
    NSString *pn =[dic valueForKey:@"pn"];
    if(arOrders != nil)
    {
        result = [[NSMutableArray alloc] init];
        for (NSDictionary *dicOrder in arOrders) {
            [result addObject:[self transformToObjectFromDictionary:dicOrder]];
        }
    }
    return result;
}


@end