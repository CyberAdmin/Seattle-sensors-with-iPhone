//
//  MapViewController.h
//  SeattleSensors
//
//  Created by Michael Reininger on 7/29/13.
//  Copyright (c) 2013 WINLAB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "NodeConnection.h"
@interface MapViewController : UIViewController{
    GMSMapView *mapView_;

}
-(void)createGeoPoint:(long)lat andLong:(long)lon andTitle:(NSString *)title andDescription:(NSString *)desc;
-(void)downloadPoints;
@end
