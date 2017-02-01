//
//  RelatedWorkTableViewCell.h
//  ArtSport
//
//  Created by Toqir Ahmad on 02/01/2017.
//  Copyright © 2017 Toqir Ahmad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RelatedWorkTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UICollectionView *collectionview;
@property (nonatomic, weak) IBOutlet UILabel *lblTitle;

@property (nonatomic, weak) IBOutlet UIButton *leftBtn;
@property (nonatomic, weak) IBOutlet UIButton *rightBtn;


@end
