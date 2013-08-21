//
//  CCRotateAroundTo.m
//  ColdDay
//
//  Created by VT on 7/08/13.
//  Copyright (c) 2013 Shaghayegh. All rights reserved.
//

#import "CCRotateAroundTo.h"

@implementation CCRotateAroundTo

+(id) actionWithDuration: (ccTime) t angle:(float) a rotationPoint:(CGPoint) rotationPoint
{
    return [[[self alloc] initWithDuration:t angle:a rotationPoint:rotationPoint] autorelease];
}

-(id) initWithDuration: (ccTime) t angle:(float) a rotationPoint:(CGPoint) rotationPoint
{
    if( (self=[super initWithDuration: t angle: a]) )
    {
        rotationPoint_ =  rotationPoint;
    }
    
    return self;
}

-(void) startWithTarget:(CCNode *)aTarget
{
    [super startWithTarget:aTarget];
    startPosition_ = [(CCNode*)target_ position];
}

-(void) update: (ccTime) t
{
    
    CGFloat x = cos(CC_DEGREES_TO_RADIANS(-diffAngle_*t)) * ((startPosition_.x)-rotationPoint_.x) - sin(CC_DEGREES_TO_RADIANS(-diffAngle_*t)) * ((startPosition_.y)-rotationPoint_.y) + rotationPoint_.x;
    CGFloat y = sin(CC_DEGREES_TO_RADIANS(-diffAngle_*t)) * ((startPosition_.x)-rotationPoint_.x) + cos(CC_DEGREES_TO_RADIANS(-diffAngle_*t)) * ((startPosition_.y)-rotationPoint_.y) + rotationPoint_.y;
    
    [_target setPosition:ccp(x, y)];
    [_target setRotation: (startAngle_ + diffAngle_ * t )];
}

@end

@implementation CCRotateAroundBy

+(id) actionWithDuration: (ccTime) t angle:(float) a rotationPoint:(CGPoint) rotationPoint
{
    return [[[self alloc] initWithDuration:t angle:a rotationPoint:rotationPoint] autorelease];
}

-(id) initWithDuration: (ccTime) t angle:(float) a rotationPoint:(CGPoint) rotationPoint
{
    if( (self=[super initWithDuration: t angle: a]) )
    {
        rotationPoint_ =  rotationPoint;
    }
    
    return self;
}

-(void) startWithTarget:(CCNode *)aTarget
{
    [super startWithTarget:aTarget];
    startPosition_ = [(CCNode*)target_ position];
}

-(void) update: (ccTime) t
{
    CGFloat x = cos(CC_DEGREES_TO_RADIANS(-angle_*t)) * ((startPosition_.x)-rotationPoint_.x) - sin(CC_DEGREES_TO_RADIANS(-angle_*t)) * ((startPosition_.y)-rotationPoint_.y) + rotationPoint_.x;
    CGFloat y = sin(CC_DEGREES_TO_RADIANS(-angle_*t)) * ((startPosition_.x)-rotationPoint_.x) + cos(CC_DEGREES_TO_RADIANS(-angle_*t)) * ((startPosition_.y)-rotationPoint_.y) + rotationPoint_.y;
    
    [target_ setPosition:ccp(x, y)];
    [target_ setRotation: (startAngle_ + angle_ * t )];
}

@end
