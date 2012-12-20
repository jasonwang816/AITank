//
//  GameManager.h
//  AITank
//
//  Created by jason on 12-11-14.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameLogic.h"
#import "GameData.h"
#import "PhysicsEngineLogic.h"


@interface GameManager : NSObject{
    
    GameData * _gameData;
    GameLogic * _gameLogic;
    PhysicsEngineLogic * _phyEngineLogic;
}

@property (nonatomic, strong) GameData * gameData;
@property (nonatomic, strong) GameLogic * gameLogic;
@property (nonatomic, strong) PhysicsEngineLogic * phyEngineLogic;

+ (id)gameManager;

-(void) GameUpdate : (ccTime) dt;

@end

