//
//  MenuViewController.m
//  ArtSport
//
//  Created by Toqir Ahmad on 09/01/2017.
//  Copyright © 2017 Toqir Ahmad. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()
{
    NSMutableArray *menuItemsArray;
}
@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    menuItemsArray = [[NSMutableArray alloc] initWithObjects:@"Porfirio",@"My Library",@"My Gallery",@"Merchandise",@"Notifications",@"Settings",@"Explore", nil];
        [_table registerNib:[UINib nibWithNibName:@"MenuTableViewCell" bundle:nil] forCellReuseIdentifier:@"MenuTableViewCell"];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

#pragma mark - UITableViewDelegates & DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return menuItemsArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    return 60;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuTableViewCell *cell = (MenuTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"MenuTableViewCell" forIndexPath:indexPath];
    cell.lblTitle.text = [menuItemsArray objectAtIndex:indexPath.row];
    cell.lblTitle1.text = [menuItemsArray objectAtIndex:indexPath.row];
    if (indexPath.row == 0) {
        cell.detailLabel.hidden = false;
        cell.lblTitle1.hidden = true;
    }else {
        cell.lblTitle.hidden = true;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        
        [self getProfileService]; // get Profile
        
    }else if (indexPath.row == 1) {
        
        [self getBooksFromLibraryWebService]; // get Books Library
    }
}

        // Get User Profile Service

- (void)getProfileService {
    
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"usr_id"] forKey:@"usr_id"];
    
    WebServices *service = [[WebServices alloc] init];
    service.delegate = self;
    [service SendRequestForPostData:dict andServiceURL:@"/user/getprofile" andServiceReturnType:@"getProfile"];
    
}


        // Get Books from library Service

- (void)getBooksFromLibraryWebService {
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"usr_id"] forKey:@"usr_id"];
    
    WebServices *service = [[WebServices alloc] init];
    service.delegate = self;
    [service SendRequestForPostData:dict andServiceURL:@"/own/books" andServiceReturnType:@"GetBooks"];
    
}

-(void) webServiceStart {
    
    MBProgressHUD *progreesHud = [MBProgressHUD showHUDAddedTo:[[[UIApplication sharedApplication] delegate] window] animated:true];
    progreesHud.labelText = @"Loading...";
    [progreesHud show:true];
    
}

-(void) webServiceError:(NSString *)errorType {
    
    // show error received from Web APi
    [self.navigationController.view makeToast:errorType
                                     duration:3.0
                                     position:CSToastPositionCenter];
    [MBProgressHUD hideHUDForView:[[[UIApplication sharedApplication] delegate] window] animated:true];
}

-(void) webServiceEnd:(id)returnObject andResponseType:(id)responseType {
   
    if ([responseType isEqualToString:@"GetBooks"]) {
        
        MyLibraryViewController *libraryVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MyLibraryViewController"];
        [self.navigationController pushViewController:libraryVC animated:true];
        
    }else {
        
        ProfileViewController *profileVc = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
        [self.navigationController pushViewController:profileVc animated:true];

    }
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
