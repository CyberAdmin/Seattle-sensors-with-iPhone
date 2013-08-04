//
//  SensorPickerViewController.m
//  SeattleSensors
//
//  Created by Michael Reininger on 7/12/13.
//  Copyright (c) 2013 WINLAB. All rights reserved.
//

#import "SensorPickerViewController.h"
#import "MenuViewController.h"
@interface SensorPickerViewController ()

@end

@implementation SensorPickerViewController
@synthesize sensorType;
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
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *sType = [userDefaults objectForKey:@"SensorType"];
    NSLog(@"sType: %@", sType);
    if(sType == nil || [sType isEqualToString:@""]){
        
        sensorType.text = @"";
    }else{
        sensorType.text = sType;
    }

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)next:(id)sender{
    NSUserDefaults *nodeIPDefault = [NSUserDefaults standardUserDefaults];
    [nodeIPDefault setObject:sensorType.text forKey:@"SensorType"];
    //Upload this to your node.
    MenuViewController *mvc = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    [self presentViewController:mvc animated:YES completion:NULL];
    
}
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self view] endEditing:YES];
}
@end
