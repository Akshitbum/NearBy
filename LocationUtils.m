//
//  MapViewController.m
//  NearBy
//
//  Created by MINDFIRE on 23/06/16.
//  Copyright © 2016 MINDFIRE. All rights reserved.
//

#import "LocationUtils.h"
#import "AppDelegate.h"
#import "Alert.h"
#import "ViewController.h"

#define METERS_PER_MILE 16090.344
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)


@interface LocationUtils ()

@end

@implementation LocationUtils
@synthesize delegate;

- (LocationUtils *) init {
    self = [super init];
    if(self) {
        [_gAppDelegate showLoadingView:YES];
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        if(IS_OS_8_OR_LATER) {
            [self.locationManager requestWhenInUseAuthorization];
        }
    }
    return self;
}

- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate {
    if ((self = [super init])) {
        if ([name isKindOfClass:[NSString class]]) {
            self.name = name;
        } else {
            self.name = @"Unknown charge";
        }
        self.address = address;
        self.theCoordinate = coordinate;
    }
    return self;
}

- (void) locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if(status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [_locationManager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    [self getReverseGeocode:locations];
    [_locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [_locationManager stopUpdatingLocation];
    [self showError:error];
}

- (NSString *)title {
    return _name;
}

- (NSString *)subtitle {
    return _address;
}

- (CLLocationCoordinate2D)coordinate {
    return _theCoordinate;
}
/**
 Method to set the region to current location on map.
 */
+ (MKCoordinateRegion) startUpdateLocation:(CLLocationDegrees) lat andLongi:(CLLocationDegrees) longi {
    
    CLLocationCoordinate2D zoomLocation = CLLocationCoordinate2DMake(lat, longi);
    
    MKCoordinateRegion reg = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5 * METERS_PER_MILE, 0.5 * METERS_PER_MILE);
    
    return reg;
}
/**
 To fetch placemark or address from current latitude and longitude.
 @param locations array of locations having current locaton at 0th index.
 */
- (void) getReverseGeocode: (NSArray<CLLocation *>*) locations {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    if(locations.count > 0) {
        CLLocationCoordinate2D myCoOrdinate;
        
        myCoOrdinate.latitude = [locations objectAtIndex:0].coordinate.latitude;
        myCoOrdinate.longitude = [locations objectAtIndex:0].coordinate.longitude;
        
        CLLocation *location = [[CLLocation alloc] initWithLatitude:myCoOrdinate.latitude longitude:myCoOrdinate.longitude];
        [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error){
             if (error) {
                 NSLog(@"failed with error: %@", error);
                 [self showError:error];
                 return;
             }
             if(placemarks.count > 0) {
                 NSString *city = @"";
                 
                 CLPlacemark* placemark = [placemarks objectAtIndex:0];
                 
                 if([placemark.addressDictionary objectForKey:@"SubAdministrativeArea"] != NULL)
                     city = [placemark.addressDictionary objectForKey:@"SubAdministrativeArea"];
                 else if([placemark.addressDictionary objectForKey:@"City"] != NULL)
                     city = [placemark.addressDictionary objectForKey:@"City"];
                 else if([placemark.addressDictionary objectForKey:@"Country"] != NULL)
                     city = [placemark.addressDictionary objectForKey:@"Country"];
                 else
                     city = @"City Not founded";

                 [_gAppDelegate showLoadingView:NO];

                 [self.delegate locationFetched:locations withCity:city];
            }
         }];
    }
}
/**
 Method to show alert dialogue when location could not be fetched.
 */
- (void) showError: (NSError*) error {
    [_gAppDelegate showLoadingView:NO];
    
    NSMutableArray* array = [[NSMutableArray alloc] initWithObjects:@"Retry", nil];
    UIAlertController *alertController = [Alert getCustomizeALert:@"Error" message: kLocatioinError actionArray:array handler:^(int index) {
        [_gAppDelegate showLoadingView:YES];
        [alertController dismissViewControllerAnimated:YES completion:nil];
        [_locationManager startUpdatingLocation];
    }];
    
    [(ViewController*)self.delegate presentViewController:alertController animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
