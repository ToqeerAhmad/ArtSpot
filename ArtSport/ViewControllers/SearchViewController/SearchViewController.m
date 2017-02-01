//
//  SearchViewController.m
//  ArtSport
//
//  Created by Toqir Ahmad on 30/12/2016.
//  Copyright © 2016 Toqir Ahmad. All rights reserved.
//

#import "SearchViewController.h"


@interface SearchViewController () <UITextFieldDelegate>
{
    ModelLocator *model;
    BOOL isSearchOn;
}
@end

@implementation SearchViewController

@synthesize buttonsArray,collectionview,searchField;

- (void)viewDidLoad {
    [super viewDidLoad];
     model = [ModelLocator getInstance];
    // Do any additional setup after loading the view.
    self.navigationController.tabBarController.selectedIndex = 1;
    
    [collectionview registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"artWorkCell"];
    
}



- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self getArtworksFromMyArt:@""];
}

-(IBAction)changeCollectionViewStyle:(id)sender {
    
    for (UIButton *btn in buttonsArray) {

        if (btn.tag == [sender tag]) {
            collectionview.tag = btn.tag;
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }else {
            [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        }
    }
    [collectionview reloadData];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionview.tag == 0) {
        return model.ownArtistArray.count;
    }else {
        return model.ownArtworkArray.count;
    }
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    if (collectionview.tag == 0) {
        
        SearchArtistModel *artistObject = [model.ownArtistArray objectAtIndex:indexPath.row];
        ArtistCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"artistCell" forIndexPath:indexPath];
        cell.labelArtistName.text = artistObject.ast_name;
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s%@",ASArtistImageURl,artistObject.ast_photo]];
        [cell.artistImageView setImageWithURL:url usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        
        return cell;

    }else {
        
        CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"artWorkCell" forIndexPath:indexPath];
        ArtworkModel *artObject = [model.ownArtworkArray objectAtIndex:indexPath.row];

        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s%@",ASArtWorkImageURl,artObject.art_image]];
        [cell.artWorkImageView setImageWithURL:url usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        cell.labelArName.text = artObject.art_title;
        cell.labelArt_location.text = artObject.art_location;
    
        artObject.art_dimension = [artObject.art_dimension stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        artObject.art_date = [artObject.art_date stringByReplacingOccurrencesOfString:@" " withString:@""];
            NSString *detail = @"";
            if (![artObject.art_date isEqualToString:@""]) {
                detail = [detail stringByAppendingString:[NSString stringWithFormat:@"%@, ",artObject.art_date]];
            }if (![artObject.art_medium isEqualToString:@""]) {
                detail = [detail stringByAppendingString:[NSString stringWithFormat:@"%@, ",artObject.art_medium]];
            }if (![artObject.art_dimension isEqualToString:@""]) {
                detail = [detail stringByAppendingString:[NSString stringWithFormat:@"%@",artObject.art_dimension]];
            }
            
            cell.labelArt_Detail.text = detail;
        
        return cell;
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (collectionview.tag == 0) {
        return UIEdgeInsetsMake(0, 20, 0, 20);
    }else {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionview.tag == 0) {
        return  CGSizeMake((SCREEN_WIDTH-60)/2, 137);
    }else {
        return  CGSizeMake(SCREEN_WIDTH, 76);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionview.tag == 0) {
       
        SearchArtistModel *artistObject = [model.ownArtistArray objectAtIndex:indexPath.row];
        [self getDetailOfArtist:artistObject.ast_id];

    }else {
        ArtworkModel *artObject = [model.ownArtworkArray objectAtIndex:indexPath.row];
        [self getDetailOfArtwork:artObject.art_id];

    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (![string isEqualToString:@""]) {
        isSearchOn = true;
        if (collectionview.tag == 0) {
            [self getArtistfromMyArt:textField.text];
        }else {
            [self getArtworksFromMyArt:textField.text];
        }
    }
    return true;
}


#pragma mark - Web Services

- (void)getArtistfromMyArt:(NSString *)keyWord {

    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setValue:keyWord forKey:@"key"];
    [dict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"usr_id"] forKey:@"usr_id"];
    
    WebServices *service = [[WebServices alloc] init];
    service.delegate = self;
    [service SendRequestForPostData:dict andServiceURL:@"/own/artists" andServiceReturnType:@"OwnaAtists"];

}

- (void)getArtworksFromMyArt:(NSString *)keyWord {
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setValue:keyWord forKey:@"key"];
    [dict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"usr_id"] forKey:@"usr_id"];
    
    WebServices *service = [[WebServices alloc] init];
    service.delegate = self;
    [service SendRequestForPostData:dict andServiceURL:@"/own/artworks" andServiceReturnType:@"OwnaArtworks"];
    
}

        // Artsit Detail Service
- (void)getDetailOfArtist:(NSString *)artsit_id {
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setValue:artsit_id forKey:@"ast_id"];
    
    WebServices *service = [[WebServices alloc] init];
    service.delegate = self;
    [service SendRequestForPostData:dict andServiceURL:@"/artist/detail" andServiceReturnType:@"ArtistDetail"];
    
}


        // Artwork Detail Service
- (void)getDetailOfArtwork:(NSString *)artsit_id {
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setValue:artsit_id forKey:@"art_id"];
    
    WebServices *service = [[WebServices alloc] init];
    service.delegate = self;
    [service SendRequestForPostData:dict andServiceURL:@"/art/detail" andServiceReturnType:@"ArtworkDetail"];
    
}

// Web Service Delegate

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

    [MBProgressHUD hideHUDForView:[[[UIApplication sharedApplication] delegate] window] animated:true];
    if ([responseType isEqualToString:@"OwnaArtworks"]) {
        if (!isSearchOn) {
            [self getArtistfromMyArt:@""]; // get own artist list
        }else {
            isSearchOn = false;
            [collectionview reloadData];
        }
    }else if ([responseType isEqualToString:@"ArtistDetail"]) {
        
        // send to Artsit detail Page to show artist detail
        ArtistViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ArtistViewController"];
        vc.isArtsit = true;
        [self.navigationController pushViewController:vc animated:true];
        
    }else if ([responseType isEqualToString:@"ArtworkDetail"]) {
        
        // send to Artwork detail Page to show Artwork detail
        ArtistViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ArtistViewController"];
        vc.isArtsit = false;
        [self.navigationController pushViewController:vc animated:true];

//        ArtWorkViewController *artvc = [self.storyboard instantiateViewControllerWithIdentifier:@"ArtWorkViewController"];
//        [self.navigationController pushViewController:artvc animated:true];
        
    }else {
        // reload collectionview after getting all data of both services own artist, own artwork
        [collectionview reloadData];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
