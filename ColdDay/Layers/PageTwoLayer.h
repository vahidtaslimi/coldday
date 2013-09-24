//
//  PageTwoLayer.h
//  ColdDay
//
//  Created by VT on 22/07/13.
//  Copyright (c) 2013 Shaghayegh. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"

@interface PageTwoLayer : CCLayer
{
    NSMutableArray * _snows;
    NSMutableArray * _snowsOnScreen;
    NSMutableArray *hearthArray;
    NSInteger lives;
    CCParticleExplosion *particleExplosion;
    NSMutableArray *starArray;
    NSInteger stars;
    NSInteger score;
}

@property (nonatomic, strong) CCSprite* lilly;
@property (nonatomic, strong) CCAction *firstLillyAction;
@property (nonatomic, strong) CCAction *secondtLillyAction;
@property (nonatomic, strong) CCAction *thirdLillyAction;
@property (nonatomic, strong) CCAction *winkAction;
@property (nonatomic, strong) CCAction *shiverAction;

+(CCScene *) scene;
@end
