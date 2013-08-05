//
//  CarPickerViewController.m
//  SeattleSensors
//
//  Created by Michael Reininger on 8/5/13.
//  Copyright (c) 2013 WINLAB. All rights reserved.
//

#import "CarPickerViewController.h"
#import "SBJson.h"
#import "ModelViewController.h"
@interface CarPickerViewController ()

@end

@implementation CarPickerViewController
@synthesize makePickerView;
-(void)parseModels{
    
    // Create new SBJSON parser object
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    
    // Prepare URL request to download statuses from Twitter
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://api.edmunds.com/v1/api/vehicle/makerepository/findall?fmt=json&api_key=q9c82ggse85fzdg4w6wssjpy"]];
    
    // Perform request and get JSON back as a NSData object
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    // Get JSON as a NSString from NSData response
    NSString *json_string = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    // parse the JSON response into an object
    // Here we're using NSArray since we're parsing an array of JSON status objects
    NSMutableDictionary *statuses = [parser objectWithString:json_string];
    if ([statuses isKindOfClass:[NSDictionary class]]){
        NSLog(@"GOOD!");
        
    }
        // treat as a dictionary, or reassign to a dictionary ivar
    else{
        NSLog(@"BAD");
    }
            // treat as an array or reassign to an array ivar.
    NSUserDefaults *makes = [NSUserDefaults standardUserDefaults];
    NSMutableArray *makeRead = [makes objectForKey:@"MAKES"];
    NSMutableArray *makeArray = [[NSMutableArray alloc] init];
    if(!makeRead){
        NSLog(@"Downloading makes...");
        NSMutableArray *make = [statuses valueForKey:@"makeHolder"];
        for (NSDictionary *x in make){
            NSLog(@"%@",[x valueForKey:@"name"]);
            [makeArray addObject:[NSString stringWithFormat:@"%@", [x valueForKey:@"name"]]];
        }
        //Cahce the makes
        NSUserDefaults *makes2 = [NSUserDefaults standardUserDefaults];
        [makes2 setObject:makeRead forKey:@"MAKES"];
        /* IMPORTANT! Without this step it won't save */
        [makes2 synchronize];
        NSLog(@"Saving complete.");
    }else{
        NSLog(@"Makes already cached.");
        NSMutableArray *make = [statuses valueForKey:@"makeHolder"];
        for (NSDictionary *x in make){
            NSLog(@"%@",[x valueForKey:@"name"]);
            [makeArray addObject:[NSString stringWithFormat:@"%@", [x valueForKey:@"name"]]];
            
        }
        
    }
    carPickerArray = [NSArray arrayWithArray:makeArray];

 
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    //One column
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    //set number of rows
    return carPickerArray.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    //set item per row
    return [carPickerArray objectAtIndex:row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component

{
    
    NSLog(@"Selected: %@", [carPickerArray objectAtIndex:row]);
    selectedCar = [NSString stringWithFormat:@"%@", [carPickerArray objectAtIndex:row]];
    
}
-(IBAction)next:(id)sender{
    ModelViewController *mvc = [[ModelViewController alloc] initWithNibName:@"ModelViewController" bundle:nil];
    [mvc parseModels:selectedCar];
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

@end
