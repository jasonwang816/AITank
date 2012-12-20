//
//  PlayerInfo.h
//  HockeyGame
//
//  Created by jason on 12-11-16.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameItem.h"

@interface PlayerInfo : GameItem{
    int _playerID;
    NSString * _name;  

}

@property (nonatomic) int playerID;
@property (nonatomic) NSString * name;

- (id) initWithID:(int)theID AndName:(NSString*)theName AndPosition:(CGPoint)thePosition;
@end
