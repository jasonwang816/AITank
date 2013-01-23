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

@synthesize ItemType = _itemType;
@synthesize previousAngle = _previousAngle;
@synthesize smoothedAngle = _smoothedAngle;
@synthesize previousPosition = _previousPosition;
@synthesize smoothedPosition = _smoothedPosition;

- (id) initWithPosition:(CGPoint)pos AndAngle:(float)ang
{
    self = [super init];
    if (self)
    {
        position = pos;
        angle = ang;
        
        _previousAngle = ang;
        _smoothedAngle = ang;
        _previousPosition = CGPointMake(pos.x/CONST_PTM_RATIO, pos.y/CONST_PTM_RATIO);
        _smoothedPosition = _previousPosition; 
    }
    return self;
}

@end
