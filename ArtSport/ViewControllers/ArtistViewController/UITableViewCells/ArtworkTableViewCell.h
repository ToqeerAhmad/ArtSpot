//
//  ArtworkTableViewCell.h
//  ArtSport
//
//  Created by Toqir Ahmad on 04/01/2017.
//  Copyright © 2017 Toqir Ahmad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArtworkTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIButton *backBtn;
@property (nonatomic, weak) IBOutlet UIImageView *artworkImageView;
@property (nonatomic, weak) IBOutlet UILabel *lblArtist_Name;
@property (nonatomic, weak) IBOutlet UILabel *lblArt_dimension;
@property (nonatomic, weak) IBOutlet UILabel *lblArt_Title;
@property (nonatomic, weak) IBOutlet UILabel *lblArt_location;
@property (nonatomic, weak) IBOutlet UILabel *lblArt_medium;

@property (nonatomic, weak) IBOutlet UIButton *showImageBtn;

@property (nonatomic, weak) IBOutlet UIButton *shareBtn;

@end
