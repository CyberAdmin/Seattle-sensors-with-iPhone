//
//  ModelViewController.h
//  SeattleSensors
//
//  Created by Michael Reininger on 8/5/13.
//  Copyright (c) 2013 WINLAB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBJson.h"

@interface ModelViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>{
    NSArray *carPickerArray;
    NSDictionary *x;
    NSString *model;
    NSString *brand;
    NSString *m;
    NSString *b;
    
}
@property (nonatomic, retain)UIPickerView *makePickerView;

-(void)parseModels:(NSString *)model;
-(IBAction)next:(id)sender;
-(NSString *)brand;
-(NSString *)model;
-(void)setBrand:(NSString *)val;
-(void)setModel:(NSString *)val;
@end
