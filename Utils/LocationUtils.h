//
//  MapViewController.h
//  NearBy
//
//  Created by MINDFIRE on 23/06/16.
//  Copyright © 2016 MINDFIRE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@protocol MapDelegate <NSObject>
@required
- (void) locationFetched: (NSArray*) locations withCity: (NSString *) city;

@end

@interface LocationUtils : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate, MKAnnotation>
@property (nonatomic, retain) CLLocationManager* locationManager;
@property (nonatomic,weak) id<MapDelegate> delegate;
@property (nonatomic,weak) id userInfo;
- (LocationUtils*) init;
- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate;
+ (MKCoordinateRegion) startUpdateLocation:(CLLocationDegrees) lat andLongi: (CLLocationDegrees) longi;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, assign) CLLocationCoordinate2D theCoordinate;
@property (strong, nonatomic) UIWindow *window;


@end
