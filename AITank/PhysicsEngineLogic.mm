//
//  PhysicsEngineLogic.m
//  HockeyGame
//
//  Created by jason on 12-11-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PhysicsEngineLogic.h"
//#import "GameManager.h"

const float FIXED_TIMESTEP = 1.0f / 60.f;

@implementation PhysicsEngineLogic

- (id) init{
    if (self = [super init]){
        [self initGame];
    }
    return  self;
}

- (void) initGame
{
    fixedTimestepAccumulator_ = 0;
    fixedTimestepAccumulatorRatio_ = 0;
    velocityIterations_ = 8;
    positionIterations_ = 1;
    
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
	gravity.Set(0.0f, 0.0f);
	_world = new b2World(gravity);
	_world->SetAutoClearForces (false);	
	
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
    ballBodyDef.position.Set(_gameData.ball.position.x/PTM_RATIO, _gameData.ball.position.y/PTM_RATIO);
    //ballBodyDef.bullet = true;
    ballBodyDef.userData = (__bridge void *)_gameData.ball;
    _bodyBall = _world->CreateBody(&ballBodyDef);
    
    b2CircleShape circle;
    circle.m_radius = 5.0f/PTM_RATIO;
    
    b2FixtureDef ballShapeDef;
    ballShapeDef.shape = &circle;
    ballShapeDef.density = 1.0f;
    ballShapeDef.friction = 0.2f;
    ballShapeDef.restitution = 0.8f;
    _bodyBall->CreateFixture(&ballShapeDef);
    _bodyBall->SetLinearDamping(0.1f);
    
    //--------------------------Player
    // Create player body and shape
    
    //b2Body * _bodyPlayer;     
    for(id key in _gameData.players)
    {
        PlayerInfo * item = [_gameData.players objectForKey:key];
        b2BodyDef playerBodyDef;
        playerBodyDef.type = b2_dynamicBody;
        playerBodyDef.position.Set(item.position.x/PTM_RATIO, item.position.y/PTM_RATIO);
        playerBodyDef.userData = (__bridge void *)item;
        _bodyPlayer = _world->CreateBody(&playerBodyDef);
    
        b2CircleShape circle1;
        circle1.m_radius = 15.0f/PTM_RATIO;
    
        b2FixtureDef itemShapeDef;
        itemShapeDef.shape = &circle1;
        itemShapeDef.density = 1.0f;
        itemShapeDef.friction = 0.2f;
        _bodyPlayer->CreateFixture(&itemShapeDef);       
        
        b2PolygonShape dynamicBox;
        float32 phyWidth = 30.0f/PTM_RATIO;
        float32 phyHeight = 2.0f/PTM_RATIO;
        dynamicBox.SetAsBox(phyWidth, phyHeight, b2Vec2(-5.0f/PTM_RATIO, 0), 0);
        
        // Define the dynamic body fixture.
        b2FixtureDef fixtureDef;
        fixtureDef.shape = &dynamicBox;	
        fixtureDef.density = 1.0f;
        fixtureDef.friction = 0.3f;
        _bodyPlayer->CreateFixture(&fixtureDef);
        
        //Track
        b2BodyDef trackBodyDef;
        trackBodyDef.position.Set(200.0f/PTM_RATIO, 100.0f/PTM_RATIO); 
        b2Body* trackBody = _world->CreateBody(&trackBodyDef);
        
        b2EdgeShape trackShape;		
        trackShape.Set(b2Vec2(0,0), b2Vec2(0, s.width/(2*PTM_RATIO)));
        b2FixtureDef trackShapeDef;
        trackShapeDef.shape = &trackShape;
        trackShapeDef.density = 0;
        trackShapeDef.isSensor = true;
        trackBody->CreateFixture(&trackShapeDef);
        
        //Stand
        b2BodyDef standBodyDef;
        standBodyDef.type = b2_dynamicBody;
        standBodyDef.position.Set(200.0f/PTM_RATIO, 100.0f/PTM_RATIO); 
        b2Body* standBody = _world->CreateBody(&standBodyDef);
        
        b2CircleShape standShape;
        standShape.m_radius = 5.0f/PTM_RATIO;
        standBody->CreateFixture(&standShape,0);
        
        b2PrismaticJointDef prismaticJoint;
        prismaticJoint.Initialize(trackBody, standBody, standBody->GetWorldCenter(), b2Vec2(0, 1.0f));
        prismaticJoint.enableLimit = true;
        prismaticJoint.lowerTranslation = 0.0f;
        prismaticJoint.upperTranslation = 1.0f;
        _world->CreateJoint(&prismaticJoint);  
        
        b2WheelJointDef wheeljoint;
        wheeljoint.Initialize(standBody, _bodyPlayer, _bodyPlayer->GetWorldCenter(), b2Vec2(0, 1.0f));

//        wheeljoint.enableLimit = true;
//        wheeljoint.lowerTranslation = 0.0f;
//        wheeljoint.upperTranslation = 1.0f;
        _world->CreateJoint(&wheeljoint);
        
        


    }
    
    

    
    
}

-(void) LinearForceOnTheBall:(CGPoint) dest {
    
    float32 dx = (dest.x - _gameData.ball.position.x)/PTM_RATIO;
    float32 dy = (dest.y - _gameData.ball.position.y)/PTM_RATIO;
    float32 dxy = fabsf(dx) + fabsf(dy);
    
    b2Vec2 force = b2Vec2(dx/(dxy), dy/(dxy));
    _bodyBall->ApplyLinearImpulse(force, _bodyBall->GetPosition());
    
    NSLog(@"dest: X:%f; Y:%f", dest.x, dest.y);
    NSLog(@"_gameData.ball.position: X:%f; Y:%f", _gameData.ball.position.x, _gameData.ball.position.y);
    NSLog(@"_bodyBall->GetPosition(): X:%f; Y:%f", _bodyBall->GetPosition().x, _bodyBall->GetPosition().y);
    
    GameItem * item = [_gameData.players objectForKey:@"1"];
    NSLog(@"_gameData.players.position: X:%f; Y:%f", item.position.x, item.position.y);
    NSLog(@"_bodyPlayer->GetPosition(): X:%f; Y:%f", _bodyPlayer->GetPosition().x, _bodyPlayer->GetPosition().y);
    
}

-(b2World*) getWorld {
	return _world;
}

-(void) update: (float) dt
{
	// Maximum number of steps, to avoid degrading to an halt.
	const int MAX_STEPS = 5;
    
	fixedTimestepAccumulator_ += dt;
	const int nSteps = static_cast<int> (
										 std::floor (fixedTimestepAccumulator_ / FIXED_TIMESTEP)
										 );
	// To avoid rounding errors, touches fixedTimestepAccumulator_ only
	// if needed.
	if (nSteps > 0)
	{
		fixedTimestepAccumulator_ -= nSteps * FIXED_TIMESTEP;
	}
    
	assert (
			"Accumulator must have a value lesser than the fixed time step" &&
			fixedTimestepAccumulator_ < FIXED_TIMESTEP + FLT_EPSILON
			);
	fixedTimestepAccumulatorRatio_ = fixedTimestepAccumulator_ / FIXED_TIMESTEP;
    
	// This is similar to clamp "dt":
	//	dt = std::min (dt, MAX_STEPS * FIXED_TIMESTEP)
	// but it allows above calculations of fixedTimestepAccumulator_ and
	// fixedTimestepAccumulatorRatio_ to remain unchanged.
	const int nStepsClamped = std::min (nSteps, MAX_STEPS);
	for (int i = 0; i < nStepsClamped; ++ i)
	{
		// In singleStep_() the CollisionManager could fire custom
		// callbacks that uses the smoothed states. So we must be sure
		// to reset them correctly before firing the callbacks.
		[self resetSmoothStates];
		[self singleStep:FIXED_TIMESTEP];
	}
    
	_world->ClearForces ();
    
	// We "smooth" positions and orientations using
	// fixedTimestepAccumulatorRatio_ (alpha).
	[self smoothStates];
}

-(void) singleStep: (float) dt
{
	// ...
    
	//updateControllers_ (dt);
	_world->Step (dt, velocityIterations_, positionIterations_);
	//consumeContacts_ ();
    
	// ...
}

-(void) smoothStates
{
	b2Vec2 newSmoothedPosition;
    
	const float oneMinusRatio = 1.f - fixedTimestepAccumulatorRatio_;
    
	for (b2Body * b = _world->GetBodyList (); b != NULL; b = b->GetNext ())
	{
		if (b->GetType () == b2_staticBody)
		{
			continue;
		}
        
        if (b->GetUserData() != NULL)
        {
            b2Vec2 bPos  = b->GetPosition();
            
            GameItem * gItem = (__bridge GameItem *) b->GetUserData();

            b2Vec2 previousPos = b2Vec2(gItem.previousPosition.x,gItem.previousPosition.y);
            b2Vec2 smoothedPos = b2Vec2(gItem.smoothedPosition.x,gItem.smoothedPosition.y);;  
            
            
            newSmoothedPosition = fixedTimestepAccumulatorRatio_ * bPos + oneMinusRatio * previousPos;
        
            gItem.smoothedPosition = CGPointMake(newSmoothedPosition.x, newSmoothedPosition.y);
            gItem.position = CGPointMake(newSmoothedPosition.x * PTM_RATIO, newSmoothedPosition.y * PTM_RATIO);
            gItem.smoothedAngle = fixedTimestepAccumulatorRatio_ * b->GetAngle () + oneMinusRatio * gItem.previousAngle;
            
        }
        
	}
}

-(void) resetSmoothStates
{
	b2Vec2 newSmoothedPosition;
    
	for (b2Body * b = _world->GetBodyList (); b != NULL; b = b->GetNext ())
	{
		if (b->GetType () == b2_staticBody)
		{
			continue;
		}
        
        if (b->GetUserData() != NULL)
        {
            GameItem * gItem = (__bridge GameItem *) b->GetUserData();
            
            b2Vec2 bPos  = b->GetPosition();            
            
            gItem.smoothedPosition = CGPointMake(bPos.x, bPos.y);
            gItem.previousPosition = CGPointMake(bPos.x, bPos.y);
            gItem.smoothedAngle = b->GetAngle ();
            gItem.previousAngle = b->GetAngle();
            
        }

	}
}


-(void) dealloc
{
	delete _world;
	_world = NULL;
    
//    delete m_debugDraw;
//	m_debugDraw = NULL;
}

@end
