//
//  ETPriceType.h
//  enoa
//
//  Created by admin on 14-11-24.
//  Copyright (c) 2014年 etourer. All rights reserved.
//

#ifndef enoa_ETPriceType_h
#define enoa_ETPriceType_h

#import "ETBase.h"
#import <Foundation/Foundation.h>

@interface ETPriceType : ETBase
{
    NSString *title;
    NSInteger num;
}

@property NSString *Title;
@property NSInteger Num;

@end

#endif
