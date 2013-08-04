//
//  SensorPickerViewController.h
//  SeattleSensors
//
//  Created by Michael Reininger on 7/12/13.
//  Copyright (c) 2013 WINLAB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SensorPickerViewController : UIViewController{
    IBOutlet UITextField *sensorType;
    IBOutlet UILabel *outputLabel;
}
@property(nonatomic, retain)IBOutlet UITextField *sensorType;
@property(nonatomic, retain)IBOutlet UILabel *outputLabel;

-(IBAction)next:(id)sender;
@end
