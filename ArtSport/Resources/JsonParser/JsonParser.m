//
//  JsonParser.m
//  Abeona
//
//  Created by Toqir Ahmad on 12/01/2017.
//  Copyright © 2017 Toqir Ahmad. All rights reserved.
//

#import "JsonParser.h"

@implementation JsonParser

                            // User Profile Data Parsing
- (void)parseProfileData:(NSDictionary *)dict {
    
    ModelLocator *model = [ModelLocator getInstance];
    model.userID = [dict objectForKey:@"usr_id"];
    model.firstName = [dict objectForKey:@"usr_fname"];
    model.lastName = [dict objectForKey:@"usr_lname"];
    model.email = [dict objectForKey:@"usr_email"];
    
    [[NSUserDefaults standardUserDefaults] setValue:model.userID forKey:@"usr_id"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}


                     // Search Results For Artists Data Parsing

- (void)parseSearchArtsitResponseData:(NSMutableArray *)responseArray {
    
    ModelLocator *model = [ModelLocator getInstance];
    model.artistResultArray = [NSMutableArray new];
    
    for (NSDictionary *dict in responseArray) {
        
        SearchArtistModel *artistObject = [SearchArtistModel new];
        artistObject.ast_id = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"ast_id"]];
        artistObject.ast_name = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"ast_name"]];
        artistObject.ast_bio = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"ast_bio"]];
        artistObject.ast_duration = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"ast_duration"]];
        artistObject.ast_photo = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"ast_photo"]];
        artistObject.created_at = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"created_at"]];
        artistObject.updated_at = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"updated_at"]];
        artistObject.del_flg = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"del_flg"]];
        [model.artistResultArray addObject:artistObject];
    }
    
}


                    // Owna Atists Data Parsing

- (void)praseOwnaAtistsData:(NSMutableArray *)responseArray {
    
    ModelLocator *model = [ModelLocator getInstance];
    model.ownArtistArray = [NSMutableArray new];
    
    for (NSDictionary *dict in responseArray) {
        
        SearchArtistModel *artistObject = [SearchArtistModel new];
        artistObject.ast_id = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"ast_id"]];
        artistObject.ast_name = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"ast_name"]];
        artistObject.ast_bio = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"ast_bio"]];
        artistObject.ast_duration = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"ast_duration"]];
        artistObject.ast_photo = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"ast_photo"]];
        artistObject.created_at = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"created_at"]];
        artistObject.updated_at = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"updated_at"]];
        artistObject.del_flg = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"del_flg"]];
        [model.ownArtistArray addObject:artistObject];
    }
    
}

                    // Owna ArtWork Data Parsing

- (void)praseOwnaArtWorkData:(NSMutableArray *)responseArray {
    
    ModelLocator *model = [ModelLocator getInstance];
    model.ownArtworkArray = [NSMutableArray new];

    for (NSDictionary *dict in responseArray) {
        
        ArtworkModel *artworkObject = [ArtworkModel new];
        artworkObject.ast_id = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"ast_id"]];
        artworkObject.art_title = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"art_title"]];
        artworkObject.art_id = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"art_id"]];
        artworkObject.art_dimension = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"art_dimension"]];
        artworkObject.art_dimension = [artworkObject.art_dimension stringByReplacingOccurrencesOfString:@"inch wide" withString:@""];
        artworkObject.art_dimension = [artworkObject.art_dimension stringByReplacingOccurrencesOfString:@"inch high" withString:@""];
        artworkObject.art_date = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"art_date"]];
        artworkObject.art_medium = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"art_medium"]];
        artworkObject.art_location = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"art_location"]];
        artworkObject.art_image = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"art_image"]];
        artworkObject.created_at = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"created_at"]];
        artworkObject.updated_at = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"updated_at"]];
        artworkObject.del_flg = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"del_flg"]];
        [model.ownArtworkArray addObject:artworkObject];
    }
}

                // Artist Detail Data Parsing

- (void)parseArtistDetailData:(NSDictionary *)responseDict {
    
    ModelLocator *model = [ModelLocator getInstance];
    model.artistDetail = [SearchArtistModel new];
    model.artistDetail.ast_id = [ApplicationHelper checkforNullvalue:[responseDict valueForKey:@"ast_id"]];
    model.artistDetail.ast_name = [ApplicationHelper checkforNullvalue:[responseDict valueForKey:@"ast_name"]];
    model.artistDetail.ast_bio = [ApplicationHelper checkforNullvalue:[responseDict valueForKey:@"ast_bio"]];
    model.artistDetail.ast_duration = [ApplicationHelper checkforNullvalue:[responseDict valueForKey:@"ast_duration"]];
    model.artistDetail.ast_photo = [ApplicationHelper checkforNullvalue:[responseDict valueForKey:@"ast_photo"]];
    model.artistDetail.created_at = [ApplicationHelper checkforNullvalue:[responseDict valueForKey:@"created_at"]];
    model.artistDetail.updated_at = [ApplicationHelper checkforNullvalue:[responseDict valueForKey:@"updated_at"]];
    model.artistDetail.del_flg = [ApplicationHelper checkforNullvalue:[responseDict valueForKey:@"del_flg"]];
}

- (void)parseArtWorkDetail:(NSDictionary *)dict {
    
    ModelLocator *model = [ModelLocator getInstance];
    model.artworkDetail = [ArtworkModel new];
    
    model.artworkDetail.ast_id = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"ast_id"]];
    model.artworkDetail.art_title = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"art_title"]];
    model.artworkDetail.art_id = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"art_id"]];
    model.artworkDetail.art_dimension = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"art_dimension"]];
    model.artworkDetail.art_dimension = [model.artworkDetail.art_dimension stringByReplacingOccurrencesOfString:@"inch wide" withString:@""];
    model.artworkDetail.art_dimension = [model.artworkDetail.art_dimension stringByReplacingOccurrencesOfString:@"inch high" withString:@""];

    model.artworkDetail.art_date = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"art_date"]];
    model.artworkDetail.art_medium = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"art_medium"]];
    model.artworkDetail.art_location = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"art_location"]];
    model.artworkDetail.art_image = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"art_image"]];
    model.artworkDetail.created_at = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"created_at"]];
    model.artworkDetail.updated_at = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"updated_at"]];
    model.artworkDetail.del_flg = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"del_flg"]];

}

- (void)parseRelatedArtworkData:(NSMutableArray *)reponseArray {
    
    ModelLocator *model = [ModelLocator getInstance];
    model.relatedArtWorkArray = [NSMutableArray new];
    
    for (NSDictionary *dict in reponseArray) {
        
        ArtworkModel *artworkObject = [ArtworkModel new];
        artworkObject.ast_id = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"ast_id"]];
        artworkObject.art_title = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"art_title"]];
        artworkObject.art_id = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"art_id"]];
        artworkObject.art_dimension = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"art_dimension"]];
        artworkObject.art_dimension = [artworkObject.art_dimension stringByReplacingOccurrencesOfString:@"inch wide" withString:@""];
        artworkObject.art_dimension = [artworkObject.art_dimension stringByReplacingOccurrencesOfString:@"inch high" withString:@""];
        artworkObject.art_date = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"art_date"]];
        artworkObject.art_medium = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"art_medium"]];
        artworkObject.art_location = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"art_location"]];
        artworkObject.art_image = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"art_image"]];
        artworkObject.created_at = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"created_at"]];
        artworkObject.updated_at = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"updated_at"]];
        artworkObject.del_flg = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"del_flg"]];
        [model.relatedArtWorkArray addObject:artworkObject];
    }
}

- (void)parseRelatedArtistData:(NSMutableArray *)reponseArray {
    
    ModelLocator *model = [ModelLocator getInstance];
    model.relatedArtistArray = [NSMutableArray new];
    
    for (NSDictionary *dict in reponseArray) {
        
        SearchArtistModel *artistObject = [SearchArtistModel new];
        artistObject.ast_id = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"ast_id"]];
        artistObject.ast_name = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"ast_name"]];
        artistObject.ast_bio = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"ast_bio"]];
        artistObject.ast_duration = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"ast_duration"]];
        artistObject.ast_photo = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"ast_photo"]];
        artistObject.created_at = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"created_at"]];
        artistObject.updated_at = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"updated_at"]];
        artistObject.del_flg = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"del_flg"]];
        [model.relatedArtistArray addObject:artistObject];
    }
}

- (void)parseBookArray:(NSMutableArray *)responseArray {
    
    ModelLocator *model = [ModelLocator getInstance];
    model.booksArray = [NSMutableArray new];
    
    for (NSDictionary *dict in responseArray) {
        
        BookModel *bookObject = [BookModel new];
        
        bookObject.ast_id = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"ast_id"]];
        bookObject.del_flg = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"del_flg"]];
        bookObject.book_buy_url = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"book_buy_url"]];
        bookObject.created_at = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"created_at"]];
        bookObject.book_id = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"book_id"]];
        bookObject.book_author = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"book_author"]];
        bookObject.book_image = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"book_image"]];
        bookObject.book_cost = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"book_cost"]];
        bookObject.updated_at = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"updated_at"]];
        bookObject.book_desc = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"book_desc"]];
        bookObject.book_title = [ApplicationHelper checkforNullvalue:[dict valueForKey:@"book_title"]];
        [model.booksArray addObject:bookObject];
    }
}

- (void)parseBookDetail:(NSDictionary *)responseDict {
    
    ModelLocator *model = [ModelLocator getInstance];
    model.bookDetail = [BookModel new];
    
    model.bookDetail.ast_id = [ApplicationHelper checkforNullvalue:[responseDict valueForKey:@"ast_id"]];
    model.bookDetail.del_flg = [ApplicationHelper checkforNullvalue:[responseDict valueForKey:@"del_flg"]];
    model.bookDetail.book_buy_url = [ApplicationHelper checkforNullvalue:[responseDict valueForKey:@"book_buy_url"]];
    model.bookDetail.created_at = [ApplicationHelper checkforNullvalue:[responseDict valueForKey:@"created_at"]];
    model.bookDetail.book_id = [ApplicationHelper checkforNullvalue:[responseDict valueForKey:@"book_id"]];
    model.bookDetail.book_author = [ApplicationHelper checkforNullvalue:[responseDict valueForKey:@"book_author"]];
    model.bookDetail.book_image = [ApplicationHelper checkforNullvalue:[responseDict valueForKey:@"book_image"]];
    model.bookDetail.book_cost = [ApplicationHelper checkforNullvalue:[responseDict valueForKey:@"book_cost"]];
    model.bookDetail.updated_at = [ApplicationHelper checkforNullvalue:[responseDict valueForKey:@"updated_at"]];
    model.bookDetail.book_desc = [ApplicationHelper checkforNullvalue:[responseDict valueForKey:@"book_desc"]];
    model.bookDetail.book_title = [ApplicationHelper checkforNullvalue:[responseDict valueForKey:@"book_title"]];

}

@end
