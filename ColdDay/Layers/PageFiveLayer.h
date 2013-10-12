//
//  PageFiveLayer.h
//  ColdDay
//
//  Created by VT on 7/10/13.
//  Copyright (c) 2013 Shaghayegh. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"
#import "BaseLayer.h"

@interface PageFiveLayer : BaseLayer

{
    
}

@property (nonatomic, strong) CCSprite* lilly;
@property (nonatomic, strong)CCSprite* houseSprite;
@property (nonatomic, strong) CCAction *lilywakesupActionOne;
@property (nonatomic, strong) CCAction *lilywakesupActionFour;
@property (nonatomic, strong) CCAction *lilywakesupActionThree;
@property (nonatomic, strong) CCAction *lilywakesupActionTwo;
@property (nonatomic, strong) CCAction *skateAction;
+(CCScene *) scene;

@end
