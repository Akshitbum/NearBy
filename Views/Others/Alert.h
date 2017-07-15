//
//  Alert.h
//  NearBy
//
//  Created by Akshit Bum on 15/07/17.
//  Copyright © 2017 MINDFIRE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface Alert : NSObject

+ (UIAlertController *) getDefaultAlert:(NSString*)title message:(NSString*)message actionTitle:(NSString*)actionTitle;
+ (UIAlertController *) getCustomizeALert:(NSString*)title message:(NSString*)message actionArray:(NSMutableArray *)array handler:(void (^)(int index))handler;
@end
