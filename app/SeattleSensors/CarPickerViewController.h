//
//  CarPickerViewController.h
//  SeattleSensors
//
//  Created by Michael Reininger on 8/5/13.
//  Copyright (c) 2013 WINLAB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBJson.h"
@interface CarPickerViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>{
    NSArray *carPickerArray;
    NSString *selectedCar;
}
@property (nonatomic, retain)UIPickerView *makePickerView;
-(void)parseModels;
-(IBAction)next:(id)sender;
@end
