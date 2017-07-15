//
//  AppDelegate.h
//  Yelp
//
//  Created by MINDFIRE on 20/06/16.
//  Copyright © 2016 MINDFIRE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "LoadingIndicator.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
   LoadingIndicator* _loadingView;
}

@property (strong, nonatomic) UIWindow *window;

- (void) showLoadingView:(BOOL)show;
#define _gAppDelegate (AppDelegate*)[UIApplication sharedApplication].delegate

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
