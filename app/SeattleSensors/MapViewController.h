//
//  MapViewController.h
//  SeattleSensors
//
//  Created by Michael Reininger on 8/8/13.
//  Copyright (c) 2013 WINLAB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapBox/MapBox.h>
#import "NodeConnection.h"
@interface MapViewController : UIViewController{
    RMMapView *mapView;
    NodeConnection *nc;

}
-(void)addMarkerWithLat:(float)lat andLong:(float)lon withTitle:(NSString*)title;
-(void)plotMap:(NSString *)data;
@end
