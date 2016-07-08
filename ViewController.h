//
//  ViewController.h
//  NearBy
//
//  Created by MINDFIRE on 20/06/16.
//  Copyright © 2016 MINDFIRE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationUtils.h"
#import "AppDelegate.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, MapDelegate>
/**
 Use this property to keep array of category 
 */
@property NSMutableArray* categories;
/**
 Use this property to keep array of search results
 */
@property NSMutableArray* results;
/**
 Use this property to keep current latitude and longitude. 
 */
@property NSString* latLong;
/**
 Use this property to keep current city.
 */
@property NSString* currCity;
/**
 Use this property to keep current Cordinates.
 */
@property CLLocation* currCordinates;

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UISearchBar *srchBar;
@property (nonatomic, weak) IBOutlet UIButton *btnMap;
@property (nonatomic, retain) LocationUtils* locUtil;
@end
