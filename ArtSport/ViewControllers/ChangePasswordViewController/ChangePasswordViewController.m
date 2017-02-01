//
//  ChangePasswordViewController.m
//  ArtSport
//
//  Created by Toqir Ahmad on 18/01/2017.
//  Copyright © 2017 Toqir Ahmad. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // self.backBtn.layer.cornerRadius = 25/2;
   // self.backBtn.layer.masksToBounds = true;
    self.chnagePasswordBtn.layer.cornerRadius = 5.0;
    self.chnagePasswordBtn.layer.masksToBounds = true;
}

- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}


- (IBAction)changePassword:(id)sender {
    
    NSString *error = @"";
    
    if ([self.oldPasswordField.text isEqualToString:@""]) {
        error = @"Please enter your old password.";
    }if ([self.PasswordField.text isEqualToString:@""]) {
        error = @"Please enter your new password.";
    }if ([self.confirmPasswordField.text isEqualToString:@""]) {
        error = @"Please confrim your new password.";
    }
    
    if ([error isEqualToString:@""]) {
        [self changePasswordWebService];
    }else {
        [self.navigationController.view makeToast:error
                                         duration:3.0
                                         position:CSToastPositionCenter];
    }
    
}

- (void)changePasswordWebService {
    
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"usr_id"] forKey:@"usr_id"];
    [dict setValue:self.PasswordField.text forKey:@"new_pw"];
    [dict setValue:self.oldPasswordField.text forKey:@"old_pw"];
    
    WebServices *service = [[WebServices alloc] init];
    service.delegate = self;
    [service SendRequestForPostData:dict andServiceURL:@"/user/changepassword" andServiceReturnType:@"changepassword"];
    
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
    [ApplicationHelper showAlertView:@"Alert" andMessage:@"Password chnaged successfully."];
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
