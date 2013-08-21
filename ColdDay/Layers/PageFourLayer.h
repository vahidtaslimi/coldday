//
//  PageFourLayer.h
//  ColdDay
//
//  Created by VT on 31/07/13.
//  Copyright (c) 2013 Shaghayegh. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"


@interface PageFourLayer : CCLayer
{
}

@property (nonatomic, strong) CCSprite *background;
@property (nonatomic, strong) CCSprite *lizard;
@property (nonatomic, strong) CCAction *lizardWalkAction;
@property (nonatomic, strong) CCAction *lizardJumpAction;
@property (nonatomic, strong) CCSprite *lilly;
@property (nonatomic,strong) CCSprite *tornado;
@property (nonatomic, strong) CCAction *tornadoAction;
@property (nonatomic,strong) CCSprite *windows;

+(CCScene *) scene;
    
@end
