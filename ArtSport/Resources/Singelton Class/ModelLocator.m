//
//  ModelLocator.m
//  ArtSport
//
//  Created by Toqir Ahmad on 16/01/17.
//  Copyright (c) 2015 Rac. All rights reserved.
//

#import "ModelLocator.h"

static ModelLocator *instance = nil;

@implementation ModelLocator

@synthesize url;

+(ModelLocator*) getInstance{
    
    @synchronized(self)
    {
        if (!instance)
        {
            instance=[[self alloc] init];
            return instance;
        }
    }
    
    return instance;
}

+(id)alloc
{
    @synchronized([ModelLocator class])
    {
        NSAssert(instance == nil, @"Attempted to allocate a second instance of a singleton.");
        instance = [super alloc];
        return instance;
    }
    return nil;
}

-(id)init
{
    self = [super init];
    if (self != nil)
    {
        url=@"http://artspotonline.com/api"; // Live
    }
    return self;
}



@end
