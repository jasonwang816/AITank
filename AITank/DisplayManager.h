//
//  DisplayManager.h
//  HockeyGame
//
//  Created by jason on 12-11-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameData.h"
#import "GameSprite.h"

@interface DisplayManager : NSObject <CCDirectorDelegate>{
    
    //CCDirector * _director;
    GameData * _gameData;
    GameSprite * ball;
}

@property (nonatomic, strong) CCDirector * director;


// NOTE: If you have multiple CCViewController subclasses, you must take care the createDirectorGLView and didInitializeDirector set up the Cocos2D director exactly the same in each instance. Otherwise, you may get unexpected results. To avoid this, create another subclass that sits between CCViewController and your other subclasses, and place these methods there.

// Override this method to customize the CCGLView that is created for the director.
- (CCGLView *)createDirectorGLView;

// Override this method if you would like to set additional options for the director when it is first initialized.
// By default, this method does the following:
//  [director setAnimationInterval:1.0f/60.0f];
//  [director enableRetinaDisplay:YES];
- (void)didInitializeDirector;

- (void) InitInstance:(CCLayer *) theLayer;
- (void) UpdateGameData;

+ (id)Instance;

@end
