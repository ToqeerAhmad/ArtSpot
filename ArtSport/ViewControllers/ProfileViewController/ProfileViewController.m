//
//  ProfileViewController.m
//  ArtSport
//
//  Created by Toqir Ahmad on 01/01/2017.
//  Copyright © 2017 Toqir Ahmad. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.backBtn.layer.cornerRadius = 25/2;
    self.backBtn.layer.masksToBounds = true;
    
    self.changePasswordBtn.layer.cornerRadius = 5;
    self.changePasswordBtn.layer.masksToBounds = true;
    
    self.saveProfileBtn.layer.cornerRadius = 5;
    self.saveProfileBtn.layer.masksToBounds = true;

}

- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    ModelLocator *model = [ModelLocator getInstance];
   
    self.fullNameField.text = model.firstName;
    self.lastNameField.text = model.lastName;
    self.emailField.text = model.email;

}

- (IBAction)logoutBtnAction:(id)sender {
    
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defs dictionaryRepresentation];
    for (id key in dict) {
        [defs removeObjectForKey:key];
    }
    [defs synchronize];
    LoginViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [[[UIApplication sharedApplication] delegate] window].rootViewController = nc;
}

- (IBAction)changePassword:(id)sender {
    
    ChangePasswordViewController *profileVc = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangePasswordViewController"];
    [self.navigationController pushViewController:profileVc animated:true];

}


- (IBAction)saveProfileBtn:(id)sender {
    
    NSString *error = @"";
    if ([self.fullNameField.text isEqualToString:@""]) {
        error = @"First name field is empty.";
    }else if ([self.lastNameField.text isEqualToString:@""]) {
        error = @"Last name field is empty.";
    }else if ([self.emailField.text isEqualToString:@""]) {
        error = @"Email field is empty.";
    }
    
    if ([error isEqualToString:@""]) {
        [self saveProfileService];
    }else {
        [self.navigationController.view makeToast:error
                                         duration:3.0
                                         position:CSToastPositionCenter];
    }
    
}

- (void)saveProfileService {
    
    
    NSMutableDictionary *dict = [NSMutableDictionary new];

    [dict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"usr_id"] forKey:@"usr_id"];
    [dict setValue:self.emailField.text forKey:@"usr_email"];
    [dict setValue:self.fullNameField.text forKey:@"usr_fname"];
    [dict setValue:self.lastNameField.text forKey:@"usr_lname"];
    
    WebServices *service = [[WebServices alloc] init];
    service.delegate = self;
    [service SendRequestForPostData:dict andServiceURL:@"/user/saveprofile" andServiceReturnType:@"saveProfile"];
    
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
