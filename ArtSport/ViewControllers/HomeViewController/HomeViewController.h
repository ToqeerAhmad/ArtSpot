//
//  HomeViewController.h
//  ArtSport
//
//  Created by Toqir Ahmad on 30/12/2016.
//  Copyright © 2016 Toqir Ahmad. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface HomeViewController : ViewController <UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UIButton *centreBtn;
@property (nonatomic, weak) IBOutlet UIButton *searchBtn;
@property (nonatomic, weak) IBOutlet UIView *previewView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraintofBubble;



@end
