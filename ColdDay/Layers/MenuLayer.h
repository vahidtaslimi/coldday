//
//  MenuLayer.h
//  ColdDay
//
//  Created by VT on 7/10/13.
//  Copyright (c) 2013 Shaghayegh. All rights reserved.
//

#import "CCLayer.h"
#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface MenuLayer : CCLayer
{
	CCMenu * menu;
}

//@property (strong) CCLayer *parent;

-(void) menuCallback:(id) sender;
+(CCScene *) scene;


@end
