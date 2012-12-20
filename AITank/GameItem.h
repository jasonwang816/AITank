//
//  GameItem.h
//  HockeyGame
//
//  Created by jason on 12-12-18.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameItem : NSObject

@property (nonatomic) CGPoint position;
@property (nonatomic) float angle;

- (id) initWithPosition:(CGPoint)pos AndAngle:(float)ang;

@end
