//
//  CollectionViewCell.h
//  ArtSport
//
//  Created by Toqir Ahmad on 31/12/2016.
//  Copyright © 2016 Toqir Ahmad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UIImageView *artWorkImageView;
@property (nonatomic, weak) IBOutlet UILabel *labelArName;
@property (nonatomic, weak) IBOutlet UILabel *labelArt_location;
@property (nonatomic, weak) IBOutlet UILabel *labelArt_Detail;

@end
