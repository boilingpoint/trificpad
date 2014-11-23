//
//  ETGuest.h
//  enoa
//
//  Created by admin on 14-11-7.
//  Copyright (c) 2014年 etourer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ETBase.h"

@interface ETGuest : ETBase
{
    NSString *Name;
    NSString *Pax;
    NSString *PriceType;
    NSString *Conf;
    NSString *Note;
}
-(void)init;

@end

