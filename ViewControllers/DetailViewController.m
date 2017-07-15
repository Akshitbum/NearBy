//
//  DetailViewController.m
//  NearBy
//
//  Created by MINDFIRE on 27/06/16.
//  Copyright © 2016 MINDFIRE. All rights reserved.
//

#import "DetailViewController.h"
#import "ImageUtils.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", _detail);
    // Do any additional setup after loading the view.
    [self setValues];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 Method to set all values to UI element
 */
- (void) setValues {
    [ImageUtils getImageData:_detail.imageUrl Handler:^(UIImage *data) {
        _imgView.image = data;
    }];
    
    [ImageUtils getImageData:_detail.ratingImageUrl Handler:^(UIImage *data) {
        _ratings.image = data;
    }];
    _titleLbl.text = _detail.name;
    _reviewCount.text = [NSString stringWithFormat:@"%@ %@", _detail.reviewCount, @"reviews"];
    
    NSArray *tempArr = _detail.location.displayAddress;
    NSString*  str1= [[NSString alloc]init];
    for(NSString* str in tempArr) {
        str1 = [NSString stringWithFormat:@"%@  %@", str1, str];
    }

    [self setTextViewSize:_address withString:str1 LayoutConstraint:_textViewHeightCons andFontName:@"HelveticaNeue"];

    _address.text = str1;
    
    tempArr = _detail.categories;
    str1 = @"";
    for(NSArray* arr in tempArr) {
        str1 = [NSString stringWithFormat:@"%@  %@", str1, [arr objectAtIndex:0]];
    }
    
    [self setTextViewSize:_categories withString:str1 LayoutConstraint:_textViewHeightConsCat andFontName:@"HelveticaNeue"];
    _categories.text = str1;
}
/**
 Method to set dynamic size to textview according to content
 */
- (void) setTextViewSize: (UITextView*) txtView withString: (NSString*) str LayoutConstraint: (NSLayoutConstraint*) cons andFontName: (NSString*) fontName {
    CGFloat width = txtView.frame.size.width;
    UIFont* font = [UIFont fontWithName:fontName size: 14];
    CGRect rect = [str boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : font,
            NSForegroundColorAttributeName : [UIColor whiteColor]} context:nil];
    [cons setConstant:rect.size.height + 20];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
