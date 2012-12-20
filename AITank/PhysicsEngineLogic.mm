//
//  PhysicsEngineLogic.m
//  HockeyGame
//
//  Created by jason on 12-11-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PhysicsEngineLogic.h"
//#import "GameManager.h"

@implementation PhysicsEngineLogic

- (id) init{
    if (self = [super init]){
        [self initGame];
    }
    return  self;
}

- (void) initGame
{
    _gameData = [GameData Instance];
    [self initPhysics];
}

-(void) PhysicsStep:(ccTime) dt
{
	//It is recommended that a fixed time step is used with Box2D for stability
	//of the simulation, however, we are using a variable time step here.
	//You need to make an informed choice, the following URL is useful
	//http://gafferongames.com/game-physics/fix-your-timestep/
	
	int32 velocityIterations = 8;
	int32 positionIterations = 1;
	
	// Instruct the world to perform a single step of simulation. It is
	// generally best to keep the time step and iterations fixed.
	_world->Step(dt, velocityIterations, positionIterations);	
    
    //map position to gameData
    b2Vec2 pos  = _bodyBall->GetPosition();
	
	float x = pos.x * PTM_RATIO;
	float y = pos.y * PTM_RATIO;
    
    _gameData.ball.position = CGPointMake(x, y);
}

-(void) initPhysics
{

	CGSize s = _gameData.gameField.rect.size;
	
	b2Vec2 gravity;
	gravity.Set(0.0f, -10.0f);
	_world = new b2World(gravity);
	
	
	// Do we want to let bodies sleep?
	_world->SetAllowSleeping(true);
	_world->SetContinuousPhysics(true);
   
	
	// Define the ground body.
	b2BodyDef groundBodyDef;
	groundBodyDef.position.Set(0, 0); // bottom-left corner
	
	// Call the body factory which allocates memory for the ground body
	// from a pool and creates the ground box shape (also from a pool).
	// The body is also added to the world.
	b2Body* groundBody = _world->CreateBody(&groundBodyDef);
	
	// Define the ground box shape.
	b2EdgeShape groundBox;		
	
	// bottom
	
	groundBox.Set(b2Vec2(0,0), b2Vec2(s.width/PTM_RATIO,0));
	groundBody->CreateFixture(&groundBox,0);
	
	// top
	groundBox.Set(b2Vec2(0,s.height/PTM_RATIO), b2Vec2(s.width/PTM_RATIO,s.height/PTM_RATIO));
	groundBody->CreateFixture(&groundBox,0);
	
	// left
	groundBox.Set(b2Vec2(0,s.height/PTM_RATIO), b2Vec2(0,0));
	groundBody->CreateFixture(&groundBox,0);
	
	// right
	groundBox.Set(b2Vec2(s.width/PTM_RATIO,s.height/PTM_RATIO), b2Vec2(s.width/PTM_RATIO,0));
	groundBody->CreateFixture(&groundBox,0);
    
    
    //--------------------------Ball
    // Create ball body and shape
    b2BodyDef ballBodyDef;
    ballBodyDef.type = b2_dynamicBody;
    ballBodyDef.position.Set(100/PTM_RATIO, 100/PTM_RATIO);
    ballBodyDef.bullet = true;
    ballBodyDef.userData = (__bridge void *)_gameData.ball;
    _bodyBall = _world->CreateBody(&ballBodyDef);
    
    b2CircleShape circle;
    circle.m_radius = 11.5/PTM_RATIO;
    
    b2FixtureDef ballShapeDef;
    ballShapeDef.shape = &circle;
    ballShapeDef.density = 1.0f;
    ballShapeDef.friction = 0.2f;
    ballShapeDef.restitution = 0.8f;
    _bodyBall->CreateFixture(&ballShapeDef);
    
    b2Vec2 force = b2Vec2(10,10);
    _bodyBall->ApplyLinearImpulse(force, ballBodyDef.position);
    
}


-(void) dealloc
{
	delete _world;
	_world = NULL;
    
//    delete m_debugDraw;
//	m_debugDraw = NULL;
}

@end
