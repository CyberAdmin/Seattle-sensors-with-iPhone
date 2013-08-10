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
    bool                stopped;

}
@property (nonatomic, retain) IBOutlet UIImageView *recordIcon;
@property (nonatomic, retain) IBOutlet UIImageView *stopIcon;
@property (nonatomic, retain) IBOutlet UILabel* statusLabel;
@property (nonatomic, retain) IBOutlet UILabel* scanToolNameLabel;
@property (nonatomic, retain) IBOutlet UILabel* rpmLabel;
@property (nonatomic, retain) IBOutlet UILabel* speedLabel;
@property (nonatomic, retain) IBOutlet UILabel* milesPerGallon;
@property (nonatomic, retain) IBOutlet UIButton *recordButton;
@property (nonatomic, retain) IBOutlet UIButton *stopButton;
@property(nonatomic, retain)IBOutlet UILabel *sensorLabel;
@property(nonatomic, retain)IBOutlet UILabel *recording;
@property (nonatomic, retain) CLLocationManager *locationManager;
- (void) scan;
- (void) stopScan;
-(IBAction)record;
-(IBAction)stop;
-(IBAction)back;
-(void)writeOBDDATA:(NSString *)sensorType value:(NSString *)val;
-(void)calcMPG:(NSString *)VSS andMAF:(NSString *)MAF;
-(void)pushToSeattle;
@end
