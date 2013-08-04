//
//  MenuViewController.m
//  SeattleSensors
//
//  Created by Michael Reininger on 7/12/13.
//  Copyright (c) 2013 WINLAB. All rights reserved.
//

#import "MenuViewController.h"
#import "submitViewController.h"
#import "requestViewController.h"
@interface MenuViewController ()

@end

@implementation MenuViewController
-(IBAction)submit{
    submitViewController *svc = [[submitViewController alloc] initWithNibName:@"submitViewController" bundle:nil];
    [self presentViewController:svc animated:YES completion:NULL];
    
    
}
-(IBAction)request{
    requestViewController *rvc = [[requestViewController alloc] initWithNibName:@"requestViewController" bundle:nil];
    [self presentViewController:rvc animated:YES completion:NULL];
    
    
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

@end
