//
//  ETTransLocation.h
//  enoa
//
//  Created by admin on 14-11-7.
//  Copyright (c) 2014年 etourer. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "ETBase.h"
#import "ETOrderInfo.h"

@interface ETTransLocation : ETBase
{
    NSString *getLocationsUrl;
    
    NSString *merchantCode;
    NSString *token;
    
    NSString *time;
    NSString *location;
    NSInteger *pax;
    NSString *geo;
    NSMutableArray *orderArray;
}

@property NSString *Time;
@property NSString *Location;
@property NSInteger *Pax;
@property NSString *Geo;
@property NSMutableArray *OrderArray;

-(void)init;

-(NSArray *)getTransLocationArrayByLine:(NSString *)code AndDate:(NSString *)date;

@end
