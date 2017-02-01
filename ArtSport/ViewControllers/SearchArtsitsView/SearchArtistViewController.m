//
//  SearchArtistViewController.m
//  ArtSport
//
//  Created by Toqir Ahmad on 15/01/2017.
//  Copyright © 2017 Toqir Ahmad. All rights reserved.
//

#import "SearchArtistViewController.h"

@interface SearchArtistViewController ()
{
    ModelLocator *model;
}
@end

@implementation SearchArtistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    model = [ModelLocator getInstance];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = true;
    self.navigationController.tabBarController.tabBar.hidden = true;
    [self.searchResultTableView registerNib:[UINib nibWithNibName:@"SearchArtistTableViewCell" bundle:nil] forCellReuseIdentifier:@"SearchArtistTableViewCell"];
}

- (void)setReferencedNavigation:(UINavigationController *)refNavCon {
    self.refNavigationController = refNavCon;
}

- (IBAction)closeScreen:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)clearSearchField:(id)sender {
    self.searchField.text = @"";
    _lblText.hidden = false;
}



#pragma mark - UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return model.artistResultArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchArtistModel *artsitObject = [model.artistResultArray objectAtIndex:indexPath.row];
    SearchArtistTableViewCell *cell = (SearchArtistTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"SearchArtistTableViewCell" forIndexPath:indexPath];
    cell.lblArtistName.text = artsitObject.ast_name;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s%@",ASArtistImageURl,artsitObject.ast_photo]];
    [cell.artistImage setImageWithURL:url usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    return cell;
}


#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchArtistModel *artsitObject = [model.artistResultArray objectAtIndex:indexPath.row];
    [self getDetailOfArtist:artsitObject.ast_id];
}

#pragma mark - UITextField Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (![string isEqualToString:@""]) {
        [self searchArtsitWebApi:[NSString stringWithFormat:@"%@%@",textField.text,string]];
    }
    return true;
}

#pragma mark - Web API For Search Artist



- (void)searchArtsitWebApi:(NSString *)keyWord {
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setValue:keyWord forKey:@"key"];
    
    WebServices *service = [[WebServices alloc] init];
    service.delegate = self;
    [service SendRequestForPostData:dict andServiceURL:@"/artist/readallartists" andServiceReturnType:@"SearchArtsit"];
}

- (void)getDetailOfArtist:(NSString *)artsit_id {
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setValue:artsit_id forKey:@"ast_id"];
    
    WebServices *service = [[WebServices alloc] init];
    service.delegate = self;
    [service SendRequestForPostData:dict andServiceURL:@"/artist/detail" andServiceReturnType:@"ArtistDetail"];

}

-(void) webServiceStart {
    
    MBProgressHUD *progreesHud = [MBProgressHUD showHUDAddedTo:[[[UIApplication sharedApplication] delegate] window] animated:true];
    progreesHud.labelText = @"Searching...";
    [progreesHud show:true];
    
}

-(void) webServiceError:(NSString *)errorType {
    
    [MBProgressHUD hideHUDForView:[[[UIApplication sharedApplication] delegate] window] animated:true];
    [self.navigationController.view makeToast:errorType
                                     duration:3.0
                                     position:CSToastPositionCenter];
    
}

-(void) webServiceEnd:(id)returnObject andResponseType:(id)responseType {
    [MBProgressHUD hideHUDForView:[[[UIApplication sharedApplication] delegate] window] animated:true];
    if ([responseType isEqualToString:@"ArtistDetail"]) {
        [self removeSearchView];
    }else {
        _lblText.hidden = true;
        [self.searchResultTableView reloadData];
    }
    
}

- (void)removeSearchView {
    [self dismissViewControllerAnimated:true completion:^{
        ArtistViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ArtistViewController"];
        vc.isArtsit = true;
        [self.refNavigationController pushViewController:vc animated:true];
        
    }];

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
