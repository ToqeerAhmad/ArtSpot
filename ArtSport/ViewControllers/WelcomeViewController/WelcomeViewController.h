//
//  WelcomeViewController.h
//  ArtSport
//
//  Created by Toqir Ahmad on 30/12/2016.
//  Copyright © 2016 Toqir Ahmad. All rights reserved.
//

#import "ViewController.h"

@interface WelcomeViewController : ViewController<UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

@end
