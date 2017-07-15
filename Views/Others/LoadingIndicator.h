//
//  LoadingIndicator.h
//  NearBy
//
//  Created by Akshit Bum on 15/07/17.
//  Copyright © 2017 MINDFIRE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingIndicator : UIView

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView* indicatorView;
@property (nonatomic, retain) IBOutlet UIView* view;

- (void) showLoadingIndicator: (BOOL)show;
+ (LoadingIndicator *) loadView;
@end
