//
//  CCFerris.m
//  ColdDay
//
//  Created by VT on 7/08/13.
//  Copyright (c) 2013 Shaghayegh. All rights reserved.
//

#import "CCFerris.h"

@implementation CCFerris
bool isFirstRound=true;
CGPoint startoint;

+(id) actionWithDuration: (ccTime) t position: (CGPoint) pos radius: (ccTime) h direction: (int) dir rotation: (ccTime) rot angle: (float) ang
{
    return [[[self alloc] initWithDuration: t position: pos radius: h direction: dir rotation: rot angle: ang] autorelease];
}

-(id) initWithDuration: (ccTime) t position: (CGPoint) pos radius: (ccTime) h direction: (int) dir rotation: (ccTime) rot angle: (float) ang
{
    if( (self=[super initWithDuration:t]) ) {
        center = pos;
        radius = h;
        direction = dir;
        rotation = rot;
        angle = ang;
    }
    return self;
}

-(id) copyWithZone: (NSZone*) zone
{
    CCAction *copy = [[[self class] allocWithZone: zone] initWithDuration: [self duration] position: center radius: radius direction: direction rotation: rotation angle: angle];
    return copy;
}

-(void) startWithTarget:(id)aTarget
{
    [super startWithTarget:aTarget];
}

-(void) update: (ccTime) t
{
 
    currentAngle = 2 * M_PI * t * direction + angle; //2pi rad for 360 degrees
   /* if(  currentAngle == angle && isFirstRound==false){
           [super stop];
        return;
    }
*/
    [_target setPosition: ccpAdd(ccpMult(ccpForAngle(-currentAngle), radius), center)];
    [_target setRotation: rotation];
        isFirstRound=false;
}

-(CCActionInterval*) reverse
{
    return [[self class] actionWithDuration:_duration position:center radius:radius direction:-direction rotation:rotation angle: angle];
}

@end