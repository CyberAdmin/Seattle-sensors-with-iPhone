//
//  MapViewController.m
//  SeattleSensors
//
//  Created by Michael Reininger on 8/8/13.
//  Copyright (c) 2013 WINLAB. All rights reserved.
//

#import "MapViewController.h"
#import "NodeConnection.h"
@interface MapViewController ()

@end

@implementation MapViewController
-(void)addMarkerWithLat:(float)lat andLong:(float)lon withTitle:(NSString*)title{
    
    RMPointAnnotation *annotation = [[RMPointAnnotation alloc] initWithMapView:mapView
                                                                    coordinate:CLLocationCoordinate2DMake(lat, lon)
                                                                      andTitle:title];
    
    [mapView addAnnotation:annotation];
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
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *defIP = [userDefaults objectForKey:@"DefaultNodeIP"];
    NSString *make = [userDefaults objectForKey:@"Brand"];
    NSString *model = [userDefaults objectForKey:@"Model"];
    NSLog(@"Make: %@", make);
    NSLog(@"Model: %@", model);
    NSLog(@"DefIP: %@", defIP);
    NodeConnection *n = [[NodeConnection alloc] init];
    [n newConnection:defIP];
    [n sendRawData:[NSString stringWithFormat:@"<iWant><sensor>%@:%@-FuelConsumption</sensor><parameters>nil</parameters></iWant>", make, model]];

    nc = [[NodeConnection alloc] init];
    [nc newConnection:defIP];
    [nc sendRawData:[NSString stringWithFormat:@"<VEHICLE><make>%@</make><model>%@</model><parameters>nil</parameters></VEHICLE>",make, model]];
    [self plotMap:[nc receiveData]];
    RMMapBoxSource *tileSource = [[RMMapBoxSource alloc] initWithMapID:@"examples.map-z2effxa8"];
    
    mapView = [[RMMapView alloc] initWithFrame:self.view.bounds andTilesource:tileSource];
    [self addMarkerWithLat:-74 andLong:37 withTitle:@"HELLO"];
    [self.view addSubview:mapView];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidAppear{

    
    
}
-(void)plotMap:(NSString *)data{
    NSLog(@"DATA: %@", data);
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
