//
//  submitViewController.h
//  SeattleSensors
//
//  Created by Michael Reininger on 7/12/13.
//  Copyright (c) 2013 WINLAB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <AVFoundation/AVFoundation.h>
#import "FLScanTool.h"
@interface submitViewController : UIViewController <UIAccelerometerDelegate, UIAlertViewDelegate, CLLocationManagerDelegate, FLScanToolDelegate>{
    IBOutlet UILabel *sensorLabel;
    UIAccelerometer *accel;
    float yAxis;
    IBOutlet UILabel *recording;
    CLLocationManager *locationManager;
    AVAudioPlayer *audioPlayer;
    FLScanTool*			_scanTool;
	float v1;
    float m1;
	
	UILabel*			statusLabel;
	UILabel*			scanToolNameLabel;
	UILabel*			rpmLabel;
	UILabel*			speedLabel;
    UILabel*            milesPerGallon;
    UILabel* fuelLevel;
    UILabel* TPS;
}

@property (nonatomic, retain) IBOutlet UILabel* statusLabel;
@property (nonatomic, retain) IBOutlet UILabel* scanToolNameLabel;
@property (nonatomic, retain) IBOutlet UILabel* rpmLabel;
@property (nonatomic, retain) IBOutlet UILabel* speedLabel;
@property (nonatomic, retain) IBOutlet UILabel* fuelLevel;
@property (nonatomic, retain) IBOutlet UILabel* TPS;
@property (nonatomic, retain) IBOutlet UILabel* milesPerGallon;

@property(nonatomic, retain)IBOutlet UILabel *sensorLabel;
@property(nonatomic, retain)IBOutlet UILabel *recording;
@property (nonatomic, retain) CLLocationManager *locationManager;
- (void) scan;
- (void) stopScan;
-(IBAction)record;
-(IBAction)stop;
-(IBAction)back;
-(void)pushToSeattle:(NSString *)sensorType value:(NSString *)val;
-(void)calcMPG:(NSString *)VSS andMAF:(NSString *)MAF;

@end
