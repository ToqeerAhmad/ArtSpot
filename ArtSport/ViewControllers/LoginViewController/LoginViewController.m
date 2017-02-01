//
//  LoginViewController.m
//  ArtSport
//
//  Created by Toqir Ahmad on 30/12/2016.
//  Copyright © 2016 Toqir Ahmad. All rights reserved.
//

#import "LoginViewController.h"
#import "WelcomeViewController.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface LoginViewController ()
{
   
}

@property (nonatomic, weak)  AVPlayer *player;;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = true;
    [self playvideoInBackground];
    self.loginEmailField.text = @"marksear@gmail.com";
    self.loginPasswordField.text = @"123";
}

- (void)playvideoInBackground {
    
    NSString*thePath=[[NSBundle mainBundle] pathForResource:@"out1" ofType:@"mp4"];
    NSURL*url=[NSURL fileURLWithPath:thePath];

    // create a player view controller
    _player = [AVPlayer playerWithURL:url];
    AVPlayerViewController *controller = [[AVPlayerViewController alloc] init];
    
    [self addChildViewController:controller];
    [self.view addSubview:controller.view];
    
    controller.view.frame = self.view.frame;
    [self.view insertSubview:controller.view atIndex:0];
    controller.player = _player;
    controller.showsPlaybackControls = NO;
    _player.closedCaptionDisplayEnabled = NO;
    [_player play];
    
    __weak typeof(self) weakSelf = self; // prevent memory cycle
    NSNotificationCenter *noteCenter = [NSNotificationCenter defaultCenter];
    [noteCenter addObserverForName:AVPlayerItemDidPlayToEndTimeNotification
                            object:nil // any object can send
                             queue:nil // the queue of the sending
                        usingBlock:^(NSNotification *note) {
                            // holding a pointer to avPlayer to reuse it
                            [weakSelf.player seekToTime:kCMTimeZero];
                            [weakSelf.player play];
                        }];
}

- (void)playerItemDidReachEnd:(NSNotification *)notification {
    AVPlayerItem *p = [notification object];
    [p seekToTime:kCMTimeZero];
}


- (IBAction)loginBtnAction:(id)sender {
    [self checkFieldsAreValidForLogin];
}

- (IBAction)signUpBtnAction:(id)sender {
    [self checkFieldsAreValidForSignUp];
}

- (IBAction)showLoginView:(id)sender {
    
    _signUpEmailBtn.hidden = true;
    _facebookBtn.hidden = true;
    
    _signUpView.hidden = true;
    _loginBtn.hidden = true;
    _lblQuestion.hidden = true;
    
    _loginView.hidden = false;
    _signUpBtn.hidden = false;
    _forgotPasswordBtn.hidden = false;

}

- (IBAction)showSignUpView:(id)sender {
    
    _signUpEmailBtn.hidden = true;
    _facebookBtn.hidden = true;
    
    _loginView.hidden = true;
    _signUpBtn.hidden = true;
    _forgotPasswordBtn.hidden = true;
    
    _loginBtn.hidden = false;
    _lblQuestion.hidden = false;
    _signUpView.hidden = false;
}

#pragma mark - Web API For Sign in

- (void)checkFieldsAreValidForLogin {
    
    NSString *error = @"";
    
    if ([self.loginEmailField.text isEqualToString:@""]) {
        error = @"Please enter your email.";
    }if ([self.loginPasswordField.text isEqualToString:@""]) {
        error = [error stringByAppendingString:@"\nPlease enter your password."];
    }
    if ([error isEqualToString:@""]) {
        [self sIgnInCall];
    }else {
        [self.navigationController.view makeToast:error
                                         duration:3.0
                                         position:CSToastPositionCenter];
    }
}

- (void)sIgnInCall {
    
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setValue:self.loginEmailField.text forKey:@"usr_email"];
    [dict setValue:self.loginPasswordField.text forKey:@"usr_password"];
    
    WebServices *service = [[WebServices alloc] init];
    service.delegate = self;
    [service SendRequestForPostData:dict andServiceURL:@"/user/signin" andServiceReturnType:@"SignIn"];
    
}


#pragma mark - Web API For Sign Up

- (void)checkFieldsAreValidForSignUp {
    
    NSString *error = @"";
    
    if ([self.firstNameField.text isEqualToString:@""]) {
        error = @"Please enter your first name.";
    }if ([self.lastNameField.text isEqualToString:@""]) {
        error = @"Please enter your last name.";
    }if ([self.emailField.text isEqualToString:@""]) {
        error = @"Please enter your Email.";
    }if ([self.passwordField.text isEqualToString:@""]) {
        error = @"Please enter your password.";
    }if ([self.confirmPasswordField.text isEqualToString:@""]) {
        error = @"Please confirm the password.";
    }
    
    if (_passwordField.text != _confirmPasswordField.text) {
        error = @"Your password does not match. Please confirm your password!";
    }
    
    if ([error isEqualToString:@""]) {
        [self sIgnUpCall];
    }else {
        [ApplicationHelper showAlertView:@"Alert" andMessage:error];
    }
}

- (void)sIgnUpCall {
    
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    
    [dict setValue:self.firstNameField.text forKey:@"usr_fname"];
    [dict setValue:self.lastNameField.text forKey:@"usr_lname"];
    [dict setValue:self.emailField.text forKey:@"usr_email"];
    [dict setValue:self.passwordField.text forKey:@"usr_password"];
    
    WebServices *service = [[WebServices alloc] init];
    service.delegate = self;
    [service SendRequestForPostData:dict andServiceURL:@"/user/signup" andServiceReturnType:@"SignUp"];
    
}

-(void) webServiceStart {
    
   MBProgressHUD *progreesHud = [MBProgressHUD showHUDAddedTo:[[[UIApplication sharedApplication] delegate] window] animated:true];
    progreesHud.labelText = @"Loading...";
    [progreesHud show:true];
    
}

-(void) webServiceError:(NSString *)errorType {
    
    [self.navigationController.view makeToast:errorType
                                     duration:3.0
                                     position:CSToastPositionCenter];

    [MBProgressHUD hideHUDForView:[[[UIApplication sharedApplication] delegate] window] animated:true];
}

-(void) webServiceEnd:(id)returnObject andResponseType:(id)responseType {
    [MBProgressHUD hideHUDForView:[[[UIApplication sharedApplication] delegate] window] animated:true];
    WelcomeViewController *welcomeVc = [self.storyboard instantiateViewControllerWithIdentifier:@"WelcomeViewController"];
    [self.navigationController pushViewController:welcomeVc animated:true];

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
