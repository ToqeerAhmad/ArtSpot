//
//  SignUpViewController.m
//  ArtSport
//
//  Created by Toqir Ahmad on 30/12/2016.
//  Copyright © 2016 Toqir Ahmad. All rights reserved.
//

#import "SignUpViewController.h"
#import "WelcomeViewController.h"
#import "LoginViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)pushToWelcomeScreen:(id)sender {
    
    [self checkFieldsAreValid];
    
}

- (IBAction)pushToLoginUpScreen:(id)sender {
    
    LoginViewController *welcomeVc = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self.navigationController pushViewController:welcomeVc animated:true];
    
}


#pragma mark - Web API For Sign in

- (void)checkFieldsAreValid {
    
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
    progreesHud.labelText = @"Signing up...";
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
