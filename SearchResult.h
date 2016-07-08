//
//  SearchResult.h
//  NearBy
//
//  Created by MINDFIRE on 28/06/16.
//  Copyright © 2016 MINDFIRE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"

@interface SearchResult : NSObject

@property NSMutableArray* categories;
@property Location* location;
@property NSString* name;
@property NSString* ratingImageUrl;
@property NSString* ratingImageUrlSmall;
@property NSString* imageUrl;
@property NSNumber* reviewCount;
@property NSString* rating;

- (SearchResult*) initWithDictionary: (NSDictionary*) dict;

@end
