//
//  AnimatedlandingVC.m
//  ArtSport
//
//  Created by APPLE on 1/11/17.
//  Copyright © 2017 Toqir Ahmad. All rights reserved.
//

#import "AnimatedlandingVC.h"

@interface AnimatedlandingVC ()

@end

@implementation AnimatedlandingVC

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    //[self.img_Animated.superview layoutIfNeeded];

   // self.bottomConstraints.constant = self.view.frame.size.height-240;
    
    
    [UIView animateWithDuration:2.3
                     animations:^{
                         
                         self.heightConstraint.constant += 58;
                         self.widthConstraint.constant += 54;
                         [self.img_Animated layoutIfNeeded];

                    }
                     completion:^(BOOL finished)
                    {
//                        [self performSegueWithIdentifier:@"GoToLogin" sender:nil];
                         [self checkForAutoLogin];
                        
                     }];
    
}


- (void)checkForAutoLogin {
    
    NSString *user_id = [[NSUserDefaults standardUserDefaults] valueForKey:@"usr_id"];
    if (user_id != nil) {
        UITabBarController *homeVc = [self.storyboard instantiateViewControllerWithIdentifier:@"TabBarView"];
        [self.navigationController pushViewController:homeVc animated:true];
        
    }else {
        [self performSegueWithIdentifier:@"GoToLogin" sender:nil];
    }
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
