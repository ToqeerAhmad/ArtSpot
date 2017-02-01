//
//  ArtworkTableViewCell.m
//  ArtSport
//
//  Created by Toqir Ahmad on 04/01/2017.
//  Copyright © 2017 Toqir Ahmad. All rights reserved.
//

#import "ArtworkTableViewCell.h"

@implementation ArtworkTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
  //  self.backBtn.layer.cornerRadius = 25/2;
   // self.backBtn.layer.masksToBounds = true;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
