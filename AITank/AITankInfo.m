//
//  AITankInfo.m
//  AITank
//
//  Created by jason on 12-10-30.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AITankInfo.h"
#import "DisplayItem.h"
#import "cocos2d.h"

@implementation AITankInfo

- (id) initWithName:(NSString*)theName
{
    self = [super init];
    if (self)
    {
        float initAngle = 0;
        _name = theName;
        _body = [[DisplayItem alloc] initWithImage:IMAGE_PATH_BODY AndPosition:ccp(100,100)  AndAngle:initAngle AndSize:CGRectMake(0,0,IMAGE_BODY_WIDTH, IMAGE_BODY_WIDTH)];
        _cannon = [[DisplayItem alloc] initWithImage:IMAGE_PATH_CANNON AndPosition:ccp(0,0)  AndAngle:initAngle];
    }
    return self;
}

@end
