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
    for(int i=0;i<10;i++)
    {
        
        ETTransLocation *location = [ETTransLocation alloc];
        [location init];
        location.Time = [NSString stringWithFormat:@"3:%d", i];
        location.Location = [NSString stringWithFormat:@"location %d", i];
        location.Pax = i;
        location.Geo = [NSString stringWithFormat:@"Geo %d", i];;
        
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
    location.Geo = [ETBase  getStringFromDic:dic Key:@"Geo"];
    
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