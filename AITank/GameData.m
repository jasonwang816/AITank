//
//  GameData.m
//  HockeyGame
//
//  Created by jason on 12-11-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameData.h"

@implementation GameData

@synthesize gameField = _gameField;
@synthesize gameViewPort = _gameViewPort;
@synthesize players = _players;
@synthesize ball;

+ (id)Instance{
    static GameData * data = nil;
    static dispatch_once_t dataToken;
    
    dispatch_once(&dataToken, ^{
        data = [[self alloc] init];
    });
    
    return data;
}

- (id) init{
    if (self = [super init]){
        CGFloat width = 320;
        CGFloat height = 460;
        
        _gameField = [[GameField alloc] initWithRect:CGRectMake(0, 0, width, height)];
        _gameViewPort = [[GameViewPort alloc]  initWithRect:CGRectMake(0, 0, width, height)];
        _players = [[NSMutableDictionary alloc] init];
        
        ball = [[GameItem alloc] initWithPosition:CGPointMake(100, 100) AndAngle:0];
        PlayerInfo *aPlayer = [[PlayerInfo alloc] initWithID:1 AndName:@"1" AndPosition:CGPointMake(100, 100)];
        
        [_players setObject:aPlayer forKey:aPlayer.name];
    }
    return  self;
}

@end
