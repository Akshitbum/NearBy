//
//  ResultCell.h
//  NearBy
//
//  Created by MINDFIRE on 21/06/16.
//  Copyright © 2016 MINDFIRE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchResult.h"

@interface ResultCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UIImageView* imv;
@property (nonatomic, weak) IBOutlet UILabel* lbl;

@property (nonatomic, weak) IBOutlet UIImageView* rating;
- (ResultCell*) getCellWithSetValues: (SearchResult*) res;

@end
