//
//  IntroLayer.m
//  ColdDay
//
//  Created by VT on 14/07/13.
//  Copyright Shaghayegh 2013. All rights reserved.
//


// Import the interfaces
#import "IntroLayer.h"
#import "PageOneLayer.h"
#import "PageThreeLayer.h"
#import "PageFourLayer.h"
#import "PageTwoLayer.h"
#import "PageThreeLayerNew.h"

#pragma mark - IntroLayer

// HelloWorldLayer implementation
@implementation IntroLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	IntroLayer *layer = [IntroLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// 
-(id) init
{
	if( (self=[super init])) {

		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];

		CCSprite *background;
		
		if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
			background = [CCSprite spriteWithFile:@"Default.png"];
			background.rotation = 90;
		} else {
			//background = [CCSprite spriteWithFile:@"Default-Landscape~ipad.png"];
            background = [CCSprite spriteWithFile:@"p1-BG.jpg"];
            //
		}
		background.position = ccp(size.width/2, size.height/2);

		// add the label as a child to this Layer
		[self addChild: background];
	}
	
	return self;
}

-(void) onEnter
{
	[super onEnter];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:2.0 scene:[PageFourLayer scene] ]];
}
@end
