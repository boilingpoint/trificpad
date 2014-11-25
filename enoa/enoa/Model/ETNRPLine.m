//
//  ETNRPLine.m
//  enoa
//
//  Created by admin on 14-11-21.
//  Copyright (c) 2014年 etourer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ETNRPLine.h"


@implementation ETNRPLine


-(void)init
{
}

-(NSArray *)getNRPLinesByDate:(NSString *)date ByOwner:(NSInteger) owner
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for(int i=0;i<10;i++)
    {
        ETNRPLine *line = [ETNRPLine alloc];
        line.OptionCode = [NSString stringWithFormat:@"%@ %d", @"NOptionCode", i ];
        line.OptionName = [NSString stringWithFormat:@"%@ %d", @"NOptionName", i ];
        line.Driver = [NSString stringWithFormat:@"%@ %d", @"N FirstName LastName", i ];
        line.Vh = [NSString stringWithFormat:@"%@ %d", @"Vh", i ];
        //line.Pax = i;
        line.StartTime = [NSString stringWithFormat:@"%d/11/2014", i ];
        line.EndTime = [NSString stringWithFormat:@"%d/11/2014", i ];
       
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
        
        
        return [ETNRPLine transformToObjectArrayFromDictionary:dic];
    }
    return nil;
}


+(ETBase *)transformToObjectFromDictionary:(NSDictionary *)dic
{
    ETNRPLine *line = [ETNRPLine alloc];
    [line init];
    line.OptionCode = [ETBase getStringFromDic:dic Key:@"OptionCode"];
    line.OptionName = [ETBase  getStringFromDic:dic Key:@"OptionName"];
    line.Driver = [ETBase  getStringFromDic:dic Key:@"Driver"];
    line.Vh = [ETBase  getStringFromDic:dic Key:@"Vh"];
    //line.Pax = [ETBase  getNumberFromDic:dic Key:@"Pax"];
    line.StartTime = [ETBase  getStringFromDic:dic Key:@"StartTime"];
    line.EndTime = [ETBase  getStringFromDic:dic Key:@"EndTime"];
    
    
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
@end