//
//  GameManager.m
//  AITank
//
//  Created by jason on 12-11-14.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameManager.h"

@implementation GameManager

@synthesize gameData = _gameData;
@synthesize gameLogic = _gameLogic;
@synthesize phyEngineLogic = _phyEngineLogic;

+ (id)gameManager{
    static GameManager * theManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        theManager = [[self alloc] init];
    });
    
    return theManager;
}

- (id) init{
    if (self = [super init]){
        [self initInstance];
    }
    return  self;
}

- (void) initInstance{
    //init gameData
    _gameData = [GameData Instance];
    
    //init gameLogic
    
    //init phyEngineLogic
    _phyEngineLogic = [[PhysicsEngineLogic alloc] init];
}

-(void) GameUpdate : (ccTime) dt{
    [_phyEngineLogic update:dt];
    //[_phyEngineLogic PhysicsStep:dt];
}

-(void) ShootBallAt:(CGPoint) dest {
    

    [_phyEngineLogic LinearForceOnTheBall:dest];
}

@end
