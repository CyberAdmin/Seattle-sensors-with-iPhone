//
//  BatteryLevel.m
//  SeattleSensors
//
//  Created by Michael Reininger on 6/24/13.
//  Copyright (c) 2013 WINLAB. All rights reserved.
//

#import "BatteryLevel.h"

@implementation BatteryLevel
-(float)batteryLevel{
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    
    return [[UIDevice currentDevice] batteryLevel];
}
@end
