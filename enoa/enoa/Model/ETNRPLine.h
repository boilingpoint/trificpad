//
//  ETNRPLine.h
//  enoa
//
//  Created by admin on 14-11-7.
//  Copyright (c) 2014年 etourer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ETBase.h"

@interface ETNRPLine : ETBase
{
    NSString *OptionCode;
    NSString *OptionName;
    NSString *Driver;
    NSString *Vh;
    NSString *StartTime;
    NSString *EndTime;
}
-(void)init;
-(NSArray *)getNRPLinesByDate:(NSString *)date ByOwner:(NSInteger) owner;

@end

