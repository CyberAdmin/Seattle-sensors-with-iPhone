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
    
}
@property (nonatomic, retain)UIPickerView *makePickerView;
-(void)parseModels:(NSString *)model;


@end
