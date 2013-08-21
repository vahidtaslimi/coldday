//
//  PageThreeLayer.h
//  ColdDay
//
//  Created by VT on 28/07/13.
//  Copyright (c) 2013 Shaghayegh. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"

@interface PageThreeLayer : CCLayer
{
    
}

@property (nonatomic, strong) CCSprite *background;
@property (nonatomic, strong) CCSprite *lilly;
@property (nonatomic, strong) CCSequence *lillyMoveAnimation;
@property (nonatomic, strong) CCAction *skateAction;

+(CCScene *) scene;

@end
