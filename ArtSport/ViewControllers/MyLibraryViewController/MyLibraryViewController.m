//
//  MyLibraryViewController.m
//  ArtSport
//
//  Created by Toqir Ahmad on 09/01/2017.
//  Copyright © 2017 Toqir Ahmad. All rights reserved.
//

#import "MyLibraryViewController.h"

@interface MyLibraryViewController ()
{
    ModelLocator *model;
    NSString *artistID;
}
@end

@implementation MyLibraryViewController

@synthesize buttonsArray,collectionview;

- (void)viewDidLoad {
   
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    model = [ModelLocator getInstance];
    [collectionview registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"artWorkCell"];
}

- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
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
    return model.booksArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BookModel *bookObject = [model.booksArray objectAtIndex:indexPath.row];
    if (collectionview.tag == 0) {
        
        ArtistCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"artistCell" forIndexPath:indexPath];
        cell.labelArtistName.text = bookObject.book_title;
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s%@",ASABooksImageURl,bookObject.book_image]];
        [cell.artistImageView setImageWithURL:url usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];

        return cell;
        
    }else {
        
        CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"artWorkCell" forIndexPath:indexPath];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s%@",ASABooksImageURl,bookObject.book_image]];
        [cell.artWorkImageView setImageWithURL:url usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        cell.labelArName.text = bookObject.book_title;
        cell.labelArt_location.text = @"";;
        cell.labelArt_Detail.text = @"";
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

    BookModel *bookObject = [model.booksArray objectAtIndex:indexPath.row];
    artistID = bookObject.ast_id;
    [self getBooksDetailWebService:bookObject.book_id];
}

// Get Book Detail Service

- (void)getBooksDetailWebService:(NSString *)book_id {
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setValue:book_id forKey:@"book_id"];
    
    WebServices *service = [[WebServices alloc] init];
    service.delegate = self;
    [service SendRequestForPostData:dict andServiceURL:@"/book/detail" andServiceReturnType:@"GetBookDetail"];
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
    Books_CatalogsViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Books_CatalogsViewController"];
    vc.isFromLibrary = true;
    vc.artistID = artistID;
    [self.navigationController pushViewController:vc animated:true];

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
