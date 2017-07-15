//
//  Alert.m
//  NearBy
//
//  Created by Akshit Bum on 15/07/17.
//  Copyright © 2017 MINDFIRE. All rights reserved.
//

#import "Alert.h"

@implementation Alert

+ (UIAlertController *) getDefaultAlert:(NSString*)title message:(NSString*)message actionTitle:(NSString*)actionTitle {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {
        
    }]];
    return alert;
}

+ (UIAlertController *) getCustomizeALert:(NSString*)title message:(NSString*)message actionArray:(NSMutableArray *)array handler:(void (^)(int index))handler {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    for(NSString *str in array)
        [alert addAction:[UIAlertAction actionWithTitle:str style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {
            handler((int)[array indexOfObject:str]);
    }]];
    return alert;
}

@end
