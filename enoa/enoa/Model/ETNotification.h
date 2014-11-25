//
//  ETNotification.h
//  enoa
//
//  Created by admin on 14-11-24.
//  Copyright (c) 2014年 etourer. All rights reserved.
//

#ifndef enoa_ETNotification_h
#define enoa_ETNotification_h

#import <Foundation/Foundation.h>

typedef enum {
    kNewLine,
    kRemovedLine,
    kAddGuestLine
} NotificationState;

@interface ETNotification : NSObject
{
    NSString *Title;
    NSString *Description;
    NSString *Date;
    NotificationState *State;
    NSString *RefId;
}

@end

#endif
