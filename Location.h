//
//  Location.h
//  NearBy
//
//  Created by MINDFIRE on 28/06/16.
//  Copyright © 2016 MINDFIRE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface Location : NSObject
@property  NSArray* address;
@property  NSString* city;
@property NSDictionary* cordinates;
@property NSArray* displayAddress;

- (Location*) initWithDictionary: (NSDictionary*) dict;

@end
