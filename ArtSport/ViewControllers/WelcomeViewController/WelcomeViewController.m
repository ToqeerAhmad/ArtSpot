//
//  WelcomeViewController.m
//  ArtSport
//
//  Created by Toqir Ahmad on 30/12/2016.
//  Copyright © 2016 Toqir Ahmad. All rights reserved.
//

#import "WelcomeViewController.h"
#import "HomeViewController.h"

@interface WelcomeViewController ()
{
    CGRect frame;
    UIImageView *imgView;
    NSMutableArray *images;
}
@end

@implementation WelcomeViewController

@synthesize scrollView,pageControl;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpWalkThroughDesign];
}

-(void) viewDidLayoutSubviews
{
    [scrollView setContentSize:CGSizeMake(SCREEN_WIDTH * images.count, SCREEN_HEIGHT)];
}

-(void)setUpWalkThroughDesign
{
    float pageControlY;
    if (IS_IPHONE_5) {
        pageControlY = SCREEN_HEIGHT - 148;
    }else if (IS_IPHONE_6) {
        pageControlY = SCREEN_HEIGHT - 180;
    }else {
        pageControlY = SCREEN_HEIGHT - 190;
    }
    self.automaticallyAdjustsScrollViewInsets = NO;
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-39)/2, pageControlY, 39, 37)];
    pageControl.numberOfPages = 3;
    images = [[NSMutableArray alloc]initWithObjects: [UIImage imageNamed:@"walkthroughImage"],[UIImage imageNamed:@"walkthroughImage"],[UIImage imageNamed:@"walkthroughImage"], nil];
    
    int numberofViews = (int)[images count];
    
    for (int i = 0; i < numberofViews; i++)
    {
        
        frame.origin.x = [[[UIApplication sharedApplication]delegate]window].frame.size.width * i ;
        frame.origin.y = 0;
        frame.size = [[[UIApplication sharedApplication]delegate]window].frame.size;
        imgView = [[UIImageView alloc] init];
        imgView.frame = frame;
        imgView.image = [images objectAtIndex:i];
        [imgView setUserInteractionEnabled:YES];
        scrollView.pagingEnabled = YES;
        
        
        if (i == 0) {
            
            [self scrollLabelForIndexFirst:@"Welcome to Art Spot!\n This is our beta version."];
            
        }else if(i == 1) {
            
            [self scrollLabelForIndexSecond:@"This beta version serves to\n test the limits of our image recognition technology as well as the ability to link artists, artworks, media,\n and merchandise."];
            
        }else {
            
            [self scrollLabelForIndexThird:@"To begin, simply type an artist's name in\n the search field at the top of the screen."];
            
        }
        [scrollView addSubview:imgView];
    }
    [self.view addSubview:pageControl];
    [self.view bringSubviewToFront:pageControl];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)_scrollView
{
    if( [scrollView isDragging]) {
        CGFloat pageWidth = scrollView.frame.size.width;
        int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        pageControl.currentPage = page;
    }
}

-(void)scrollLabelForIndexFirst:(NSString *)text
{
    float labelY = 90;
    UILabel *label  = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 174.5)/2,labelY,215,36)];
    label.text = text;
    label.textColor = [UIColor blackColor];
    label.font = [UIFont boldSystemFontOfSize:15];
    label.textAlignment = NSTextAlignmentCenter;
    [label setNumberOfLines:2];
    [label sizeToFit];
    [imgView addSubview:label];
    
    labelY = labelY + 36 + 30;
    
    UILabel *label1  = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 301)/2,labelY,301,54)];
    label1.text = @"We are the only universal museum app\n that connects museums around the world\n to each other.";
    label1.textColor = [UIColor blackColor];
    label1.font = [UIFont boldSystemFontOfSize:15];
    label1.textAlignment = NSTextAlignmentCenter;
    [label1 setNumberOfLines:3];
    [label1 sizeToFit];
    [imgView addSubview:label1];
    
    labelY = labelY + 54 + 30;
    
    UILabel *label2  = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 297)/2,labelY,301,90)];
    label2.text = @"With Art Spot, you can search our\n database of thousands of artists and art-\n works and be instantly connected\n to related artworks and artists, as well as\n books, media, prints and merchandise.";
    label2.textColor = [UIColor blackColor];
    label2.font = [UIFont boldSystemFontOfSize:15];
    label2.textAlignment = NSTextAlignmentCenter;
    [label2 setNumberOfLines:5];
    [label2 sizeToFit];
    [imgView addSubview:label2];
}

- (void)scrollLabelForIndexSecond:(NSString *)text {
    

    UILabel *label  = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 283.5)/2,(SCREEN_HEIGHT-220)/2,283.5,90)];
    label.text = text;
    label.textColor = [UIColor blackColor];
    label.font = [UIFont boldSystemFontOfSize:15];
    label.textAlignment = NSTextAlignmentCenter;
    [label setNumberOfLines:5];
    [label sizeToFit];
    [imgView addSubview:label];

}

- (void)scrollLabelForIndexThird:(NSString *)text {
    
    float labelY;
    if (IS_IPHONE_5) {
        labelY = (SCREEN_HEIGHT-280)/2;
    }else if (IS_IPHONE_6) {
        labelY = (SCREEN_HEIGHT-250)/2;
    }else {
        labelY = (SCREEN_HEIGHT-210)/2;
    }
    
    UILabel *label  = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 290)/2, labelY, 290,36)];
    label.text = text;
    label.textColor = [UIColor blackColor];
    label.font = [UIFont boldSystemFontOfSize:15];
    label.textAlignment = NSTextAlignmentCenter;
    [label setNumberOfLines:2];
    [label sizeToFit];
    [imgView addSubview:label];
    
    labelY = labelY + 36 + 15;
    
    UILabel *label1  = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 122.5)/2,labelY,122.5,18)];
    label1.text = @"Let's get started!";
    label1.textColor = [UIColor blackColor];
    label1.font = [UIFont boldSystemFontOfSize:15];
    label1.textAlignment = NSTextAlignmentCenter;
    [label1 setNumberOfLines:1];
    [label1 sizeToFit];
    [imgView addSubview:label1];
    
    labelY = labelY + 18 + 25;
    
    UIButton *balloonBtn  = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 99)/2,labelY,99,110)];
    [balloonBtn setImage:[UIImage imageNamed:@"landing_balloon"] forState:UIControlStateNormal];
    [balloonBtn addTarget:self action:@selector(pushToHomeScreen:) forControlEvents:UIControlEventTouchUpInside];
    [imgView addSubview:balloonBtn];

    labelY = labelY + 110 + 25;

    
    UILabel *label2  = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 233)/2,labelY,233,18)];
    label2.text = @"Tap the balloon to enter Art Spot";
    label2.textColor = [UIColor blackColor];
    label2.font = [UIFont boldSystemFontOfSize:15];
    label2.textAlignment = NSTextAlignmentCenter;
    [label2 setNumberOfLines:1];
    [label2 sizeToFit];
    [imgView addSubview:label2];
    
}

- (IBAction)pushToHomeScreen:(id)sender {
    
    UITabBarController *homeVc = [self.storyboard instantiateViewControllerWithIdentifier:@"TabBarView"];
    [self.navigationController pushViewController:homeVc animated:true];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
