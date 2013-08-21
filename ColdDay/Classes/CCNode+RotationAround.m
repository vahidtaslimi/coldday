//
//  CCNode+RotationAround.m
//  ColdDay
//
//  Created by VT on 7/08/13.
//  Copyright (c) 2013 Shaghayegh. All rights reserved.
//

#import "CCNode+RotationAround.h"
#import "cocos2d.h"

@implementation CCNode (RotationAround)

//p'x = cos(theta) * (px-ox) - sin(theta) * (py-oy) + ox
//p'y = sin(theta) * (px-ox) + cos(theta) * (py-oy) + oy

-(void) rotateAroundPoint:(CGPoint)rotationPoint angle:(CGFloat)angle {
    CGFloat x = cos(CC_DEGREES_TO_RADIANS(-angle)) * (self.position.x-rotationPoint.x) - sin(CC_DEGREES_TO_RADIANS(-angle)) * (self.position.y-rotationPoint.y) + rotationPoint.x;
    CGFloat y = sin(CC_DEGREES_TO_RADIANS(-angle)) * (self.position.x-rotationPoint.x) + cos(CC_DEGREES_TO_RADIANS(-angle)) * (self.position.y-rotationPoint.y) + rotationPoint.y;
    
    self.position = ccp(x, y);
    self.rotation = angle;
}

@end