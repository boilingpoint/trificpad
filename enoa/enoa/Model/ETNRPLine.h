//
//  ETNRPLine.h
//  enoa
//
//  Created by admin on 14-11-7.
//  Copyright (c) 2014年 etourer. All rights reserved.
//

#import "ETBase.h"
#import "ETPriceType.h"
#import "ETLine.h"
#import <Foundation/Foundation.h>

@interface ETNRPLine : ETLine
{
    //NSString *OptionCode;
    //NSString *OptionName;
    //NSString *Driver;
    //NSString *Vh;
    NSString *startTime;
    NSString *endTime;
    
}

@property NSString *StartTime;
@property NSString *EndTime;


-(void)init;
-(NSArray *)getNRPLinesByDate:(NSString *)date ByOwner:(NSInteger) owner;

@end

