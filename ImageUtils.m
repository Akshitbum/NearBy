//
//  ImageUtils.m
//  NearBy
//
//  Created by MINDFIRE on 27/06/16.
//  Copyright © 2016 MINDFIRE. All rights reserved.
//

#import "ImageUtils.h"

@implementation ImageUtils
/**
 Method to download image data and perform callback
 @param url image url
 @param handler block use for callback
 */
+ (void) getImageData:(NSString*) url Handler: (void(^)(UIImage *data)) handler {
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: url]];
        if ( data == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            handler([UIImage imageWithData:data]);
        });
    });
}
/**
 Method to crop image
 @param imageTocrop Image that you want to crop
 @param rect rect that you want from original image
 */
+ (UIImage *)croppIngimageByImageName:(UIImage *)imageToCrop toRect:(CGRect)rect {
    CGImageRef imageRef = CGImageCreateWithImageInRect([imageToCrop CGImage], rect);
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return cropped;
}

@end
