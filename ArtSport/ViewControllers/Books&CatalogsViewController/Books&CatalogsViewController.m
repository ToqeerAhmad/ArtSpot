//
//  Books&CatalogsViewController.m
//  ArtSport
//
//  Created by Toqir Ahmad on 04/01/2017.
//  Copyright © 2017 Toqir Ahmad. All rights reserved.
//

#import "Books&CatalogsViewController.h"

@interface Books_CatalogsViewController ()
{
    ModelLocator *model;
    UIImage *shareImage;
}
@end

@implementation Books_CatalogsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
 //   self.backBtn.layer.cornerRadius = 25/2;
  //  self.backBtn.layer.masksToBounds = true;
    
    self.bookMarkBtn.layer.cornerRadius = 7;
    self.bookMarkBtn.layer.borderWidth = 1;
    self.bookMarkBtn.layer.borderColor = [UIColor grayColor].CGColor;
    self.bookMarkBtn.layer.masksToBounds = true;
    if (_isFromLibrary) {
        [self getBooksFromLibraryWebService];
        [self.bookMarkBtn setTitle:@"Buy Now" forState:UIControlStateNormal];
        [self.bookMarkBtn addTarget:self action:@selector(buyNowBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }else {
        [self getBooksWebService];
        [self.bookMarkBtn addTarget:self action:@selector(sendToMyLibrary:) forControlEvents:UIControlEventTouchUpInside];
        [self.bookMarkBtn setTitle:@"Send to My Library" forState:UIControlStateNormal];
    }

    model = [ModelLocator getInstance];
    
    [self setBookDetail];
}

- (void)setBookDetail {
    
   
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s%@",ASABooksImageURl,model.bookDetail.book_image]];
    [self.bookImageView setImageWithURL:url usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    shareImage = self.bookImageView.image;
    self.lblCost.text = [NSString stringWithFormat:@"%@ USD",model.bookDetail.book_cost];
//    self.lblDate.text = [NSString stringWithFormat:@"nil"];
    self.lblTitle.text = model.bookDetail.book_title;
    self.lblAuthorName.text = model.bookDetail.book_author;
    self.lblDescription.text = model.bookDetail.book_desc;
    
}

- (IBAction)showImage:(id)sender {
    
    JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
    
    imageInfo.image = self.bookImageView.image;
    // Setup view controller
    JTSImageViewController *imageViewer = [[JTSImageViewController alloc]
                                           initWithImageInfo:imageInfo
                                           mode:JTSImageViewControllerMode_Image
                                           backgroundStyle:JTSImageViewControllerBackgroundOption_Scaled];
    
    // Present the view controller.
    [imageViewer showFromViewController:self transition:JTSImageViewControllerTransition_FromOriginalPosition];
    
}

- (IBAction)showTextView:(id)sender {


}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return model.booksArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HorizontolCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BooksCatalogsCell" forIndexPath:indexPath];
    BookModel *bookObject = [model.booksArray objectAtIndex:indexPath.row];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s%@",ASABooksImageURl,bookObject.book_image]];
    
    [cell.cover_ImageView setImageWithURL:url usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    cell.lblName.text = bookObject.book_title;
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BookModel *bookObject = [model.booksArray objectAtIndex:indexPath.row];
    [self getBooksDetailWebService:bookObject.book_id];
}

- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

- (IBAction)sendToMyLibrary:(id)sender {
    [self sendBookToMyLibraryService];
}

- (IBAction)shareBook:(id)sender {
    

    
    
    UIActivityViewController *activityViewController =
    [[UIActivityViewController alloc] initWithActivityItems:@[model.bookDetail.book_desc,shareImage]
                                      applicationActivities:nil];
    [self presentViewController:activityViewController
                                       animated:YES
                                     completion:^{
                                         // ...
                                     }];

}


// Get Books from library Service

- (void)getBooksFromLibraryWebService {
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"usr_id"] forKey:@"usr_id"];
    
    WebServices *service = [[WebServices alloc] init];
    service.delegate = self;
    [service SendRequestForPostData:dict andServiceURL:@"/own/books" andServiceReturnType:@"GetBooks"];
    
}

// Get Book Detail Service

- (void)getBooksDetailWebService:(NSString *)book_id {
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setValue:book_id forKey:@"book_id"];
    
    WebServices *service = [[WebServices alloc] init];
    service.delegate = self;
    [service SendRequestForPostData:dict andServiceURL:@"/book/detail" andServiceReturnType:@"GetBookDetail"];
}

        // Get Books Array

- (void)getBooksWebService {
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setValue:self.artistID forKey:@"ast_id"];
    [dict setValue:[NSString stringWithFormat:@"0"] forKey:@"from"];
    [dict setValue:[NSString stringWithFormat:@"10"] forKey:@"count"];
    
    WebServices *service = [[WebServices alloc] init];
    service.delegate = self;
    [service SendRequestForPostData:dict andServiceURL:@"/artist/readbooksfromartist" andServiceReturnType:@"GetBooks"];
    
}



        // Send to my library Service

- (void)sendBookToMyLibraryService {
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    
    [dict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"usr_id"] forKey:@"usr_id"];
    [dict setValue:model.bookDetail.book_id forKey:@"book_id"];
    WebServices *service = [[WebServices alloc] init];
    service.delegate = self;
    [service SendRequestForPostData:dict andServiceURL:@"/own/addbook" andServiceReturnType:@"AddBookInLibraray"];
    
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
    if ([responseType isEqualToString:@"AddBookInLibraray"]) {
        [self.bookMarkBtn setTitle:@"Buy Now" forState:UIControlStateNormal];
        [self.bookMarkBtn addTarget:self action:@selector(buyNowBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }else if ([responseType isEqualToString:@"GetBooks"]) {
        [self.collectionview reloadData];
    }else if ([responseType isEqualToString:@"GetBookDetail"]) {
        [self setBookDetail];
    }
    [MBProgressHUD hideHUDForView:[[[UIApplication sharedApplication] delegate] window] animated:true];
    
}

- (IBAction)buyNowBtnAction:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.bookDetail.book_buy_url]];
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
