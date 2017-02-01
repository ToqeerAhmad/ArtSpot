//
//  ProfileViewController.h
//  ArtSport
//
//  Created by Toqir Ahmad on 01/01/2017.
//  Copyright © 2017 Toqir Ahmad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController


@property (nonatomic, strong) IBOutlet UITextField *fullNameField;
@property (nonatomic, strong) IBOutlet UITextField *lastNameField;
@property (nonatomic, strong) IBOutlet UITextField *emailField;

@property (nonatomic, strong) IBOutlet UIButton *changePasswordBtn;
@property (nonatomic, strong) IBOutlet UIButton *saveProfileBtn;
@property (nonatomic, strong) IBOutlet UIButton *backBtn;

@end
