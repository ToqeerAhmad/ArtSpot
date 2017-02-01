//
//  SearchArtistViewController.h
//  ArtSport
//
//  Created by Toqir Ahmad on 15/01/2017.
//  Copyright © 2017 Toqir Ahmad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchArtistViewController : UIViewController <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UINavigationController *refNavigationController;
@property (nonatomic, weak) IBOutlet UITextField *searchField;
@property (nonatomic, weak) IBOutlet UITableView *searchResultTableView;

@property (nonatomic, weak) IBOutlet UILabel *lblText;

- (void)setReferencedNavigation:(UINavigationController *)refNavCon;

@end
