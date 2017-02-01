//
//  MyLibraryViewController.h
//  ArtSport
//
//  Created by Toqir Ahmad on 09/01/2017.
//  Copyright © 2017 Toqir Ahmad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyLibraryViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *segmentedButtonsHeight;

@property (nonatomic, weak) IBOutlet UIView *segmentedView;
@property (nonatomic, weak) IBOutlet UIButton *artistBtn;
@property (nonatomic, weak) IBOutlet UIButton *artWorkBtn;

@property (nonatomic, weak) IBOutlet UICollectionView *collectionview;

@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray *buttonsArray;


@end
