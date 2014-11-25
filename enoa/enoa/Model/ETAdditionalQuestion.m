//
//  ETAdditionalQuestion.m
//  enoa
//
//  Created by admin on 14-11-25.
//  Copyright (c) 2014年 etourer. All rights reserved.
//

#import "ETAdditionalQuestion.h"
#import <Foundation/Foundation.h>


@implementation ETAdditionalQuestion


+(ETBase *)transformToObjectFromDictionary:(NSDictionary *)dic
{
    ETAdditionalQuestion *question = [ETAdditionalQuestion alloc];
    [question init];
    question.Title = [ETBase getStringFromDic:dic Key:@"Title"];
    question.Answer = [ETBase  getStringFromDic:dic Key:@"Answer"];
    
    
    
    return question;
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