//
//  BaseLayer.h
//  ColdDay
//
//  Created by VT on 7/10/13.
//  Copyright (c) 2013 Shaghayegh. All rights reserved.
//

#import "CCLayer.h"
#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MenuLayer.h"

@interface BaseLayer : CCLayer

//@property(nonatomic, strong) MenuLayer* menuLayer;

-(void) addMenuItems;

-(void) addPauseMenuItem;

@end
