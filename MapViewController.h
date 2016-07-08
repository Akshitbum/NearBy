//
//  MapController.h
//  NearBy
//
//  Created by MINDFIRE on 24/06/16.
//  Copyright © 2016 MINDFIRE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "LocationUtils.h"


@interface MapViewController : UIViewController <MKMapViewDelegate>
/**
 Use this property to keep current location
 */
@property (nonatomic) CLLocation* currentLoc;
/**
 Use this property to keep array of location near by current location
 */
@property NSMutableArray* results;

@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@end
