//
//  DisplayItem.m
//  AITank
//
//  Created by jason on 12-10-30.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DisplayItem.h"

@implementation DisplayItem

@synthesize imagePath = _imagePath;
@synthesize position = _position;
@synthesize angle = _angle;
@synthesize sprite = _sprite;

- (id) initWithImage:(NSString *)image AndPosition:(CGPoint)pos AndAngle:(float)ang
{
    self = [super init];
    if (self)
    {
        _imagePath = image;
        _position = pos;
        _angle = ang;
        _sprite = [CCSprite spriteWithFile:image];

    }
    return self;
}

- (id) initWithImage:(NSString *)image AndPosition:(CGPoint)pos AndAngle:(float)ang AndSize:(CGRect)rect
{
    self = [super init];
    if (self)
    {
        _imagePath = image;
        _position = pos;
        _angle = ang;
        _sprite = [CCSprite spriteWithFile:image rect:CGRectMake(0, 0, 60, 60)];
        
    }
    return self;
}

@end
