//
//  AccelerometerViewController.m
//  SeattleSensors
//
//  Created by Michael Reininger on 6/24/13.
//  Copyright (c) 2013 WINLAB. All rights reserved.
//

#import "AccelerometerViewController.h"
#import "MessageComposer.h"
#import "NodeConnection.h"
#import "ViewController.h"
@interface AccelerometerViewController ()

@end

@implementation AccelerometerViewController

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
    accel = [UIAccelerometer sharedAccelerometer];
    accel.updateInterval = 0.05f;
    accel.delegate = self;
    
    //slider = [[UISlider alloc] initWithFrame:CGRectMake(10, 200, 300, 20)];
    //slider.minimumValue = -1;
    //slider.maximumValue = 1;
    //[self.view addSubview:slider];
    // Do any additional setup after loading the view from its nib.
}
- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    NSString *data = [NSString stringWithFormat:@"(%.02f, %.02f, %.02f)", acceleration.x, acceleration.y, acceleration.z];
    //NSLog(@"(%.02f, %.02f, %.02f)", acceleration.x, acceleration.y, acceleration.z);
    //slider.value = acceleration.x;
    //DETECT BUMP IN THE ROAD...
    MessageComposer *message = [[MessageComposer alloc] init];
    
    NodeConnection *connection = [[NodeConnection alloc] init];
    [connection newConnection:@"217.173.198.154"];
    [connection sendRawData:[message message:@"Accelerometer" value:data]];
    
}
-(IBAction)stop1:(id)sender{
    [self stop];
    
}
-(void)stop{
    [self dismissModalViewControllerAnimated:YES];
    accel.delegate = nil;

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
