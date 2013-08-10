//
//  submitViewController.m
//  SeattleSensors
//
//  Created by Michael Reininger on 7/12/13.
//  Copyright (c) 2013 WINLAB. All rights reserved.
//

#import "submitViewController.h"
#import "MenuViewController.h"
#import "NodeConnection.h"
#import "MessageComposer.h"
#import "FLLogging.h"
#import "FLECUSensor.h"
#import "ModelViewController.h"
@interface submitViewController ()

@end

@implementation submitViewController
@synthesize sensorLabel, recording;
@synthesize statusLabel;
@synthesize scanToolNameLabel;
@synthesize rpmLabel;
@synthesize speedLabel, milesPerGallon, recordButton, recordIcon, stopButton, stopIcon;
-(IBAction)record{
    recordIcon.hidden = YES;
    recordButton.hidden = YES;
    stopIcon.hidden = NO;
    stopButton.hidden = NO;
    accel = [UIAccelerometer sharedAccelerometer];
    accel.updateInterval = 0.05f;
    accel.delegate = self;
    recording.hidden = NO;
    [self scan];
    
}
-(IBAction)stop{
    stopIcon.hidden = YES;
    stopButton.hidden = YES;
    recordButton.hidden = NO;
    recordIcon.hidden = NO;
    //[self dismissModalViewControllerAnimated:YES];
    accel.delegate = nil;
    recording.hidden = YES;
    [self stopScan];


    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSString *obddata = [userD objectForKey:@"OBDData"];
    if(obddata == nil || [obddata isEqualToString:@""]){
        NSLog(@"Nothing in here...");
    }else{
        [self pushToSeattle];
        [userD setObject:@"" forKey:@"OBDData"];
        [userD synchronize];

    }


}
-(IBAction)back{
    MenuViewController *mvc = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    [self presentViewController:mvc animated:YES completion:NULL];
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    recording.hidden = YES;
    stopIcon.hidden = YES;
    stopButton.hidden = YES;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *sType = [userDefaults objectForKey:@"SensorType"];
    NSLog(@"sType: %@", sType);
    sensorLabel.text = [NSString stringWithFormat:@"%@", sType];
    
    // Do any additional setup after loading the view from its nib.
}
- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    //NSString *data = [NSString stringWithFormat:@"(%.02f, %.02f, %.02f)", acceleration.x, acceleration.y, acceleration.z];
    //NSLog(@"(%.02f, %.02f, %.02f)", acceleration.x, acceleration.y, acceleration.z);
    //NSLog(@"%.02f", acceleration.y);
    if(acceleration.y < -1.5){
        NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"ding" ofType:@"mp3"];
        
        NSError *error;
        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:soundFilePath] error:&error];
        if (audioPlayer == nil)
            NSLog(@"%@",[error description]);
        else
            [audioPlayer play];

        yAxis = acceleration.y;
        accel.delegate = nil;
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *defIP = [userDefaults objectForKey:@"DefaultNodeIP"];
        NSLog(@"DefIP: %@", defIP);
        NSUserDefaults *userDefaults2 = [NSUserDefaults standardUserDefaults];
        NSString *sType = [userDefaults2 objectForKey:@"SensorType"];
        NSLog(@"sType: %@", sType);
        ModelViewController *mvc = [[ModelViewController alloc] init];
        NSUserDefaults *brandDef = [NSUserDefaults standardUserDefaults];
        NSString *brand = [brandDef objectForKey:@"Brand"];
        NSUserDefaults *modelDef = [NSUserDefaults standardUserDefaults];
        NSString *model = [modelDef objectForKey:@"Model"];

        MessageComposer *mc = [[MessageComposer alloc] init];
        NodeConnection *nc = [[NodeConnection alloc] init];
        [nc newConnection:[NSString stringWithFormat:@"%@", defIP]];
        //[nc sendRawData:[mc message:sType value:[NSString stringWithFormat:@"%f", yAxis]]];
        [nc sendRawData:[mc message:[NSString stringWithFormat:@"%@:%@-%@", brand, model, sType] value:[NSString stringWithFormat:@"%f", yAxis]]];

    }
    //slider.value = acceleration.x;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark ScanToolDelegate Methods

- (void)scanDidStart:(FLScanTool*)scanTool {
	FLINFO(@"STARTED SCAN")
}

- (void)scanDidPause:(FLScanTool*)scanTool {
	FLINFO(@"PAUSED SCAN")
}

- (void)scanDidCancel:(FLScanTool*)scanTool {
	FLINFO(@"CANCELLED SCAN")
}

- (void)scanToolDidConnect:(FLScanTool*)scanTool {
	FLINFO(@"SCANTOOL CONNECTED")
}

- (void)scanToolDidDisconnect:(FLScanTool*)scanTool {
	FLINFO(@"SCANTOOL DISCONNECTED")
}


- (void)scanToolWillSleep:(FLScanTool*)scanTool {
	FLINFO(@"SCANTOOL SLEEP")
}

- (void)scanToolDidFailToInitialize:(FLScanTool*)scanTool {
	FLINFO(@"SCANTOOL INITIALIZATION FAILURE")
	FLDEBUG(@"scanTool.scanToolState: %u", scanTool.scanToolState)
	FLDEBUG(@"scanTool.supportedSensors count: %d", [scanTool.supportedSensors count])
}


- (void)scanToolDidInitialize:(FLScanTool*)scanTool {
	FLINFO(@"SCANTOOL INITIALIZATION COMPLETE")
	FLDEBUG(@"scanTool.scanToolState: %08X", scanTool.scanToolState)
	FLDEBUG(@"scanTool.supportedSensors count: %d", [scanTool.supportedSensors count])
	
	statusLabel.text			= @"Scanning...";
	
	[_scanTool setSensorScanTargets:[NSArray arrayWithObjects:
									 [NSNumber numberWithInt:0x0C], // Engine RPM
									 [NSNumber numberWithInt:0x0D], // Vehicle Speed
                                     [NSNumber numberWithInt:0x2F], // Vehicle Fuel Level
                                     [NSNumber numberWithInt:0x11], // Vehicle Throttle Position
                                     [NSNumber numberWithInt:0x0A], // Vehicle Fuel Pressure
									 [NSNumber numberWithInt:0x010],// Mass Air Flow Rate (MAF)
                                     nil]];
	
	scanToolNameLabel.text	= _scanTool.scanToolName;
}


- (void)scanTool:(FLScanTool*)scanTool didSendCommand:(FLScanToolCommand*)command {
	FLINFO(@"DID SEND COMMAND")
}


- (void)scanTool:(FLScanTool*)scanTool didReceiveResponse:(NSArray*)responses {
	FLINFO(@"DID RECEIVE RESPONSE")
	
	FLECUSensor* sensor	=	nil;
	
	for (FLScanToolResponse* response in responses) {
		
		sensor			= [FLECUSensor sensorForPID:response.pid];
		[sensor setCurrentResponse:response];
		if (response.pid == 0x0C) {
			// Update RPM Display
			rpmLabel.text	= [NSString stringWithFormat:@"%@ %@", [sensor valueStringForMeasurement1:NO], [sensor imperialUnitString]];
            //[self pushToSeattle:@"RPM" value:[NSString stringWithFormat:@"%@ %@", [sensor valueStringForMeasurement1:NO], [sensor imperialUnitString]]];
			[rpmLabel setNeedsDisplay];
		}
        else if(response.pid == 0x2F){
            NSLog(@"Fuel level at: %@",[NSString stringWithFormat:@"%@ %@", [sensor valueStringForMeasurement1:NO], [sensor imperialUnitString]] );
            //[self pushToSeattle:@"Fuel Level" value:[NSString stringWithFormat:@"%@ %@", [sensor valueStringForMeasurement1:NO], [sensor imperialUnitString]]];
           
        }
        else if(response.pid == 0x0A){
            NSLog(@"Fuel pressure: %@", [NSString stringWithFormat:@"%@ %@", [sensor valueStringForMeasurement1:NO], [sensor imperialUnitString]]);
            //[self pushToSeattle:@"Fuel Pressure" value:[NSString stringWithFormat:@"%@ %@", [sensor valueStringForMeasurement1:NO], [sensor imperialUnitString]]];
            
            
        }
        else if(response.pid == 0x11){
            
            NSLog(@"Throttle Position: %@", [NSString stringWithFormat:@"%@ %@", [sensor valueStringForMeasurement1:NO], [sensor imperialUnitString]]);
            //[self pushToSeattle:@"TPS" value:[NSString stringWithFormat:@"%@ %@", [sensor valueStringForMeasurement1:NO], [sensor imperialUnitString]]];
        }
		else if(response.pid == 0x0D) {
			// Update Speed Display
			speedLabel.text	= [NSString stringWithFormat:@"%@ %@", [sensor valueStringForMeasurement1:NO], [sensor imperialUnitString]];
            //[self pushToSeattle:@"Speed" value:[NSString stringWithFormat:@"%@ %@", [sensor valueStringForMeasurement1:NO], [sensor imperialUnitString]]];
            v1 = [[NSString stringWithFormat:@"%@ %@", [sensor valueStringForMeasurement1:NO], [sensor imperialUnitString]] floatValue];
			[speedLabel setNeedsDisplay];
        }
        else if(response.pid == 0x10){
            //Update MAF display
            m1 = [[NSString stringWithFormat:@"%@ %@", [sensor valueStringForMeasurement1:NO], [sensor imperialUnitString]] floatValue];
            NSLog(@"MAF: %f", m1);
        }
		else{
        
        }
        [self calcMPG];
	}
	
}
-(void)calcMPG{
    float vss = v1;
    float maf = m1;
    float M = 14.7*6.17*4.54*vss;
    float P = maf/100;
    float G = 3600*P;
    float MPG = (M/G);
    float MPGFinal = MPG/10;
    if(MPGFinal != MPGFinal){
        NSLog(@"NaN error.");
        milesPerGallon.text = @"MPG: 0";
    }else if(MPGFinal == INFINITY){
        NSLog(@"MPG is infinite!!!");
        milesPerGallon.text = @"MPG: 99.9";
    }else{
        milesPerGallon.text = [NSString stringWithFormat:@"MPG: %f", MPGFinal];
        NSLog(@"MPG: %@",[NSString stringWithFormat:@"MPG: %f", MPGFinal] );
        [milesPerGallon setNeedsDisplay];
        [self writeOBDDATA:@"FuelConsumption" value:[NSString stringWithFormat:@"%f", MPGFinal]];
    }
    
}

- (void)scanTool:(FLScanTool*)scanTool didReceiveVoltage:(NSString*)voltage {
	FLTRACE_ENTRY
}


- (void)scanTool:(FLScanTool*)scanTool didTimeoutOnCommand:(FLScanToolCommand*)command {
	FLINFO(@"DID TIMEOUT")
}


- (void)scanTool:(FLScanTool*)scanTool didReceiveError:(NSError*)error {
	FLINFO(@"DID RECEIVE ERROR")
	FLNSERROR(error)
}
-(void)writeOBDDATA:(NSString *)sensorType value:(NSString *)val{
    /*  1. If NSUserDefaults == nil; then create a new one and save the data to that.
            a. Wait till we press stop. Then append to the file, and call [nc sendMessage]
            b. Delete NSUserDefaults.
        2. If NSUserDefaults != nil; then read what we wrote in there, and then append the newest SML data. Repeat for every PID we recieve.
            a. Wait till we press stop. Then read the file, and call [nc sendMessage]
            b. Delete NSUserDefaults when stop pressed (see -(IBAction)stop)
     */
    MessageComposer *mc = [[MessageComposer alloc] init];
    NSUserDefaults *brandDef = [NSUserDefaults standardUserDefaults];
    NSString *brand = [brandDef objectForKey:@"Brand"];
    NSUserDefaults *modelDef = [NSUserDefaults standardUserDefaults];
    NSString *model = [modelDef objectForKey:@"Model"];

    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSString *obddata = [userD objectForKey:@"OBDData"];
    //NSLog(@"OBDData at pushToSeattle: %@", obddata);
    if(obddata == nil || [obddata isEqualToString:@""]){
        NSLog(@"{OBDDATA} IS NIL. Now creating one...");
        NSLog(@"{OBDDATA} writing to file: %@", [mc message:[NSString stringWithFormat:@"%@:%@-%@", brand, model, sensorType] value:val]);
        [userD setObject:[mc message:[NSString stringWithFormat:@"%@:%@-%@", brand, model, sensorType] value:val] forKey:@"OBDData"];
        [userD synchronize];
        NSLog(@"{OBDDATA} completed writing to NSUserDefault for key OBDData.");
    }else{
        NSLog(@"{OBDDATA} has text. We will append to it now.");
        [userD setObject:[obddata stringByAppendingString:[mc message:[NSString stringWithFormat:@"%@:%@-%@", brand, model, sensorType] value:val]] forKey:@"OBDData"];
        [userD synchronize];
        NSLog(@"{OBDDATA} completed appending to file.");
    }

    
}
-(void)pushToSeattle{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *defIP = [userDefaults objectForKey:@"DefaultNodeIP"];
    NSLog(@"DefIP: %@", defIP);
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSString *obddata = [userD objectForKey:@"OBDData"];
    //NSLog(@"{pushToSeattle} obddata: %@", obddata);
    NodeConnection *nc = [[NodeConnection alloc] init];
    [nc newConnection:[NSString stringWithFormat:@"%@", defIP]];
    [nc sendRawData:obddata];
    
}
#pragma mark -
#pragma mark Private Methods

- (void) scan {
	
	statusLabel.text			= @"Initializing...";
	

	_scanTool					= [FLScanTool scanToolForDeviceType:kScanToolDeviceTypeELM327];
	
	_scanTool.useLocation		= YES;
	_scanTool.delegate			= self;
	
	if(_scanTool.isWifiScanTool ) {
		// These are the settings for the PLX Kiwi WiFI, your Scan Tool may
		// require different.
		[_scanTool setHost:@"192.168.0.10"];
		[_scanTool setPort:35000];
	}
	
	[_scanTool startScan];
}

- (void) stopScan {
	if(_scanTool.isWifiScanTool) {
		[_scanTool cancelScan];
	}
	
	_scanTool.sensorScanTargets		= nil;
	_scanTool.delegate				= nil;
}


- (void)viewDidUnload {
    [self setStopIcon:nil];
    [self setRecordIcon:nil];
    [self setRecordButton:nil];
    [self setRecordButton:nil];
    [self setStopButton:nil];
    [super viewDidUnload];
}
@end
