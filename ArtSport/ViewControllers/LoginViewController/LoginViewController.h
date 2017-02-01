//
//  LoginViewController.h
//  ArtSport
//
//  Created by Toqir Ahmad on 30/12/2016.
//  Copyright © 2016 Toqir Ahmad. All rights reserved.
//

#import "ViewController.h"

@interface LoginViewController : UIViewController


// SignUp Views Outlets

@property (nonatomic, weak) IBOutlet UITextField *firstNameField;
@property (nonatomic, weak) IBOutlet UITextField *lastNameField;
@property (nonatomic, weak) IBOutlet UITextField *emailField;
@property (nonatomic, weak) IBOutlet UITextField *passwordField;
@property (nonatomic, weak) IBOutlet UITextField *confirmPasswordField;
@property (nonatomic, weak) IBOutlet UIButton *continueBtn;

// Login Views Outlets

@property (nonatomic, weak) IBOutlet UITextField *loginEmailField;
@property (nonatomic, weak) IBOutlet UITextField *loginPasswordField;
@property (nonatomic, weak) IBOutlet UIButton *loginContinueBtn;



@property (nonatomic, weak) IBOutlet UIView *signUpView;
@property (nonatomic, weak) IBOutlet UIView *loginView;


// Centre Buttons For Signup and Facebook

@property (nonatomic, weak) IBOutlet UIButton *facebookBtn;
@property (nonatomic, weak) IBOutlet UIButton *signUpEmailBtn;

// Bottom Buttons Outlets

@property (nonatomic, weak) IBOutlet UILabel *lblQuestion;
@property (nonatomic, weak) IBOutlet UIButton *loginBtn;
@property (nonatomic, weak) IBOutlet UIButton *signUpBtn;
@property (nonatomic, weak) IBOutlet UIButton *forgotPasswordBtn;

@end
