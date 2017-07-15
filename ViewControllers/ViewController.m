//
//  ViewController.m
//  NearBy
//
//  Created by MINDFIRE on 20/06/16.
//  Copyright © 2016 MINDFIRE. All rights reserved.
//

#import "ViewController.h"
#import "CategoryCell.h"
#import "ResultCell.h"
#import "YPAPISample.h"
#import "MapViewController.h"
#import "DetailViewController.h"
#import "SearchResult.h"
#import "Alert.h"

#define HEADER_HEIGHT 60.0
#define ROW_HEIGHT_CATEGORY 30.0
#define ROW_HEIGHT_RESULTS 215.0

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _locUtil = [[LocationUtils alloc]init];
    _locUtil.delegate = self;
    
    _categories = [NSMutableArray arrayWithObjects:kRestaurants, kBars, kCofee, kMoreCat, nil];
    
    [_tableView registerNib:[UINib nibWithNibName:@"CategoryCell" bundle:nil] forCellReuseIdentifier:@"catCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"ResultsCell" bundle:nil] forCellReuseIdentifier:@"resCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - LocationUtils Delegate
/**
 This method will be called after location fetch completes
 @param loc is array of locations having current location at 0th index
 @param city is Current City
 */
- (void) locationFetched: (NSArray*) locations withCity:(NSString *)city {
    NSLog(@"Location Fetched");
    _latLong = [NSString stringWithFormat:@"%f, %f", ((CLLocation*)[locations objectAtIndex:0]).coordinate.latitude, ((CLLocation*)[locations objectAtIndex:0]).coordinate.longitude ];
    _currCity = city;
    _currCordinates = ((CLLocation *) [locations objectAtIndex:0]);
    [self apiCallForSearchResultsWith:self.srchBar.text location:city andCLL:self.latLong];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0)
        return [_categories count];
    else
        return [_results count];
}

 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     if([indexPath section] == 0 ) {
         CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"catCell" forIndexPath:indexPath];
         cell.lbl.text = [_categories objectAtIndex:indexPath.row];
         [cell.imv setImage:[UIImage imageNamed:kRestImg]];
         return cell;
     }
     else {
         ResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"resCell" forIndexPath:indexPath];
         SearchResult* res = [_results objectAtIndex:indexPath.row];
         cell = [cell getCellWithSetValues:res];
         return cell;
     }
}

- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section {
    return HEADER_HEIGHT;
}

- (UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section {
    return [[[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:nil options:nil] objectAtIndex:section];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if([indexPath section] == 0)
        return ROW_HEIGHT_CATEGORY;
    else
        return ROW_HEIGHT_RESULTS;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if([indexPath section] == 0) {
        if([[_categories objectAtIndex:indexPath.row] isEqualToString: kMoreCat]) {
            [_categories removeObjectAtIndex:indexPath.row];
            [_categories addObjectsFromArray: [[NSArray alloc]initWithObjects:kClubs, kHotels, kLounge, nil]];
            [self.tableView reloadData];
        }
        else
            [self apiCallForSearchResultsWith:[_categories objectAtIndex:indexPath.row] location:_currCity andCLL:_latLong];
    }
    if([indexPath section] == 1)
        [self performSegueWithIdentifier:@"ToDetail" sender:indexPath];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if([searchBar isEqual:self.srchBar]) {
        [self apiCallForSearchResultsWith:searchBar.text location:self.currCity andCLL:self.latLong];
    }
}
/**
 Api call if text length is more than 3
 */
- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if([searchBar.text length] > 3) {
        [self apiCallForSearchResultsWith:searchBar.text location:self.currCity andCLL:self.latLong];
    }
}
/**
 Getting search results from api call
 @param searchterm is something user wants to search for
 @param loc current city
 @param cll current latitude and longitude
 */
- (void) apiCallForSearchResultsWith:(NSString*) searchTerm location: (NSString*) loc andCLL: (NSString*) cll {
    [_gAppDelegate showLoadingView:YES];
    YPAPISample* req = [[YPAPISample alloc]init];
    [req queryTopBusinessInfoForTerm:searchTerm location:loc cll:cll completionHandler:^(NSDictionary *topBusinessJSON, NSError *error) {
        if(!error) {
            NSLog(@"Search Completed");
        
            [_gAppDelegate showLoadingView:NO];

            _results = [NSMutableArray array];
            for(NSDictionary* dict in topBusinessJSON[@"businesses"]) {
                SearchResult* res = [[SearchResult alloc]initWithDictionary:dict];
                [_results addObject:res];
            }
            [self.tableView reloadData];
        }
        else {
            [_gAppDelegate showLoadingView:NO];
            UIAlertController *alertController = [Alert getDefaultAlert:@"Error" message:[error localizedDescription] actionTitle:@"Ok"];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }];
}

//- (void) tableView:(UITableView *)tableView willDisplayCell:(CustomCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    cell.lbl.text = [_items objectAtIndex:indexPath.row];
//}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     if([segue.identifier isEqualToString: @"ToMap"]) {
         MapViewController *mapCtrl = segue.destinationViewController;
         mapCtrl.currentLoc = _currCordinates;
         mapCtrl.results = _results;
     }
     if([segue.identifier isEqualToString:@"ToDetail"]) {
         DetailViewController *detailCtrl = segue.destinationViewController;
         detailCtrl.detail = [self.results objectAtIndex:((NSIndexPath*)sender).row ];
     }
 }
 

@end
