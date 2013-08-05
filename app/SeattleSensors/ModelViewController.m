//
//  ModelViewController.m
//  SeattleSensors
//
//  Created by Michael Reininger on 8/5/13.
//  Copyright (c) 2013 WINLAB. All rights reserved.
//

#import "ModelViewController.h"
#import "MenuViewController.h"
@interface ModelViewController ()

@end

@implementation ModelViewController
@synthesize makePickerView;

-(void)parseModels:(NSString *)model{
    brand = [model stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    model = [model stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    [self setBrand:brand];
    NSLog(@"Looking for: %@", model);
    // Create new SBJSON parser object
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    
    // Prepare URL request to download statuses from Twitter
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.edmunds.com/v1/api/vehicle/makerepository/findmakebyname?name=%@&fmt=json&api_key=q9c82ggse85fzdg4w6wssjpy", model]]];
    
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
    NSMutableArray *makeArray = [[NSMutableArray alloc] init];

    NSLog(@"Downloading models...");
    NSMutableArray *make = [[statuses valueForKey:@"makeHolder"] valueForKey:@"models"];
    NSString *modelsString = [[NSString alloc] init];
    for (x in make){
        NSLog(@"%@",[x valueForKey:@"name"]);
        modelsString = [NSString stringWithFormat:@"%@", [x valueForKey:@"name"]];

        [makeArray addObject:[NSString stringWithFormat:@"%@", [x valueForKey:@"name"]]];
    }
    NSLog(@"THIS IS X: %@",x);
    modelsString = [modelsString stringByReplacingOccurrencesOfString:@")" withString:@""];
    modelsString = [modelsString stringByReplacingOccurrencesOfString:@"(" withString:@""];
    modelsString = [modelsString stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    modelsString = [modelsString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSLog(@"THIS IS MODELSTRING: %@", modelsString);

    carPickerArray = [modelsString componentsSeparatedByString:@","];

    for(NSString *a in carPickerArray){
        NSLog(@"%@",[a stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]);
              
    }
    
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
    return [[carPickerArray objectAtIndex:row] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component

{
    
    NSLog(@"Selected: %@", [carPickerArray objectAtIndex:row]);
    model = [carPickerArray objectAtIndex:row];
    [self setModel:model];
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
-(IBAction)next:(id)sender{
    MenuViewController *mc = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    [self presentViewController:mc animated:YES completion:NULL];
    NSLog(@"NEXT: %@", brand);
    model= [model stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSLog(@"NEXT: %@", model);
    //Create method to get make and model and compose a serialized string of what we have.
}
-(NSString *)brand{
    NSLog(@"AT BRAND: %@", b);
    return b;
}
-(NSString *)model{
    NSLog(@"AT MODEL: %@", m);
    return m;
}
-(void)setBrand:(NSString *)val{
    
    brand = val;
    b = val;
    NSUserDefaults *brandObject = [NSUserDefaults standardUserDefaults];
    [brandObject setObject:b forKey:@"Brand"];

    NSLog(@"setBrand: %@", b);
}
-(void)setModel:(NSString *)val{
    
    model = val;
    m = [val stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSUserDefaults *modelObject = [NSUserDefaults standardUserDefaults];
    [modelObject setObject:m forKey:@"Model"];

    NSLog(@"setModel: %@", m);
}
@end
