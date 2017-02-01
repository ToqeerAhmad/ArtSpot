//
//  UITextFieldFontClass.m
//  ArtSport
//
//  Created by Toqir Ahmad on 30/12/2016.
//  Copyright © 2016 Toqir Ahmad. All rights reserved.
//

#import "UITextFieldFontClass.h"

@implementation UITextFieldFontClass


- (void)awakeFromNib {
    [super awakeFromNib];
    
    if (self.tag == 3) {
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
        self.leftView = paddingView;
        self.leftViewMode = UITextFieldViewModeAlways;

        self.layer.cornerRadius = 15;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.borderWidth = 1;
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
        lbl.text = @"";
        lbl.textColor = [UIColor lightGrayColor];
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.font = [UIFont fontWithName:@"FontAwesome" size:14];
        [paddingView addSubview:lbl];
    }else {
        self.layer.cornerRadius = 3;
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 20)];
        self.leftView = paddingView;
        self.leftViewMode = UITextFieldViewModeAlways;
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
