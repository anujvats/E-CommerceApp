//
//  StoreonMapView.h
//  Store2
//
//  Created by Vats, Anuj on 12/10/15.
//  Copyright (c) 2015 Vats, Anuj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>



@interface StoreonMapView : UIView<MKMapViewDelegate>

@property(nonatomic,weak) IBOutlet MKMapView *mapView;


-(void)loadMapWithStoreLocationWithCLLocationCordinate:(CLLocationCoordinate2D)coordinates;

@end
