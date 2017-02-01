//
//  UIButtonFontClass.m
//  ArtSport
//
//  Created by Toqir Ahmad on 30/12/2016.
//  Copyright © 2016 Toqir Ahmad. All rights reserved.
//

#import "UIButtonFontClass.h"

@implementation UIButtonFontClass


- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.cornerRadius = 3;
    
    if (self.tag == 2) {
        self.layer.cornerRadius = 30/2;
    }
    self.layer.masksToBounds = true;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
