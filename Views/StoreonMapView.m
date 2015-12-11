//
//  StoreonMapView.m
//  Store2
//
//  Created by Vats, Anuj on 12/10/15.
//  Copyright (c) 2015 Vats, Anuj. All rights reserved.
//

#import "StoreonMapView.h"



@implementation StoreonMapView

-(void)loadMapWithStoreLocationWithCLLocationCordinate:(CLLocationCoordinate2D)coordinates{
    
    self.mapView.zoomEnabled = NO;
    self.mapView.scrollEnabled = NO;
    self.mapView.userInteractionEnabled = NO;

    CLLocationDistance distance = 250;
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinates,
                                                                   distance,
                                                                   distance);
    MKCoordinateRegion adjusted_region = [self.mapView regionThatFits:region];
    
    [self.mapView setRegion:adjusted_region animated:YES];
    
    
    MKPointAnnotation * annotation = [[MKPointAnnotation alloc] init];
    
    annotation.coordinate = coordinates;
    
    [self.mapView addAnnotation:annotation];
   
}

@end
