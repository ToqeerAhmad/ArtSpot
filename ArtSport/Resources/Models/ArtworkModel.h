//
//  ArtworkModel.h
//  ArtSport
//
//  Created by Toqir Ahmad on 18/01/2017.
//  Copyright © 2017 Toqir Ahmad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArtworkModel : NSObject

@property (nonatomic, copy) NSString *art_id;
@property (nonatomic, copy) NSString *ast_id;
@property (nonatomic, copy) NSString *art_dimension;
@property (nonatomic, copy) NSString *art_image;
@property (nonatomic, copy) NSString *art_date;
@property (nonatomic, copy) NSString *art_medium;
@property (nonatomic, copy) NSString *art_location;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *updated_at;
@property (nonatomic, copy) NSString *del_flg;
@property (nonatomic, copy) NSString *art_title;


@end
