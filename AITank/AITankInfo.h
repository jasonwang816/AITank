//
//  AITankInfo.h
//  AITank
//
//  Created by jason on 12-10-30.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DisplayItem.h"

@interface AITankInfo : NSObject{
    NSString * _name;  
    DisplayItem * _body;
    DisplayItem * _cannon;
    DisplayItem * _radar;
    
    CGPoint _position;
}

@property (nonatomic) CGPoint position;

- (id) initWithName:(NSString*)theName AndPosition:(CGPoint)thePosition;
- (void) drawTank;

@end
