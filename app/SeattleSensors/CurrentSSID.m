//
//  CurrentSSID.m
//  SeattleSensors
//
//  Created by Michael Reininger on 6/24/13.
//  Copyright (c) 2013 WINLAB. All rights reserved.
//

#import "CurrentSSID.h"

@implementation CurrentSSID
- (id)fetchSSIDInfo{
    NSArray *ifs = (id)CNCopySupportedInterfaces();
    NSLog(@"%s: Supported interfaces: %@", __func__, ifs);
    id info = nil;
    for (NSString *ifnam in ifs) {
        info = (id)CNCopyCurrentNetworkInfo((CFStringRef)ifnam);
        NSLog(@"%s: %@ => %@", __func__, ifnam, info);
        if (info && [info count]) {
            break;
        }
        [info release];
    }
    [ifs release];
    return [info autorelease];
    
}
@end
