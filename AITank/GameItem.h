//
//  GameItem.h
//  HockeyGame
//
//  Created by jason on 12-12-18.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum  {
	GameItemType_Player,
    GameItemType_GoalKeeper,
	GameItemType_Stick,
    GameItemType_Ball
} GameItemType;

@interface GameItem : NSObject{
    GameItemType _itemType;
    float _previousAngle;
	float _smoothedAngle;
	CGPoint _previousPosition;
	CGPoint _smoothedPosition;    
}

@property (nonatomic) GameItemType ItemType;
@property (nonatomic) float previousAngle;
@property (nonatomic) float smoothedAngle;
@property (nonatomic) CGPoint previousPosition;
@property (nonatomic) CGPoint smoothedPosition;

@property (nonatomic) CGPoint position;
@property (nonatomic) float angle;

- (id) initWithPosition:(CGPoint)pos AndAngle:(float)ang;

@end
