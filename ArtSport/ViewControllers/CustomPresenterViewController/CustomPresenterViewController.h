//
//  CustomPresenterViewController.h
//  ArtSport
//
//  Created by Toqir Ahmad on 01/02/2017.
//  Copyright © 2017 Toqir Ahmad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomPresenterViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIImageView *imageview;
@property (nonatomic, weak) IBOutlet UITextView *textview;

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *text;

@end
