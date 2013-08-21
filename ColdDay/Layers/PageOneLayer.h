//
//  PageOneLayer.h
//  ColdDay
//
//  Created by VT on 14/07/13.
//  Copyright (c) 2013 Shaghayegh. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"
@interface PageOneLayer : CCLayer
{
    
}
@property (nonatomic, strong) CCAction *skateAction;
@property (nonatomic, strong) CCAction *snowFallAction;
@property (nonatomic, strong) CCAction *lillySkateMove1;
@property (nonatomic, strong) CCAction *lillySkateMove2;

+(CCScene *) scene;

@end
