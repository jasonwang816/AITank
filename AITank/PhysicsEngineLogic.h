//
//  PhysicsEngineLogic.h
//  HockeyGame
//
//  Created by jason on 12-11-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameData.h"
//#import <GameKit/GameKit.h>
#import "cocos2d.h"
#import "Box2D.h"

#define PTM_RATIO 32

@interface PhysicsEngineLogic : NSObject{
    //GameManager * _gameManager;
    GameData * _gameData;
    b2World * _world;
    b2Body * _bodyBall;
}

//@property (nonatomic) GameManager * gameManager;
-(void) PhysicsStep : (ccTime) dt;
-(void) initPhysics;
-(void) initGame;

@end
