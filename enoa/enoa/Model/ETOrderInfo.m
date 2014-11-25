//
//  ETOrderInfo.m
//  enoa
//
//  Created by admin on 14-11-24.
//  Copyright (c) 2014年 etourer. All rights reserved.
//

#import "ETOrderInfo.h"
#import "ETTransLocation.h"
#import "ETAdditionalQuestion.h"
#import "ETAddon.h"
#import <Foundation/Foundation.h>


@implementation ETOrderInfo

-(void)init
{
}

+(ETBase *)transformToObjectFromDictionary:(NSDictionary *)dic
{
    ETOrderInfo *order = [ETOrderInfo alloc];
    [order init];
    order.Pax = [ETBase getIntegerFromDic:dic Key:@"Pax"];
    order.Price = [ETBase getDoubleFromDic:dic Key:@"Price"];
    order.OrderState = [ETBase  getIntegerFromDic:dic Key:@"OrderState"];
    order.VoucherId = [ETBase  getStringFromDic:dic Key:@"VoucherId"];
    order.CheckinState = [ETBase  getStringFromDic:dic Key:@"CheckinState"];
    order.Note = [ETBase  getStringFromDic:dic Key:@"Note"];
    
    order.TransLocationArray = [ETTransLocation transformToObjectArrayFromDictionary:[ETBase getDicFromDic:dic Key:@"Locations"]];
    order.Contactor = [ETContactor transformToObjectFromDictionary:[ETBase getDicFromDic:dic Key:@"Contactor"]];
    order.AdditionalQuestionArray = [ETAdditionalQuestion transformToObjectArrayFromDictionary:[ETBase getDicFromDic:dic Key:@"Questions"]];
    order.AddonArray = [ETAddon transformToObjectArrayFromDictionary:[ETBase getDicFromDic:dic Key:@"Addons"]];
    
    
    return order;
}
+(NSArray *)transformToObjectArrayFromDictionary:(NSDictionary *)dic
{
    NSMutableArray *result = nil;
    
    NSArray *arOrders = [dic valueForKey:@"locations"];
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