//
//  GameSprite.h
//  HockeyGame
//
//  Created by jason on 12-12-18.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameItem.h"

@interface GameSprite : CCSprite{
    GameItem * item; 

}

-(void) setGameItem:(GameItem*) theItem;


@end

