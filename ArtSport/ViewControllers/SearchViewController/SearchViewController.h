//
//  SearchViewController.h
//  ArtSport
//
//  Created by Toqir Ahmad on 30/12/2016.
//  Copyright © 2016 Toqir Ahmad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property(nonatomic) BOOL searchEnable;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *searchFieldHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *segmentedButtonsHeight;

@property (nonatomic, weak) IBOutlet UITextField *searchField;
@property (nonatomic, weak) IBOutlet UIView *segmentedView;
@property (nonatomic, weak) IBOutlet UIButton *artistBtn;
@property (nonatomic, weak) IBOutlet UIButton *artWorkBtn;

@property (nonatomic, weak) IBOutlet UICollectionView *collectionview;

@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray *buttonsArray;

@end
