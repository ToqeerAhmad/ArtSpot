//
//  UILabelFontClass.m
//  ArtSport
//
//  Created by Toqir Ahmad on 30/12/2016.
//  Copyright © 2016 Toqir Ahmad. All rights reserved.
//


#import "UILabelFontClass.h"

@implementation UILabelFontClass

- (void)awakeFromNib {
    [super awakeFromNib];
    
    float size = SCREEN_WIDTH / 414 * self.font.pointSize;
    [self setFont:[UIFont fontWithName:self.font.fontName size:size]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
