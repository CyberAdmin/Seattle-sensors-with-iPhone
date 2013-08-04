//
//  ViewController.h
//  SeattleSensors
//
//  Created by Michael Reininger on 7/1/13.
//  Copyright (c) 2013 WINLAB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    
    IBOutlet UITextField *nodeIP;
}
@property(nonatomic, retain)IBOutlet UITextField *nodeIP;
-(IBAction)next;
-(IBAction)submit:(id)sender;
@end
