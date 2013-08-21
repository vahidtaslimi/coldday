//
//  CCFerris.h
//  ColdDay
//
//  Created by VT on 7/08/13.
//  Copyright (c) 2013 Shaghayegh. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "cocos2d.h"
 

@interface CCFerris : CCActionInterval <NSCopying>
{
    CGPoint center;
    float radius;
    float currentAngle;
    float startAngle;
    float delta;
    float angle;
    ccTime rotation;
    int direction;
    
}
/** creates the action */
+(id) actionWithDuration: (ccTime)duration position:(CGPoint)position radius:(float)radius direction:(int)dir rotation: (ccTime)rot angle: (float)angle;
/** initializes the action */
-(id) initWithDuration: (ccTime)duration position:(CGPoint)position radius:(float)radius direction:(int)dir rotation: (ccTime)rot angle: (float)angle;
@end
