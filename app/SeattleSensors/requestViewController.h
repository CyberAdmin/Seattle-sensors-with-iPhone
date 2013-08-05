//
//  requestViewController.h
//  SeattleSensors
//
//  Created by Michael Reininger on 7/12/13.
//  Copyright (c) 2013 WINLAB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface requestViewController : UIViewController{
    IBOutlet UILabel *output;
    IBOutlet UITextField *sensorType;
    IBOutlet UITextField *parameters;
    
}
@property(nonatomic,retain)IBOutlet UILabel *output;
@property(nonatomic,retain)IBOutlet UITextField *sensorType;
@property(nonatomic,retain)IBOutlet UITextField *parameters;
-(IBAction)back;
-(IBAction)request:(id)sender;
@end
