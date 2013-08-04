//
//  GetCarrierName.m
//  SeattleSensors
//
//  Created by Michael Reininger on 6/24/13.
//  Copyright (c) 2013 WINLAB. All rights reserved.
//

#import "GetCarrierName.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
@implementation GetCarrierName
-(NSString *)carrier{
    
    CTTelephonyNetworkInfo *netinfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier1 = [netinfo subscriberCellularProvider];
    NSString *c = [netInfo 
}
@end
