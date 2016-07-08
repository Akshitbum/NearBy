//
//  SearchResult.m
//  NearBy
//
//  Created by MINDFIRE on 28/06/16.
//  Copyright © 2016 MINDFIRE. All rights reserved.
//

#import "SearchResult.h"

@implementation SearchResult

- (SearchResult*) initWithDictionary: (NSDictionary*) dict
{
    self = [super init];
    if(self)
    {
        self.categories = [dict objectForKey:@"categories"];
        self.imageUrl = [dict objectForKey:@"image_url"];
        self.ratingImageUrl = [dict objectForKey:@"rating_img_url"];
        self.ratingImageUrlSmall = [dict objectForKey:@"rating_img_url_small"];
        self.name = [dict objectForKey:@"name"];
        self.reviewCount = [dict objectForKey:@"review_count"];
        self.rating = [dict objectForKey:@"rating"];
        self.location = [[Location alloc]initWithDictionary:[dict objectForKey:@"location"]];
    }
    return self;
}

@end
