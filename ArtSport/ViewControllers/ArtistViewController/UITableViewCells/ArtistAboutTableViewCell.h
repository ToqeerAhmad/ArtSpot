//
//  ArtistAboutTableViewCell.h
//  ArtSport
//
//  Created by Toqir Ahmad on 02/01/2017.
//  Copyright © 2017 Toqir Ahmad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArtistAboutTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *nameLableTopConstraint;
@property (nonatomic, weak) IBOutlet UIButton *backBtn;
@property (nonatomic, weak) IBOutlet UIImageView *artistImageView;
@property (nonatomic, weak) IBOutlet UILabel *lblArtistName;
@property (nonatomic, weak) IBOutlet UILabel *lblArtist;
@property (nonatomic, weak) IBOutlet UILabel *lblArtistPeriod;

@property (nonatomic, weak) IBOutlet UIButton *showImageBtn;

@end
