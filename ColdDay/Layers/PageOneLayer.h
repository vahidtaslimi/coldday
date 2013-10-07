//
//  PageOneLayer.h
//  ColdDay
//
//  Created by VT on 14/07/13.
//  Copyright (c) 2013 Shaghayegh. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"
#import "BaseLayer.h"
@interface PageOneLayer : BaseLayer
{
    
}
@property (nonatomic, strong) CCAction *skateAction;
@property (nonatomic, strong) CCAction *snowFallAction;
@property (nonatomic, strong) CCAction *lillySkateMove1;
@property (nonatomic, strong) CCAction *lillySkateMove2;
@property (nonatomic, strong) CCAction *lillySpinAction;
@property (nonatomic, strong) CCAction *lillyRepeateColdAction;
@property (nonatomic, strong) CCAction *lillyColdAction;

+(CCScene *) scene;

@end
