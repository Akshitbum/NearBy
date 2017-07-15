//
//  LoadingIndicator.m
//  NearBy
//
//  Created by Akshit Bum on 15/07/17.
//  Copyright © 2017 MINDFIRE. All rights reserved.
//

#import "LoadingIndicator.h"

@implementation LoadingIndicator

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (LoadingIndicator *)loadView {
    LoadingIndicator *loadingIndicator = [[[NSBundle mainBundle] loadNibNamed:@"LoadingIndicator" owner:self options:nil]objectAtIndex:0];
    return loadingIndicator;
    
}

- (void) showLoadingIndicator: (BOOL)show {
    if(show) {
        self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
       [self.indicatorView startAnimating];
    }
    else {
        [self.indicatorView stopAnimating];
        self.indicatorView = nil;
    }
}

@end
