//
//  GameField.h
//  HockeyGame
//
//  Created by jason on 12-11-16.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameField : NSObject{
    CGRect _rect;
}

@property (nonatomic) CGRect rect;

- (id) initWithRect:(CGRect)theRect;

@end
