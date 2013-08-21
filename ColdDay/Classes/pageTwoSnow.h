//
//  pageTwoSnow.h
//  ColdDay
//
//  Created by VT on 24/07/13.
//  Copyright (c) 2013 Shaghayegh. All rights reserved.
//

#import "CCNode.h"

@interface pageTwoSnow : CCNode
{
    
}
@property(nonatomic,readwrite,retain) NSString *monsterSprite;
@property(nonatomic,readwrite,retain) NSString *splashSprite;
@property(nonatomic, readwrite) int movement;
@property(nonatomic, readwrite) float minVelocity;
@property(nonatomic, readwrite) float maxVelocity;
@property(nonatomic, readwrite) int killMethod;
@end
