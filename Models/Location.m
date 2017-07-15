//
//  Address.m
//  NearBy
//
//  Created by MINDFIRE on 28/06/16.
//  Copyright © 2016 MINDFIRE. All rights reserved.
//

#import "Location.h"

@implementation Location

- (Location*) initWithDictionary: (NSDictionary*) dict
{
    self = [super init];
    if(self)
    {
        self.address = [dict objectForKey:@"address"];
        self.city = [dict objectForKey:@"city"];
        self.cordinates = [dict objectForKey:@"coordinate"];
        self.displayAddress = [dict objectForKey:@"display_address"];
    }
    return self;
}

@end
