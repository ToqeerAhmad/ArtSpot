//
//  JsonParser.h
//  Abeona
//
//  Created by Toqir Ahmad on 12/01/2017.
//  Copyright © 2017 Toqir Ahmad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonParser : NSObject

- (void)parseSearchArtsitResponseData:(NSMutableArray *)responseArray;
- (void)parseProfileData:(NSDictionary *)dict;
- (void)praseOwnaAtistsData:(NSMutableArray *)responseArray;
- (void)praseOwnaArtWorkData:(NSMutableArray *)responseArray;
- (void)parseArtistDetailData:(NSDictionary *)responseDict;
- (void)parseArtWorkDetail:(NSDictionary *)dict;
- (void)parseRelatedArtworkData:(NSMutableArray *)reponseArray;
- (void)parseRelatedArtistData:(NSMutableArray *)reponseArray;
- (void)parseBookArray:(NSMutableArray *)responseArray;
- (void)parseBookDetail:(NSDictionary *)responseDict;

@end
