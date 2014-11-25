//
//  ETCheckinInfo.h
//  enoa
//
//  Created by admin on 14-11-24.
//  Copyright (c) 2014年 etourer. All rights reserved.
//

#ifndef enoa_ETCheckinInfo_h
#define enoa_ETCheckinInfo_h

#import "ETContactor.h"

#import <Foundation/Foundation.h>

@interface ETCheckinInfo : NSObject
{
    NSString *OptionCode;
    NSString *OptionName;
    NSString *Time;
    NSInteger Pax;
    
    ETContactor *Contactor;
    
}

@end

#endif
