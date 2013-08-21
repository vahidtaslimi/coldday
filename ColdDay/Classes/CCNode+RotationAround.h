//
//  CCNode+RotationAround.h
//  ColdDay
//
//  Created by VT on 7/08/13.
//  Copyright (c) 2013 Shaghayegh. All rights reserved.
//

#import "CCNode.h"

@interface CCNode (RotationAround)

/**  Rotates a CCNode object to a certain angle around
 a certain rotation point by modifying it's rotation
 attribute and position.
 */
-(void) rotateAroundPoint:(CGPoint)rotationPoint angle:(CGFloat)angle;

@end