//
//  ETTransLocation.m
//  enoa
//
//  Created by admin on 14-11-24.
//  Copyright (c) 2014年 etourer. All rights reserved.
//

#import "ETTransLocation.h"
#import <Foundation/Foundation.h>

@implementation ETTransLocation

-(void)init
{
}

-(NSArray *)getTransLocationArrayByLine:(NSString *)code AndDate:(NSString *)date
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    NSMutableArray *geo = @[@{@"latitude":@"30.281843",
                              @"longitude":@"120.102193",
                              @"title":@"test-title-1",
                              @"subtitle":@"test-sub-title-11"},
                            @{@"latitude":@"30.290144",
                              @"longitude":@"120.146696‎",
                              @"title":@"test-title-2",
                              @"subtitle":@"test-sub-title-22"},
                            @{@"latitude":@"30.248076",
                              @"longitude":@"120.164162‎",
                              @"title":@"test-title-3",
                              @"subtitle":@"test-sub-title-33"},
                            @{@"latitude":@"30.425622",
                              @"longitude":@"120.299605",
                              @"title":@"test-title-4",
                              @"subtitle":@"test-sub-title-44"}];
    for(int i=0;i<4;i++)
    {
          
        ETTransLocation *location = [ETTransLocation alloc];
        [location init];
        location.Time = [NSString stringWithFormat:@"3:%d", i];
        location.Location = [NSString stringWithFormat:@"location %d", i];
        location.Pax = i;
        location.Latitude = [geo[i] objectForKey:@"latitude"];
        location.Longitude = [geo[i] objectForKey:@"longitude"];
        
        location.OrderArray = [[NSMutableArray alloc] init];
        for(int j=0;j<3;j++)
        {
            ETOrderInfo *order = [ETOrderInfo alloc];
            order.Price = 200.00;
            order.Pax = i;
            ETContactor *contactor = [ETContactor alloc];
            contactor.FirstName = @"First ";
            contactor.LastName = @" Last";
            order.Contactor = contactor;
            order.Note = @"Note";
            order.PriceTypeArray = [[NSMutableArray alloc] init];
            for(int k=0;k<3;k++)
            {
                ETPriceType *priceType = [ETPriceType alloc];
                priceType.Title = [NSString stringWithFormat:@"%@ %d", @"Title", k ];
                priceType.Num = k;
                [order.PriceTypeArray addObject:priceType];
            }
            
            [location.OrderArray addObject:order];
        }
        [array addObject:location];
    }
    return array;
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@?book_date=%@",getLocationsUrl,merchantCode, date]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSArray arrayWithObjects: merchantCode, nil],
                            @"id",
                            [NSArray arrayWithObjects:date, nil],
                            @"book_date",
                            nil];
    
    [request addRequestHeader:@"Authorization" value:[ETAuthorization getDigestAuthorizationWithAccesskey:accessKey WithSecretKey:secretKey WithRealm:realm WithMethod:@"GET" WithUri:@"/overview/" WithParams:params WithAuth:@"auth-int"]];
    [request startSynchronous];
    NSError *error = [request error];
    NSData *resData = nil;
    if(!error)
    {
        NSString *response = [request responseString];
        resData = [response dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    if(resData)
    {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingAllowFragments error:nil];
        if(dic == nil || [dic valueForKey:@"error"] != nil)
        {
            return nil;
        }
        
        
        return [ETTransLocation transformToObjectArrayFromDictionary:dic];
    }
    return nil;
}


+(ETBase *)transformToObjectFromDictionary:(NSDictionary *)dic
{
    ETTransLocation *location = [ETTransLocation alloc];
    [location init];
    location.Time = [ETBase getStringFromDic:dic Key:@"Time"];
    location.Location = [ETBase  getStringFromDic:dic Key:@"Location"];
    location.Pax = [ETBase  getIntegerFromDic:dic Key:@"Pax"];
    location.Latitude = [ETBase  getStringFromDic:dic Key:@"Latitude"];
    location.Longitude = [ETBase  getStringFromDic:dic Key:@"Longitude"];
    
    location.OrderArray = [ETOrderInfo transformToObjectArrayFromDictionary:[ETBase getDicFromDic:dic Key:@"Orders"]];
    
    
    return location;
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