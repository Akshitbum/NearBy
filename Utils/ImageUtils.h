//
//  ImageUtils.h
//  NearBy
//
//  Created by MINDFIRE on 27/06/16.
//  Copyright © 2016 MINDFIRE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageUtils : NSObject
+ (void) getImageData: (NSString*) url Handler: (void(^)(UIImage* img)) handler;
+ (UIImage *)croppIngimageByImageName:(UIImage *)imageToCrop toRect:(CGRect)rect;

@end
