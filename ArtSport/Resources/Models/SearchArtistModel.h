//
//  SearchArtistModel.h
//  ArtSport
//
//  Created by Toqir Ahmad on 17/01/2017.
//  Copyright © 2017 Toqir Ahmad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchArtistModel : NSObject

@property (nonatomic, copy) NSString *ast_id;
@property (nonatomic, copy) NSString *ast_name;
@property (nonatomic, copy) NSString *ast_bio;
@property (nonatomic, copy) NSString *ast_duration;
@property (nonatomic, copy) NSString *ast_photo;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *updated_at;
@property (nonatomic, copy) NSString *del_flg;

@end
