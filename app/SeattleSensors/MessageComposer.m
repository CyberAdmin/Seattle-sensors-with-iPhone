//
//  MessageComposer.m
//  SeattleSensors
//
//  Created by Michael Reininger on 6/23/13.
//  Copyright (c) 2013 WINLAB. All rights reserved.
//

#import "MessageComposer.h"
#import "BatteryLevel.h"

@implementation MessageComposer
@synthesize locationManager;

-(NSString *)GetUUID
{
    NSString *name = [[UIDevice currentDevice] name];
    return name;
    
    
}
-(NSString *)message:(NSString *)sensorType value:(NSString *)val{
    NSString *UUID = [self GetUUID];
    NSLog(@"%@", UUID);
    //GET LAT AND LONG
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
    CLLocation *location = [locationManager location];
    // Configure the new event with information from the location
    CLLocationCoordinate2D coordinate = [location coordinate];
    NSString *latitude = [NSString stringWithFormat:@"%f", coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f", coordinate.longitude];
    NSLog(@"dLatitude : %@", latitude);
    NSLog(@"dLongitude : %@",longitude);
    //GET TIMESTAMP
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"hh:mm:ss";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSString *time = [dateFormatter stringFromDate:now];
    NSLog(@"The Current Time is %@",[dateFormatter stringFromDate:now]);
    //GET BATTERY LEVEL
    BatteryLevel *b = [[BatteryLevel alloc] init];
    float batLevel = [b batteryLevel]*100;

    NSString *encoded = [self smlMaker:UUID lat:latitude lon:longitude bat:batLevel time:time sensor:sensorType val:val];
    NSLog(@"Encoded SML: %@", encoded);
    return encoded;
    

}
-(NSString *)smlMaker:(NSString *)UUID lat:(NSString *)latitude lon:(NSString *)longitude bat:(float)batLevel time:(NSString *)timeStamp sensor:(NSString *)sensorType val:(NSString *)value{
    
    
    NSString *header = [NSString stringWithFormat:@"<?xml version='1.0' encoding='UTF-8'?><sml:SensorML xmlns:sml='http://www.opengis.net/sensorML/1.0.1' xmlns:swe='http://www.opengis.net/swe/1.0.1' xmlns:gml='http://www.opengis.net/gml' xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xlink='http://www.w3.org/1999/xlink' xsi:schemaLocation='http://www.opengis.net/sensorML/1.0.1 http://schemas.opengis.net/sensorML/1.0.1/sensorML.xsd' version='1.0'>"];
    
    
       
    NSString *encoded = [NSString stringWithFormat:@"<sml:member><sml:components><sml:ComponentList><swe:field name='deviceName'>%@</swe:field name='deviceName'><swe:field name='latitude'>%@</swe:field name='latitude'><swe:field name='longitude'>%@</swe:field name='longitude'><swe:field name='batteryLevel'>%f</swe:field name='batteryLevel'><swe:field name='timeStamp'>%@</swe:field name='timeStamp'><swe:field name='sensorType'>%@</swe:field name='sensorType'><swe:field name='sensorValue'>%@</swe:field name='sensorValue'></sml:ComponentList></sml:components></sml:member>", UUID, latitude, longitude, batLevel,timeStamp, sensorType, value];
    
    return [NSString stringWithFormat:@"%@%@", header, encoded];
    
    
}
@end
