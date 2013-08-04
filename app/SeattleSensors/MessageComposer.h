//
//  MessageComposer.h
//  SeattleSensors
//
//  Created by Michael Reininger on 6/23/13.
//  Copyright (c) 2013 WINLAB. All rights reserved.
//
/*
 
        
    MICHAEL REININGER
    RUTGERS WINLAB: SUMMER 2013
    DESCRIPTION: A message composer for iPhone to communicate sensor data in an XML-like language.
    INSTRUCTIONS:
        1) Import MessageComposer.h in your project.
        2) Send RAW data to NodeConnection via with value data:
            [comp message:@"RAW" value:data]
 
    OUTPUT: Data is sent via UDP (NodeConnection) with this NSString:
            <data>
                <UID>XXYYZZ</UID>
                <lat>lat</lat>
                <long>long</long>
                <batteryLevel>bat</batteryLevel>
                <stamp>timestamp</stamp>
                <sensor>EMF:HUMIDITY:CO2…</sensor>
                <value>asdfghjkl</value>
            </data>
    
        UID: A unique identifier (iPhone's Name {Settings->General->About})
        LAT: User's latitude.
        LONG: User's longitude.
        BATTERYLEVEL: User's battery level.
        STAMP: Current timestamp.
        SENSOR: Type of sensor.
        VALUE: The value of the sensor.
 
 
 
 
 */
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface MessageComposer : NSObject <CLLocationManagerDelegate>{
    NSString *UID;
    CLLocationManager *locationManager;

}
@property (nonatomic, retain) CLLocationManager *locationManager;

-(NSString *)message:(NSString *)sensorType value:(NSString *)val;
-(NSString *)GetUUID;
-(NSString *)smlMaker:(NSString *)UUID lat:(NSString *)latitude lon:(NSString *)longitude bat:(float)batLevel time:(NSString *)timeStamp sensor:(NSString *)sensorType val:(NSString *)value;

@end
