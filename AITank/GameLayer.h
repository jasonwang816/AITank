//
//  GameLayer.h
//  HockeyGame
//
//  Created by jason on 12-12-18.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import <GameKit/GameKit.h>
#import "cocos2d.h"
#import "Box2D.h"
#import "DisplayManager.h"
#import "GameManager.h"

@interface GameLayer : CCLayer{
    DisplayManager * displayMgr;
    GameManager * gameManager;
}

+(CCScene *) scene;

@end
