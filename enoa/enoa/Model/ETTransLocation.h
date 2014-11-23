//
//  ETTransLocation.h
//  enoa
//
//  Created by admin on 14-11-7.
//  Copyright (c) 2014年 etourer. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "ETBase.h"

@interface ETTransLocation : ETBase
{
    NSString *Time;
    NSString *Location;
    NSString *Pax;
    NSString *Geo;
}
-(void)init;

@end
