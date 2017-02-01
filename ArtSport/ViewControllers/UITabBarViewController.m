//
//  UITabBarViewController.m
//  ArtSport
//
//  Created by Toqir Ahmad on 31/12/2016.
//  Copyright © 2016 Toqir Ahmad. All rights reserved.
//

#import "UITabBarViewController.h"

@implementation UITabBarViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.tintColor = [UIColor blackColor];
    for(UITabBarItem * tabBarItem in self.items){
        tabBarItem.title = @"";
        tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
