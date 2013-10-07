//
//  PageFiveLayer.m
//  ColdDay
//
//  Created by VT on 7/10/13.
//  Copyright (c) 2013 Shaghayegh. All rights reserved.
//

#import "PageFiveLayer.h"

@implementation PageFiveLayer
CCSprite *background;
CCParticleGalaxy *sleepEmitter;

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	PageFiveLayer *layer = [PageFiveLayer node];
	[scene addChild: layer];
	return scene;
}

-(id) init
{
    
	if( (self=[super init]) ) {
		self. touchEnabled=TRUE;
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
			background = [CCSprite spriteWithFile:@"Default.png"];
			background.rotation = 90;
		} else {
			background = [CCSprite spriteWithFile:@"p2-page2bg.jpg"];
		}
        
		background.position = ccp(size.width/2, size.height/2);
		[self addChild: background z:-1];
        

	}
	return self;
}
@end
