//
//  ETLine.h
//  enoa
//
//  Created by admin on 14-11-24.
//  Copyright (c) 2014年 etourer. All rights reserved.
//

#ifndef enoa_ETLine_h
#define enoa_ETLine_h

#import "ETBase.h"
#import <Foundation/Foundation.h>


@interface ETLine : ETBase
{
    NSString *getLinesUrl;
    NSString *getLineUrl;
    
    NSString *merchantCode;
    NSString *token;
    
    NSString *optionCode;
    NSString *optionName;
    NSString *driver;
    NSString *vh;
    
}

@property NSString *OptionCode;
@property NSString *OptionName;
@property NSString *Driver;
@property NSString *Vh;


//type:0 RP, 1 NRP, 2 Charter
-(NSArray *)getLinesByDate:(NSString *)date ByOwner:(NSInteger) owner ByType:(NSInteger) type;

@end

#endif
