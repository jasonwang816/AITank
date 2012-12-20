//
//  PlayerInfo.m
//  HockeyGame
//
//  Created by jason on 12-11-16.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PlayerInfo.h"

@implementation PlayerInfo

@synthesize playerID = _playerID;
@synthesize name = _name;

//- (id) initWithName:(NSString*)theName AndPosition:(CGPoint)thePosition
//{
//    self = [super init];
//    if (self)
//    {
//        _name = theName;
//        _position = thePosition;
//    }
//    return self;
//}

- (id) initWithID:(int)theID AndName:(NSString*)theName AndPosition:(CGPoint)thePosition
{
    self = [super initWithPosition:thePosition AndAngle:0];
    if (self)
    {
        _playerID = theID;
        _name = theName;
    }
    return self;
}

@end
