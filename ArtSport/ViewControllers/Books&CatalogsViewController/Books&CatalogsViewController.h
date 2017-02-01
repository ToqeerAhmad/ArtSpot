//
//  Books&CatalogsViewController.h
//  ArtSport
//
//  Created by Toqir Ahmad on 04/01/2017.
//  Copyright © 2017 Toqir Ahmad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Books_CatalogsViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionview;
@property (nonatomic, weak) IBOutlet UIButton *backBtn;
@property (nonatomic, weak) IBOutlet UIButton *bookMarkBtn;

@property (nonatomic, weak) IBOutlet UIImageView *bookImageView;
@property (nonatomic, weak) IBOutlet UILabel *lblTitle;
@property (nonatomic, weak) IBOutlet UILabel *lblAuthorName;
@property (nonatomic, weak) IBOutlet UILabel *lblDate;
@property (nonatomic, weak) IBOutlet UILabel *lblCost;
@property (nonatomic, weak) IBOutlet UILabel *lblDescription;
@property (nonatomic) BOOL isFromLibrary;
@property (nonatomic, strong) NSString *artistID;

@end
