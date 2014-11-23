//
//  ETUser.h
//  enoa
//
//  Created by admin on 14-10-22.
//  Copyright (c) 2014年 etourer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ETBase.h"

@interface ETUser : ETBase
{
    NSString *loginUrl;
    
    NSString *id;
    NSString *name;
    NSString *sign;
    NSString *desc;
}
@property NSString *access_token;
@property NSString *expire_in;
@property NSString *merchant_code;
@property NSString *error;

-(ETUser *)getUserByUserName:(NSString *)username Password:(NSString *)password;
-(ETUser *)transformToObjectFromDictionary:(NSDictionary *)dic;

@end