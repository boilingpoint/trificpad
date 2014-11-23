//
//  ETUser.m
//  enoa
//
//  Created by admin on 14-10-22.
//  Copyright (c) 2014年 etourer. All rights reserved.
//


#import "ETUser.h"
#import "ASIHTTPRequest.h"
#import "ETAuthorization.h"
#import "Jastor.h"

@implementation ETUser

-(void)init
{
    [super init];
    loginUrl = [apiUrl stringByAppendingString:@"login"];
    
}

-(ETUser *)getUserByUserName:(NSString *)username Password:(NSString *)password
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@?password=%@",loginUrl,[username stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], password]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSArray arrayWithObjects: password, nil],
                            @"password",
                            [NSArray arrayWithObjects:username, nil],
                            @"id",
                            nil];
    [request addRequestHeader:@"Authorization" value:[ETAuthorization getDigestAuthorizationWithAccesskey:accessKey WithSecretKey:secretKey WithRealm:realm WithMethod:@"GET" WithUri:@"/login/" WithParams:params WithAuth:@"auth-int"]];
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
        if(dic == nil)
        {
            return nil;
        }
        if([dic valueForKey:@"error"] != nil)
        {
            self.error = [dic valueForKey:@"message"];
        }
        else
        {
            [self transformToObjectFromDictionary:dic];
        }
        return self;
    }
    return nil;
}

-(ETUser *)transformToObjectFromDictionary:(NSDictionary *)dic
{
    self.access_token = [dic valueForKey:@"access_token"];
    self.expire_in = [dic valueForKey:@"expire_in"];
    self.merchant_code = [dic valueForKey:@"merchant_code"];
    
    return self;
}

@end