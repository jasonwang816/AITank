//
//  PhysicsEngineLogic.h
//  HockeyGame
//
//  Created by jason on 12-11-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameData.h"
#import "cocos2d.h"
#import "Box2D.h"

#define PTM_RATIO 32
const static float FIXED_TIME_STEP = 1.f/60.f;

@interface PhysicsEngineLogic : NSObject{
    
	float fixedTimestepAccumulator_;
	float fixedTimestepAccumulatorRatio_;
	float velocityIterations_, positionIterations_;  
    
    //GameManager * _gameManager;
    GameData * _gameData;
    b2World * _world;
    b2Body * _bodyBall;
    b2Body * _bodyPlayer; 
}

//@property (nonatomic) GameManager * gameManager;
-(void) PhysicsStep : (ccTime) dt;
-(void) initPhysics;
-(void) initGame;

-(b2World*) getWorld;
-(void) update:(float) dt;
-(void) singleStep: (float)dt;
-(void) smoothStates;
-(void) resetSmoothStates;

-(void) LinearForceOnTheBall:(CGPoint) dest;

@end

