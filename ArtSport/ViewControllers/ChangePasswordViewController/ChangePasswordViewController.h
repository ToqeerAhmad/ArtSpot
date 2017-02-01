//
//  ChangePasswordViewController.h
//  ArtSport
//
//  Created by Toqir Ahmad on 18/01/2017.
//  Copyright © 2017 Toqir Ahmad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePasswordViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITextField *oldPasswordField;
@property (nonatomic, strong) IBOutlet UITextField *PasswordField;
@property (nonatomic, strong) IBOutlet UITextField *confirmPasswordField;

@property (nonatomic, strong) IBOutlet UIButton *backBtn;
@property (nonatomic, strong) IBOutlet UIButton *chnagePasswordBtn;

@end
