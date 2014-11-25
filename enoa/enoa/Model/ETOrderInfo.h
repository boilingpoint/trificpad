//
//  ETOrderInfo.h
//  enoa
//
//  Created by admin on 14-11-24.
//  Copyright (c) 2014年 etourer. All rights reserved.
//

#ifndef enoa_ETOrderInfo_h
#define enoa_ETOrderInfo_h

#import "ETContactor.h"
#import "ETPriceType.h"
#import <Foundation/Foundation.h>
typedef enum
{
    kNotPaid,
    kPaid,
    kAgency,
    kNeedRefund
}OrderState;
typedef enum
{
    kWaiting,
    kPartCheckin,
    kCheckin,
    kNoshow
}CheckinState;

@interface ETOrderInfo: ETBase
{
    ETContactor *Contactor;
    NSMutableArray *PriceTypeArray;
    NSInteger Pax;
    double Price;
    OrderState OrderState;
    NSString *VoucherId;
    CheckinState CheckinState;
    NSMutableArray *TransLocationArray;
    NSMutableArray *AdditionalQuestionArray;
    NSMutableArray *AddonArray;
}

@property ETContactor *Contactor;
@property NSMutableArray *PriceTypeArray;
@property NSInteger Pax;
@property double Price;
@property OrderState OrderState;
@property NSString *VoucherId;
@property CheckinState CheckinState;
@property NSMutableArray *TransLocationArray;
@property NSMutableArray *AdditionalQuestionArray;
@property NSMutableArray *AddonArray;
@property NSString *Note;

-(void)init;

@end

#endif
