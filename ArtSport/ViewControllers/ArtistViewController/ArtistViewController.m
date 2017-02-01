//
//  ArtistViewController.m
//  ArtSport
//
//  Created by Toqir Ahmad on 31/12/2016.
//  Copyright © 2016 Toqir Ahmad. All rights reserved.
//

#import "ArtistViewController.h"

@interface ArtistViewController ()
{
    ModelLocator *model;
    int from, count;
    UIImage *shareImage;
}
@end

@implementation ArtistViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    //self.navigationController.tabBarController.selectedIndex = 1;
    // Do any additional setup after loading the view.
    
    from = 0;
    count = 10;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     model = [ModelLocator getInstance];
    [self getRelatedArtistsWebService];
}

- (void)goBack {
    [self.navigationController popViewControllerAnimated:true];
}

#pragma mark - UITableViewDelegates & DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (_isArtsit)
        {
            if (indexPath.row == 0)
            {
                return 290;
            }
            else
            {
                return 93;
            }
        }
        else
        {
            return 362;
        }
    }
    else
    {
        return 125;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0)
    {
        if (_isArtsit)
        {
            return 2;
        }
        return 1;
    }
    else
    {
        if (_isArtsit) {
            return 3;
        }
        return 3;
    }
}

- (IBAction)showImage:(id)sender {
    
    JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
    
    if (_isArtsit) {
        imageInfo.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%s%@",ASArtistImageURl,model.artistDetail.ast_photo]];

    }else {
        imageInfo.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%s%@",ASArtWorkImageURl,model.artworkDetail.art_image]];
    }
    
    // Setup view controller
    JTSImageViewController *imageViewer = [[JTSImageViewController alloc]
                                           initWithImageInfo:imageInfo
                                           mode:JTSImageViewControllerMode_Image
                                           backgroundStyle:JTSImageViewControllerBackgroundOption_Scaled];
    
    // Present the view controller.
    [imageViewer showFromViewController:self transition:JTSImageViewControllerTransition_FromOriginalPosition];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (_isArtsit) {
            if (indexPath.row == 0) {
                
                ArtistAboutTableViewCell *cell = (ArtistAboutTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ArtistCell" forIndexPath:indexPath];
                
                [cell.backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
                NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s%@",ASArtistImageURl,model.artistDetail.ast_photo]];
                [cell.artistImageView setImageWithURL:url usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
                cell.lblArtistName.text = model.artistDetail.ast_name;
                cell.lblArtistPeriod.text = [NSString stringWithFormat:@"(%@)",model.artistDetail.ast_duration];
                [cell.showImageBtn addTarget:self action:@selector(showImage:) forControlEvents:UIControlEventTouchUpInside];
                return cell;
                
            }else {
                ArtistBioTableViewCell *cell = (ArtistBioTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"BioCell" forIndexPath:indexPath];
                cell.lblBio.text = model.artistDetail.ast_bio;
                return cell;
                
            }
        }else {
            
            ArtworkTableViewCell *cell = (ArtworkTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ArtworkCell" forIndexPath:indexPath];
            [cell.backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
            [cell.shareBtn addTarget:self action:@selector(shareArtwork:) forControlEvents:UIControlEventTouchUpInside];

          
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s%@",ASArtWorkImageURl,model.artworkDetail.art_image]];
            
            [cell.showImageBtn addTarget:self action:@selector(showImage:) forControlEvents:UIControlEventTouchUpInside];
            [cell.artworkImageView setImageWithURL:url usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            shareImage = cell.artworkImageView.image;
            cell.lblArt_Title.text = [NSString stringWithFormat:@"%@, %@",model.artworkDetail.art_title, model.artworkDetail.art_date];
            cell.lblArt_medium.text = model.artworkDetail.art_medium;
            cell.lblArt_dimension.text = model.artworkDetail.art_dimension;
            cell.lblArt_location.text = model.artworkDetail.art_location;
            
            return cell;
            
        }
    }else {
        
        RelatedWorkTableViewCell *artWorkCell = (RelatedWorkTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"RelatedWorkCell" forIndexPath:indexPath];
        artWorkCell.collectionview.tag = indexPath.row;
        artWorkCell.leftBtn.tag = indexPath.row;
        artWorkCell.rightBtn.tag = indexPath.row;
        
        [artWorkCell.leftBtn addTarget:self action:@selector(leftBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [artWorkCell.rightBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [artWorkCell.collectionview reloadData];
        
        if (_isArtsit) {
            [self setCollectionViewCellsTitlesForArtist:artWorkCell andIndexPath:indexPath];
        }else {
            [self setCollectionViewCellsTitlesForArtWork:artWorkCell andIndexPath:indexPath];
        }
        
        return artWorkCell;
        
    }
}

- (IBAction)leftBtnAction:(id)sender {
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[sender tag] inSection:1];
    RelatedWorkTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.collectionview.contentOffset.x > 80) {
        cell.collectionview.contentOffset = CGPointMake(cell.collectionview.contentOffset.x - 80.0, cell.collectionview.contentOffset.y);
    }else {
        cell.collectionview.contentOffset = CGPointMake(0.0, cell.collectionview.contentOffset.y);
    }

}

- (IBAction)shareArtwork:(id)sender {
    

    
    UIActivityViewController *activityViewController =
    [[UIActivityViewController alloc] initWithActivityItems:@[model.artworkDetail.art_title, shareImage]
                                      applicationActivities:nil];
    

    [self presentViewController:activityViewController animated:true completion:nil];
    
}


- (IBAction)rightBtnAction:(id)sender {
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[sender tag] inSection:1];
    RelatedWorkTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    NSInteger arrayCount = 0;
    if (_isArtsit) {
        if (indexPath.row == 0) {
            arrayCount = model.relatedArtWorkArray.count;
        }else if (indexPath.row == 1) {
            arrayCount = model.relatedArtistArray.count;
        }else {
            arrayCount = model.booksArray.count;
        }
    }else {
        if (indexPath.row == 0) {
            arrayCount = model.relatedArtWorkArray.count;
        }else if (indexPath.row == 1) {
            arrayCount = model.booksArray.count;
        }else {
            arrayCount = model.relatedArtistArray.count;
        }
    }
    
    NSInteger width = (SCREEN_WIDTH - 50);
    NSInteger offset = arrayCount * 90;
    NSInteger totalOffset = offset - width;
        if (totalOffset > cell.collectionview.contentOffset.x) {
            cell.collectionview.contentOffset = CGPointMake(cell.collectionview.contentOffset.x + 80.0, cell.collectionview.contentOffset.y);
    }
}


            // SetCollectionView Rows Title For Artists

- (void)setCollectionViewCellsTitlesForArtist:(RelatedWorkTableViewCell *)cell andIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0 ) {
        cell.lblTitle.text = [NSString stringWithFormat:@"Artworks by %@",model.artistDetail.ast_name];
    }else if (indexPath.row == 1) {
        cell.lblTitle.text = @"Related Artists";
    }else if (indexPath.row == 2) {
        cell.lblTitle.text = @"Books & Catalogs";
    }
    
}

            // SetCollectionView Rows Title For Artwork


- (void)setCollectionViewCellsTitlesForArtWork:(RelatedWorkTableViewCell *)cell andIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0 ) {
        cell.lblTitle.text = @"Related Artworks";
    }else if (indexPath.row == 1) {
        cell.lblTitle.text = @"Books & Catalogs";
    }else if (indexPath.row == 2) {
        cell.lblTitle.text = @"Related Artists";
    }else if (indexPath.row == 3) {
        cell.lblTitle.text = @"Media";
    }else if (indexPath.row == 4) {
        cell.lblTitle.text = @"Prints";
    }else if (indexPath.row == 5) {
        cell.lblTitle.text = [NSString stringWithFormat:@"More by %@",model.artistDetail.ast_name];
    }
}




- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_isArtsit) {
        if (collectionView.tag == 0) {
            return model.relatedArtWorkArray.count;
        }else if (collectionView.tag == 1) {
            return model.relatedArtistArray.count;
        }else {
            return model.booksArray.count;
        }
    }else {
        if (collectionView.tag == 0) {
            return model.relatedArtWorkArray.count;
        }else if (collectionView.tag == 1) {
            return model.booksArray.count;
        }else if (collectionView.tag == 2) {
            return model.relatedArtistArray.count;
        }else if (collectionView.tag == 3) {
            return 6;
        }else if (collectionView.tag == 4) {
            return 6;
        }else {
            return 6;
        }
    }
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HorizontolCollectionViewCell *cell = (HorizontolCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ArtworkByArtistCell" forIndexPath:indexPath];
    
    if (_isArtsit) {
        [self setCollectionViewCellForArtist:cell andCollectionView:collectionView andIndexPath:indexPath];
    }else {
        [self setCollectionViewCellForArtworks:cell andCollectionView:collectionView andIndexPath:indexPath];
    }
    
    return cell;
    
}

            // set Collection View for Artists

- (void)setCollectionViewCellForArtist:(HorizontolCollectionViewCell *)cell andCollectionView:(UICollectionView *)collectionView andIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView.tag == 0) {
        
        ArtworkModel *artWorkObject = [model.relatedArtWorkArray objectAtIndex:indexPath.row];
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s%@",ASArtWorkImageURl,artWorkObject.art_image]];

        [cell.cover_ImageView setImageWithURL:url usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        cell.lblName.text = artWorkObject.art_title;
        
    }else if (collectionView.tag == 1) {
        
        SearchArtistModel *artistWorkObject = [model.relatedArtistArray objectAtIndex:indexPath.row];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s%@",ASArtistImageURl,artistWorkObject.ast_photo]];
        [cell.cover_ImageView setImageWithURL:url usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        cell.lblName.text = artistWorkObject.ast_name;

    }else if (collectionView.tag == 2) {
        
        BookModel *bookObject = [model.booksArray objectAtIndex:indexPath.row];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s%@",ASABooksImageURl,bookObject.book_image]];

        [cell.cover_ImageView setImageWithURL:url usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        cell.lblName.text = bookObject.book_title;
    }
}

            // set Collection View for Artworks

- (void)setCollectionViewCellForArtworks:(HorizontolCollectionViewCell *)cell andCollectionView:(UICollectionView *)collectionView andIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView.tag == 0) {
        
        ArtworkModel *artWorkObject = [model.relatedArtWorkArray objectAtIndex:indexPath.row];
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s%@",ASArtWorkImageURl,artWorkObject.art_image]];
        
        [cell.cover_ImageView setImageWithURL:url usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        cell.lblName.text = artWorkObject.art_title;
        
    }else if (collectionView.tag == 1) {
        
        BookModel *bookObject = [model.booksArray objectAtIndex:indexPath.row];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s%@",ASABooksImageURl,bookObject.book_image]];
        [cell.cover_ImageView setImageWithURL:url usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        cell.lblName.text = bookObject.book_title;

    }else if (collectionView.tag == 2) {
        
        SearchArtistModel *artistWorkObject = [model.relatedArtistArray objectAtIndex:indexPath.row];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s%@",ASArtistImageURl,artistWorkObject.ast_photo]];
        [cell.cover_ImageView setImageWithURL:url usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        cell.lblName.text = artistWorkObject.ast_name;
        
    }
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    if (_isArtsit) {
        
        if (collectionView.tag == 0) {
            
            ArtworkModel *artWorkObject = [model.relatedArtWorkArray objectAtIndex:indexPath.row];
            [self getDetailOfArtwork:artWorkObject.art_id];
            
        }else if (collectionView.tag == 1) {
            
            SearchArtistModel *artistWorkObject = [model.relatedArtistArray objectAtIndex:indexPath.row];
            [self getDetailOfArtist:artistWorkObject.ast_id];
            
        }else if (collectionView.tag == 2) {
            
            BookModel *obookObject = [model.booksArray objectAtIndex:indexPath.row];
            [self getBooksDetailWebService:obookObject.book_id];
        }

    }else {

        if (collectionView.tag == 0) {
            
            ArtworkModel *artWorkObject = [model.relatedArtWorkArray objectAtIndex:indexPath.row];
            [self getDetailOfArtwork:artWorkObject.art_id];
            
        }else if (collectionView.tag == 1) {
            
            BookModel *obookObject = [model.booksArray objectAtIndex:indexPath.row];
            [self getBooksDetailWebService:obookObject.book_id];
            
        }else if (collectionView.tag == 2) {
            
            SearchArtistModel *artistWorkObject = [model.relatedArtistArray objectAtIndex:indexPath.row];
            [self getDetailOfArtist:artistWorkObject.ast_id];
        }
    }
}

        // Get Related Artists

- (void)getRelatedArtistsWebService {
    NSString *ID = @"";

    if (_isArtsit) {
        ID = [NSString stringWithFormat:@"%@",model.artistDetail.ast_id];
    }else {
        ID = [NSString stringWithFormat:@"%@",model.artworkDetail.ast_id];
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setValue:ID forKey:@"ast_id"];
    [dict setValue:[NSString stringWithFormat:@"%d",from] forKey:@"from"];
    [dict setValue:[NSString stringWithFormat:@"%d",count] forKey:@"count"];
    
    WebServices *service = [[WebServices alloc] init];
    service.delegate = self;
    [service SendRequestForPostData:dict andServiceURL:@"/artist/readrelatedartists" andServiceReturnType:@"RelatedArtists"];
    
}

        // Get Artworks from artists Service

- (void)getArtworksFromArtistsWebService {
    NSString *ID = @"";
    if (_isArtsit) {
        ID = [NSString stringWithFormat:@"%@",model.artistDetail.ast_id];
    }else {
        ID = [NSString stringWithFormat:@"%@",model.artworkDetail.ast_id];
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setValue:ID forKey:@"ast_id"];
    [dict setValue:[NSString stringWithFormat:@"%d",from] forKey:@"from"];
    [dict setValue:[NSString stringWithFormat:@"%d",count] forKey:@"count"];
    
    WebServices *service = [[WebServices alloc] init];
    service.delegate = self;
    [service SendRequestForPostData:dict andServiceURL:@"/artist/readartworksfromartist" andServiceReturnType:@"ArtworksFromArtists"];
    
}

        // Get Books Service

- (void)getBooksWebService {
    NSString *ID = @"";
    if (_isArtsit) {
        ID = [NSString stringWithFormat:@"%@",model.artistDetail.ast_id];
    }else {
        ID = [NSString stringWithFormat:@"%@",model.artworkDetail.ast_id];
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setValue:ID forKey:@"ast_id"];
    [dict setValue:[NSString stringWithFormat:@"%d",from] forKey:@"from"];
    [dict setValue:[NSString stringWithFormat:@"%d",count] forKey:@"count"];
    
    WebServices *service = [[WebServices alloc] init];
    service.delegate = self;
    [service SendRequestForPostData:dict andServiceURL:@"/artist/readbooksfromartist" andServiceReturnType:@"GetBooks"];
    
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
    
    // show error received from Web APi
    [self.navigationController.view makeToast:errorType
                                     duration:3.0
                                     position:CSToastPositionCenter];
    [MBProgressHUD hideHUDForView:[[[UIApplication sharedApplication] delegate] window] animated:true];
}

-(void) webServiceEnd:(id)returnObject andResponseType:(id)responseType {
    
    if ([responseType isEqualToString:@"RelatedArtists"]) {
        [self getArtworksFromArtistsWebService];
    }else if ([responseType isEqualToString:@"ArtworksFromArtists"]) {
        [self getBooksWebService];
    }else if ([responseType isEqualToString:@"GetBooks"]) {
        [self.tableView reloadData];
    }else if ([responseType isEqualToString:@"GetBookDetail"]) {
        Books_CatalogsViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Books_CatalogsViewController"];
        if (_isArtsit) {
            vc.artistID = model.artistDetail.ast_id;
        }else {
            vc.artistID = model.artworkDetail.ast_id;
        }
        [self.navigationController pushViewController:vc animated:true];

    }else if ([responseType isEqualToString:@"ArtworkDetail"]) {
        _isArtsit = false;
        [self getRelatedArtistsWebService];
    }else if ([responseType isEqualToString:@"ArtistDetail"]) {
        _isArtsit = true;
        [self getRelatedArtistsWebService];
    }
    
    [MBProgressHUD hideHUDForView:[[[UIApplication sharedApplication] delegate] window] animated:true];
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
