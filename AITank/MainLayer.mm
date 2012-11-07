//
//  MainLayer.m
//  AITank
//
//  Created by jason on 12-10-23.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainLayer.h"

@implementation MainLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MainLayer *layer = [MainLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
		
		self.isTouchEnabled = YES;
        
        CGSize winSize = [CCDirector sharedDirector].winSize;
        
        // Create sprite and add it to the layer
        _ball = [CCSprite spriteWithFile:@"tank1.gif" rect:CGRectMake(0, 0, 52, 52)];
        _ball.position = ccp(100, 100);
        [self addChild:_ball];
        
        // Create a world
        b2Vec2 gravity = b2Vec2(0.0f, 0.0f);
        _world = new b2World(gravity);
        
        // Create edges around the entire screen
        b2BodyDef groundBodyDef;
        groundBodyDef.position.Set(0,0);
        b2Body *groundBody = _world->CreateBody(&groundBodyDef);
        b2EdgeShape groundEdge;
        b2FixtureDef boxShapeDef;
        boxShapeDef.shape = &groundEdge;
        groundEdge.Set(b2Vec2(0,0), b2Vec2(winSize.width/PTM_RATIO, 0));
        groundBody->CreateFixture(&boxShapeDef);
        groundEdge.Set(b2Vec2(0,0), b2Vec2(0, winSize.height/PTM_RATIO));
        groundBody->CreateFixture(&boxShapeDef);
        groundEdge.Set(b2Vec2(0, winSize.height/PTM_RATIO), 
                       b2Vec2(winSize.width/PTM_RATIO, winSize.height/PTM_RATIO));
        groundBody->CreateFixture(&boxShapeDef);
        groundEdge.Set(b2Vec2(winSize.width/PTM_RATIO, 
                              winSize.height/PTM_RATIO), b2Vec2(winSize.width/PTM_RATIO, 0));
        groundBody->CreateFixture(&boxShapeDef);
        
        // Create ball body and shape
        b2BodyDef ballBodyDef;
        ballBodyDef.type = b2_dynamicBody;
        ballBodyDef.position.Set(100/PTM_RATIO, 100/PTM_RATIO);
        ballBodyDef.userData = (__bridge void *)_ball;
        _body = _world->CreateBody(&ballBodyDef);
        
        b2CircleShape circle;
        circle.m_radius = 26.0/PTM_RATIO;
        
        b2FixtureDef ballShapeDef;
        ballShapeDef.shape = &circle;
        ballShapeDef.density = 1.0f;
        ballShapeDef.friction = 0.2f;
        ballShapeDef.restitution = 0.8f;
        _body->CreateFixture(&ballShapeDef);
        
        //[self schedule:@selector(tick:)];
        [self scheduleUpdate];
	}
	return self;
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
//    UITouch *myTouch = [touches anyObject];
//    CGPoint location = [myTouch locationInView:[myTouch view]];
//    location = [[CCDirector sharedDirector] convertToGL:location];
//    b2Vec2 locationWorld = b2Vec2(location.x/PTM_RATIO, location.y/PTM_RATIO);
    
    CCDirector *director = [CCDirector sharedDirector];
    //[director end];
    
    [director.view removeFromSuperview];
    [director removeFromParentViewController];
//    NSLog(@"%@", director);
//    [director dismissViewControllerAnimated:YES completion:nil];
//    UIViewController * vc = [director parentViewController];
//    NSLog(@"%@", vc);

    //[vc dismissViewControllerAnimated:YES completion:nil];
}

- (void)tick:(ccTime) dt {
    NSLog(@"Tick");
    _world->Step(dt, 6, 2);
    for(b2Body *b = _world->GetBodyList(); b; b=b->GetNext()) {    
        if (b->GetUserData() != NULL) {
            CCSprite *ballData = (__bridge CCSprite *)b->GetUserData();
            ballData.position = ccp(b->GetPosition().x * PTM_RATIO,
                                    b->GetPosition().y * PTM_RATIO);
            ballData.rotation = -1 * CC_RADIANS_TO_DEGREES(b->GetAngle());
        }        
    }
    
}

-(void) update: (ccTime) dt
{
    //NSLog(@"update");
    _world->Step(dt, 6, 2);
    for(b2Body *b = _world->GetBodyList(); b; b=b->GetNext()) {   
        //NSLog(@"Next");
        if (b->GetUserData() != NULL) {
            CCSprite *ballData = (__bridge CCSprite *)b->GetUserData();
                    //NSLog(@"%@", ballData);
            ballData.position = ccp(b->GetPosition().x * PTM_RATIO,
                                    b->GetPosition().y * PTM_RATIO);
            ballData.rotation = -1 * CC_RADIANS_TO_DEGREES(b->GetAngle());
        }        
    }	
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
    delete _world;
    _body = nil;
    _world = nil;
	// don't forget to call "super dealloc"
	//[super dealloc];
}

@end
