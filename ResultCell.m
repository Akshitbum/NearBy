//
//  ResultCell.m
//  NearBy
//
//  Created by MINDFIRE on 21/06/16.
//  Copyright © 2016 MINDFIRE. All rights reserved.
//

#import "ResultCell.h"
#import "SearchResult.h"
#import "ImageUtils.h"

#define RATING_WIDTH 200
#define RATING_HEIGHT 18
#define START_HEIGHT 360
#define HEIGHT_DIFFERANCE 24

@implementation ResultCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
/**
 This method will return Result cell with values.
 @param res model with values
 */
- (ResultCell*) getCellWithSetValues: (SearchResult*) res {
    self.lbl.text = res.name;
    [ImageUtils getImageData:res.imageUrl Handler:^(UIImage *img) {
        [self.imv setImage:img];
    }];
// Getting rating image by cropping image that contains all rating images
    NSString *ratStr = res.rating;
    double rating = [ratStr doubleValue];
    float mul;
    if(rating == 0) {
        mul = 0;
    }
    else {
        mul = (rating*2 - 1);
    }
    CGRect cropRect = CGRectMake(0, START_HEIGHT + HEIGHT_DIFFERANCE *mul, RATING_WIDTH, RATING_HEIGHT);
    UIImage* cropedImage = [ImageUtils croppIngimageByImageName:[UIImage imageNamed:@"stars_map_www"] toRect:cropRect];
    [self.rating setImage:cropedImage];
    
    return self;
}

@end
