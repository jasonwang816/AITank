//
//  GameField.m
//  HockeyGame
//
//  Created by jason on 12-11-16.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameField.h"

@implementation GameField

@synthesize rect = _rect;


- (id) initWithRect:(CGRect)theRect{
    if (self = [super init]){
        _rect = theRect;
    }
    return  self;
}

@end
