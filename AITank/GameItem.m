//
//  GameItem.m
//  HockeyGame
//
//  Created by jason on 12-12-18.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameItem.h"

@implementation GameItem

@synthesize position;
@synthesize angle;

- (id) initWithPosition:(CGPoint)pos AndAngle:(float)ang
{
    self = [super init];
    if (self)
    {
        position = pos;
        angle = ang;
        
    }
    return self;
}

@end
