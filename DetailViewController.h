//
//  DetailViewController.h
//  NearBy
//
//  Created by MINDFIRE on 27/06/16.
//  Copyright © 2016 MINDFIRE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchResult.h"

@interface DetailViewController : UIViewController <UITextViewDelegate>
/**
 Use this property to keep Detail of search result.
 */
@property SearchResult* detail;
@property (nonatomic, weak) IBOutlet UILabel *titleLbl;
@property (nonatomic, weak) IBOutlet UITextView *address;
@property (nonatomic, weak) IBOutlet UITextView *categories;
@property (nonatomic, weak) IBOutlet UILabel *reviewCount;

@property (nonatomic, weak) IBOutlet UIImageView *imgView;
@property (nonatomic, weak) IBOutlet UIImageView *ratings;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *textViewHeightCons;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *textViewHeightConsCat;
@end
