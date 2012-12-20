//
//  GameLayer.m
//  HockeyGame
//
//  Created by jason on 12-12-18.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameLayer.h"

@implementation GameLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameLayer *layer = [GameLayer node];
	
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
		gameManager = [GameManager gameManager];
        
        displayMgr = [DisplayManager Instance];
        [displayMgr InitInstance:self];
        
        
		self.isTouchEnabled = YES;
        
       
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
    
    CCDirector *director = displayMgr.director;
    //[director end];
    
    [director.view removeFromSuperview];
    [director removeFromParentViewController];
    //    NSLog(@"%@", director);
    //    [director dismissViewControllerAnimated:YES completion:nil];
    //    UIViewController * vc = [director parentViewController];
    //    NSLog(@"%@", vc);
    
    //[vc dismissViewControllerAnimated:YES completion:nil];
}

-(void) update: (ccTime) dt
{
    //NSLog(@"update");
    [gameManager GameUpdate:dt];
//    _world->Step(dt, 6, 2);
//    for(b2Body *b = _world->GetBodyList(); b; b=b->GetNext()) {   
//        //NSLog(@"Next");
//        if (b->GetUserData() != NULL) {
//            CCSprite *ballData = (__bridge CCSprite *)b->GetUserData();
//            //NSLog(@"%@", ballData);
//            ballData.position = ccp(b->GetPosition().x * PTM_RATIO,
//                                    b->GetPosition().y * PTM_RATIO);
//            ballData.rotation = -1 * CC_RADIANS_TO_DEGREES(b->GetAngle());
//        }        
//    }	
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
//    delete _world;
//    _body = nil;
//    _world = nil;
	// don't forget to call "super dealloc"
	//[super dealloc];
}


@end
