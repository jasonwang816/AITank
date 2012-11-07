//
//  MainLayer.h
//  AITank
//
//  Created by jason on 12-10-23.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import <GameKit/GameKit.h>
#import "cocos2d.h"
#import "Box2D.h"


#define PTM_RATIO 32

@interface MainLayer : CCLayer
{
    b2World * _world;
	b2Body * _body;
    CCSprite * _ball;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end