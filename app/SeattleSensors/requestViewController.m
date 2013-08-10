//
//  requestViewController.m
//  SeattleSensors
//
//  Created by Michael Reininger on 7/12/13.
//  Copyright (c) 2013 WINLAB. All rights reserved.
//

#import "requestViewController.h"
#import "NodeConnection.h"
#import "MenuViewController.h"
#import "MapViewController.h"
@interface requestViewController ()

@end

@implementation requestViewController
@synthesize output, sensorType, parameters;
-(IBAction)request:(id)sender{
    /*
     
     1. Tell my vessel to look up in the table who has the requested sensor.
     2. Tell my vessel to contact the vessel I want and request it for my sensor.
     3. Tell my vessel to send the tmp.txt file over to the iPhone.
     4. Output tmp.txt to the output label.
     
     */
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *defIP = [userDefaults objectForKey:@"DefaultNodeIP"];
    NSLog(@"DefIP: %@", defIP);
    NodeConnection *nc = [[NodeConnection alloc] init];
    [nc newConnection:defIP];
    [nc sendRawData:[NSString stringWithFormat:@"<iWant><sensor>%@</sensor><parameters>%@</parameters></iWant>", sensorType.text, parameters.text]];
    //[nc sendRawData:[NSString stringWithFormat:@"TCPTest"]];
    NSLog(@"Output: %@", [nc receiveData]);
    output.text = [nc receiveData];
    
}

-(IBAction)back{
    MenuViewController *mvc = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    [self presentViewController:mvc animated:YES completion:NULL];
    
    
}
-(IBAction)map:(id)sender{
    MapViewController *mvc = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
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
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self view] endEditing:YES];
}
@end
