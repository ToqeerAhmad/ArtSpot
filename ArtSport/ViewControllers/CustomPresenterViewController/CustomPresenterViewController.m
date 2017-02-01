//
//  CustomPresenterViewController.m
//  ArtSport
//
//  Created by Toqir Ahmad on 01/02/2017.
//  Copyright © 2017 Toqir Ahmad. All rights reserved.
//

#import "CustomPresenterViewController.h"

@interface CustomPresenterViewController ()

@end

@implementation CustomPresenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.textview.layer.cornerRadius = 5;
    self.textview.layer.masksToBounds = true;
    
//    if (_image != nil) {
//        self.imageview.image = _image;
//    }else if (![_text isEqualToString:@""]) {
//        self.textview.text = _text;
//    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
