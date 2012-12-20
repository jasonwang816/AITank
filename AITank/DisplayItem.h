//
//  DisplayItem.h
//  AITank
//
//  Created by jason on 12-10-30.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface DisplayItem : NSObject{
    NSString * _imagePath;
    CGPoint _position;
    //CGRect _rect;
    float _angle;
    CCSprite * _sprite;

}
    
@property (nonatomic, strong) NSString * imagePath;
@property (nonatomic) CGPoint position;
@property (nonatomic) float angle;
@property (retain) CCSprite * sprite;

-(id) initWithImage:(NSString *)image AndPosition:(CGPoint)pos AndAngle:(float)ang;
-(id) initWithImage:(NSString *)image AndPosition:(CGPoint)pos AndAngle:(float)ang AndSize:(CGRect)rect;

@end
