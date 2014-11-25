//
//  ETBase.h
//  TicketChecker
//
//  Created by admin on 13-11-5.
//  Copyright (c) 2013年 etourer. All rights reserved.
//

#import "ASIHTTPRequest.h"
#import "ETAuthorization.h"
#import "ETDictionary.h"
#import <Foundation/Foundation.h>

@interface ETBase : NSObject<NSCoding>
{
    NSString *apiUrl;
    NSString *accessKey;
    NSString *secretKey;
    NSString *realm;
}
-(void)init;
-(NSHTTPURLResponse *)request:(NSString *)action withParameters:(NSArray *)parameters;
-(NSString *)trimString:(NSString *)str;

+(NSString *)getStringFromDic:(NSDictionary *)dic  Key:(NSString *)key;
+(NSInteger)getIntegerFromDic:(NSDictionary *)dic  Key:(NSString *)key;
+(double)getDoubleFromDic:(NSDictionary *)dic  Key:(NSString *)key;
+(NSDictionary *)getDicFromDic:(NSDictionary *)dic  Key:(NSString *)key;


+(ETBase *)transformToObjectFromDictionary:(NSDictionary *)dic;
+(NSArray *)transformToObjectArrayFromDictionary:(NSDictionary *)dic;

+(NSString *)round:(double)value;
@end
