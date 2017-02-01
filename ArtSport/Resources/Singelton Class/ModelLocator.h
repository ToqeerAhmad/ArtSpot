//
//  ModelLocator.h
//  Bark'n'Borrow
//
//  Created by Fahad Khan on 4/27/15.
//  Copyright (c) 2015 Rac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArtworkModel.h"
#import "BookModel.h"

@interface ModelLocator : NSObject

@property(nonatomic,retain)NSString *url;

@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *email;

@property (strong, nonatomic) SearchArtistModel *artistDetail;
@property (strong, nonatomic) ArtworkModel *artworkDetail;
@property (strong, nonatomic) BookModel *bookDetail;

@property (strong, nonatomic) NSMutableArray *artistResultArray;
@property (strong, nonatomic) NSMutableArray *ownArtistArray;
@property (strong, nonatomic) NSMutableArray *ownArtworkArray;

@property (strong, nonatomic) NSMutableArray *relatedArtistArray;
@property (strong, nonatomic) NSMutableArray *relatedArtWorkArray;
@property (strong, nonatomic) NSMutableArray *booksArray;


+(ModelLocator*) getInstance;

@end
