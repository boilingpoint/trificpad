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
    getLinesUrl = [apiUrl stringByAppendingString:[NSString stringWithFormat:@"merchant/%@/orders",merchantCode]];
    /*
    orderListUrl = [apiUrl stringByAppendingString:[NSString stringWithFormat:@"merchant/%@/orders",merchantCode]];
    //orderDetailUrl = [apiUrl stringByAppendingString:[NSString stringWithFormat:@"merchant/%@/orders/",merchantCode]];
    orderOverviewUrl = [apiUrl stringByAppendingString:@"overview"];
    recordGuestInfoUrl = [apiUrl stringByAppendingString:[NSString stringWithFormat:@"appsnapshot/%@/snapshot",merchantCode]];
     */
}

-(NSArray *)getRPLinesByDate:(NSString *)date ByOwner:(NSInteger) owner
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for(int i=0;i<10;i++)
    {
        ETRPLine *line = [ETRPLine alloc];
        line.OptionCode = [NSString stringWithFormat:@"%@ %d", @"OptionCode", i ];
        line.OptionName = [NSString stringWithFormat:@"%@ %d", @"OptionName", i ];
        line.Driver = [NSString stringWithFormat:@"%@ %d", @"FirstName LastName", i ];
        line.Vh = [NSString stringWithFormat:@"%@ %d", @"Vh", i ];
        line.Pax = i;
        line.FirstTime = [NSString stringWithFormat:@"%d/11/2014", i ];
        line.FirstLocation = [NSString stringWithFormat:@"%@ %d", @"FirstLocation", i ];
        line.Date = [NSString stringWithFormat:@"%@ %d", @"%d/11/2014", i ];
        line.VoucherId =[NSString stringWithFormat:@"%@ %d", @"VoucherId", i ];
        line.Note = [NSString stringWithFormat:@"%@ %d", @"Note", i ];
        line.PriceTypeArray = [[NSMutableArray alloc] init];
        for(int i=0;i<3;i++)
        {
            ETPriceType *priceType = [ETPriceType alloc];
            priceType.Title = [NSString stringWithFormat:@"%@ %d", @"Title", i ];
            priceType.Num = i;
            [line.PriceTypeArray addObject:priceType];
        }
        [array addObject:line];
    }
    return array;
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@?book_date=%@",getLinesUrl,merchantCode, date]];
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
        
        
        return [ETRPLine transformToObjectArrayFromDictionary:dic];
    }
    return nil;
}

-(ETRPLine *)getRPLineByCode:(NSString *)code
{
        ETRPLine *line = [ETRPLine alloc];
        line.OptionCode = [NSString stringWithFormat:@"%@", @"OptionCode" ];
        line.OptionName = [NSString stringWithFormat:@"%@", @"OptionName"];
        line.Driver = [NSString stringWithFormat:@"%@", @"FirstName LastName"];
        line.Vh = [NSString stringWithFormat:@"%@", @"Vh" ];
        line.Pax = 6;
        line.FirstTime = [NSString stringWithFormat:@"%d/11/2014", 17 ];
        line.FirstLocation = [NSString stringWithFormat:@"%@", @"FirstLocation" ];
        line.Date = [NSString stringWithFormat:@"%d/11/2014", 17 ];
        line.VoucherId =[NSString stringWithFormat:@"%@", @"VoucherId"];
        line.Note = [NSString stringWithFormat:@"%@", @"Note" ];
        line.PriceTypeArray = [[NSMutableArray alloc] init];
        for(int i=0;i<3;i++)
        {
            ETPriceType *priceType = [ETPriceType alloc];
            priceType.Title = [NSString stringWithFormat:@"%@ %d", @"Title", i ];
            priceType.Num = i;
            [line.PriceTypeArray addObject:priceType];
        }
    
    return line;
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@?book_date=%@",getLineUrl,merchantCode, date]];
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
        
        
        return [ETRPLine transformToObjectFromDictionary:dic];
    }
    return nil;
}



+(ETBase *)transformToObjectFromDictionary:(NSDictionary *)dic
{
    ETRPLine *line = [ETRPLine alloc];
    [line init];
    line.OptionCode = [ETBase getStringFromDic:dic Key:@"OptionCode"];
    line.OptionName = [ETBase  getStringFromDic:dic Key:@"OptionName"];
    line.Driver = [ETBase  getStringFromDic:dic Key:@"Driver"];
    line.Vh = [ETBase  getStringFromDic:dic Key:@"Vh"];
    line.Pax = [ETBase  getIntegerFromDic:dic Key:@"Pax"];
    line.FirstTime = [ETBase  getStringFromDic:dic Key:@"FirstTime"];
    line.FirstLocation = [ETBase  getStringFromDic:dic Key:@"FirstLocation"];
    line.Date = [ETBase  getStringFromDic:dic Key:@"Date"];
    line.VoucherId = [ETBase  getStringFromDic:dic Key:@"VoucherId"];
    line.Note = [ETBase  getStringFromDic:dic Key:@"Note"];
    line.PriceTypeArray = [ETPriceType transformToObjectArrayFromDictionary:[ETBase getDicFromDic:dic Key:@"PriceType"]];
    
    
    return line;
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

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.OptionCode forKey:@"rplineOptionCode"];
    [aCoder encodeObject:self.OptionName forKey:@"rplineOptionName"];
    [aCoder encodeObject:self.Driver forKey:@"rplineDriver"];
    [aCoder encodeObject:self.Vh forKey:@"rplineVh"];
    [aCoder encodeObject:[NSString stringWithFormat:@"%d", self.Pax] forKey:@"rplinePax"];
    [aCoder encodeObject:self.FirstTime forKey:@"rplineFirstTime"];
    [aCoder encodeObject:self.FirstLocation forKey:@"rplineFirstLocation"];
    [aCoder encodeObject:self.Date forKey:@"rplineDate"];
    [aCoder encodeObject:self.VoucherId forKey:@"rplineVoucherId"];
    [aCoder encodeObject:self.Note forKey:@"rplineNote"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if(self)
    {
        self.OptionCode = [aDecoder decodeObjectForKey:@"rplineOptionCode"];
        self.OptionName = [aDecoder decodeObjectForKey:@"rplineOptionName"];
        self.Driver = [aDecoder decodeObjectForKey:@"rplineDriver"];
        self.Vh = [aDecoder decodeObjectForKey:@"rplineVh"];
        self.Pax = [(NSNumber *)[aDecoder decodeObjectForKey:@"rplinePax"] intValue];
        self.FirstTime = [aDecoder decodeObjectForKey:@"rplineFirstTime"];
        self.FirstLocation = [aDecoder decodeObjectForKey:@"rplineFirstLocation"];
        self.Date = [aDecoder decodeObjectForKey:@"rplineDate"];
        self.VoucherId = [aDecoder decodeObjectForKey:@"rplineVoucherId"];
        self.Note = [aDecoder decodeObjectForKey:@"rplineNote"];
    }
    return self;
}
@end