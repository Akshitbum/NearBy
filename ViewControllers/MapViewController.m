//
//  MapController.m
//  NearBy
//
//  Created by MINDFIRE on 24/06/16.
//  Copyright © 2016 MINDFIRE. All rights reserved.
//

#import "MapViewController.h"
#import "DetailViewController.h"
#import "SearchResult.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setCurrentPosition];
    [self plotPostions];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 This method will set the region of map view to current location
 */
- (void) setCurrentPosition {
    MKCoordinateRegion reg = [LocationUtils startUpdateLocation:self.currentLoc.coordinate.latitude andLongi:self.currentLoc.coordinate.longitude];
    [_mapView setRegion:reg];
}
/**
 This method will add all search results as annotations on map.
 */
- (void) plotPostions {
    for (id<MKAnnotation> annotation in _mapView.annotations) {
        [_mapView removeAnnotation:annotation];
    }
    for(SearchResult* dict in _results) {
        Location* location = dict.location;
        NSArray* array = location.displayAddress;
        NSString* address = [[NSString alloc]init];
        for(NSString* str in array) {
            address = [address stringByAppendingString:str];
        }
        CLLocationCoordinate2D coordinate;
        
        coordinate.latitude = [[location.cordinates objectForKey:@"latitude"] doubleValue];
        coordinate.longitude = [[location.cordinates objectForKey:@"longitude"] doubleValue];
        
        LocationUtils *mapCtrl = [[LocationUtils alloc]initWithName:dict.name address:address coordinate:coordinate];
        mapCtrl.userInfo = dict;
        [_mapView addAnnotation:mapCtrl];
    }
}

- (MKPinAnnotationView*) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    static NSString *identifier = @"MyLocation";
    if ([annotation isKindOfClass:[LocationUtils class]]) {
        
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            annotationView.enabled = YES;
            annotationView.canShowCallout = YES;
            annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        } else {
            annotationView.annotation = annotation;
        }
        return annotationView;
    }
    return nil;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    NSDictionary* dict = ((LocationUtils*)view.annotation).userInfo;
    // Navigate to Detail page when annotation view is being clicked.
    [self performSegueWithIdentifier:@"ToDetail" sender: dict];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"ToDetail"]) {
        DetailViewController *detailCtrl = segue.destinationViewController;
        detailCtrl.detail = sender;
    }
}


@end
