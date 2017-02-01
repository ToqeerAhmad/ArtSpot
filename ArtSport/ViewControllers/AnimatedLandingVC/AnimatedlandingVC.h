//
//  AnimatedlandingVC.h
//  ArtSport
//
//  Created by APPLE on 1/11/17.
//  Copyright © 2017 Toqir Ahmad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimatedlandingVC : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *img_Animated;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraints;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;

@end
