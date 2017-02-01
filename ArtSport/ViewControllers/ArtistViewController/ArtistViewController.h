//
//  ArtistViewController.h
//  ArtSport
//
//  Created by Toqir Ahmad on 31/12/2016.
//  Copyright © 2016 Toqir Ahmad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchArtistModel.h"

@interface ArtistViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic) BOOL isArtsit;
@property (nonatomic, strong) SearchArtistModel *artistObjct;

@end
