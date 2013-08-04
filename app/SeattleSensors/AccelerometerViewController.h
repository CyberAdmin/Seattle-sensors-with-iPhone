//
//  AccelerometerViewController.h
//  SeattleSensors
//
//  Created by Michael Reininger on 6/24/13.
//  Copyright (c) 2013 WINLAB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccelerometerViewController : UIViewController <UIAccelerometerDelegate>{
    IBOutlet UISlider *slider;
    UIAccelerometer *accel;
}
-(IBAction)stop1:(id)sender;
-(void)stop;
@end
