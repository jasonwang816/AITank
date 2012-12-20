//
//  GameData.h
//  HockeyGame
//
//  Created by jason on 12-11-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/NSDictionary.h>
#import "GameField.h"
#import "GameViewPort.h"
#import "PlayerInfo.h"

@interface GameData : NSObject{
    GameField * _gameField;
    GameViewPort * _gameViewPort;
    NSMutableDictionary * _players;
}

@property (strong) GameField * gameField;
@property (strong) GameViewPort * gameViewPort;

@property (strong) GameItem * ball;
@property (strong) NSMutableDictionary * players;

+ (id)Instance;

@end
