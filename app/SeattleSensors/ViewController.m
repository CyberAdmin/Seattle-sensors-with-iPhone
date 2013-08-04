//
//  ViewController.m
//  SeattleSensors
//
//  Created by Michael Reininger on 7/1/13.
//  Copyright (c) 2013 WINLAB. All rights reserved.
//

#import "ViewController.h"
#import "MessageComposer.h"
#import "NodeConnection.h"
#import "SensorPickerViewController.h"
@interface ViewController ()
@end
@implementation ViewController
@synthesize nodeIP;
-(IBAction)submit:(id)sender{
/*    MessageComposer *mc = [[MessageComposer alloc] init];
    NSLog(@"MC: %@", [mc message:@"RAW" value:messageBox.text]);
    NodeConnection *nc = [[NodeConnection alloc] init];
    [nc newConnection:@"188.1.240.186"];
    [nc sendRawData:[mc message:@"RAW" value:messageBox.text]];
    //NSArray *ips = [[NSArray alloc] initWithObjects:@"188.1.240.186", @"195.251.248.181",nil];
    //[nc newConnections:ips];
    //[nc sendToIPList:[mc message:@"RAW" value:messageBox.text]];
    
    
    if([nc success]){
        NSLog(@"Message sent successfully.");
    }else{
        NSLog(@"Message failure.");
    }
    */
}
-(IBAction)next{

    NSUserDefaults *nodeIPDefault = [NSUserDefaults standardUserDefaults];
    [nodeIPDefault setObject:nodeIP.text forKey:@"DefaultNodeIP"];
    NSLog(@"AT NEXT: %@", nodeIP.text);
    SensorPickerViewController *spvc = [[SensorPickerViewController alloc] initWithNibName:@"SensorPickerViewController" bundle:nil];
    [self presentViewController:spvc animated:YES completion:NULL];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *defIP = [userDefaults objectForKey:@"DefaultNodeIP"];
    NSLog(@"DefIP: %@", defIP);
    if(defIP == nil || [defIP isEqualToString:@""]){
        
        nodeIP.text = @"";
    }else{
        nodeIP.text = defIP;
        
    }
	// Do any additional setup after loading the view, typically from a nib.
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
