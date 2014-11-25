//
//  ETTransportation.h
//  enoa
//
//  Created by admin on 14-11-7.
//  Copyright (c) 2014年 etourer. All rights reserved.
//


#import "ETBase.h"
#import "ETPriceType.h"
#import "ETLine.h"
#import <Foundation/Foundation.h>
#define Me 0
#define All 1

@interface ETRPLine : ETLine
{
    //NSString *merchantCode;
    //NSString *token;
    
    //NSString *OptionCode;
    //NSString *OptionName;
    //NSString *Driver;
    //NSString *Vh;
    NSInteger pax;
    NSString *firstTime;
    NSString *firstLocation;
    NSString *date;
    NSString *voucherId;
    NSString *note;
    
    NSMutableArray *priceTypeArray;
}
@property NSInteger *Pax;
@property NSString *FirstTime;
@property NSString *FirstLocation;
@property NSString *Date;
@property NSString *VoucherId;
@property NSString *Note;

@property NSMutableArray *PriceTypeArray;

-(void)init;
-(NSArray *)getRPLinesByDate:(NSString *)date ByOwner:(NSInteger) owner;
-(ETRPLine *)getRPLineByCode:(NSString *)code;

@end
