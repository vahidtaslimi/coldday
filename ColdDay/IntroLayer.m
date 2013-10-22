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
#import "MenuLayer.h"
#import "PageFiveLayer.h"
#import "MainMenuLayer.h"

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
CCSprite* playButton;
CCSprite* playButtonPressed;

// 
-(id) init
{
	if( (self=[super init])) {
		self. touchEnabled=TRUE;
        [self addChild:[MenuLayer node]];
		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];

		CCSprite *background;
		
		if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
			background = [CCSprite spriteWithFile:@"Default.png"];
			background.rotation = 90;
		} else {
			background = [CCSprite spriteWithFile:@"Default-Landscape~ipad.png"];
            //background = [CCSprite spriteWithFile:@"intropage-BG.jpg"];
            //
		}
		background.position = ccp(size.width/2, size.height/2);

		// add the label as a child to this Layer
		[self addChild: background];
        
        [CCMenuItemFont setFontSize:35];
        //[CCMenuItemFont setFontName: @"TrebuchetMS-Bold"];
        
        playButton=[CCSprite spriteWithFile:@"play.png"];
        //playButton.position=ccp(550, 350);
       // [self addChild:playButton];
        playButtonPressed=[CCSprite spriteWithFile:@"play.png"];
        playButtonPressed.scale=0.98;
        //playButton.position=ccp(550, 350);
        // [self addChild:playButton];
        
        CCMenuItem *item1 =[CCMenuItemSprite itemWithNormalSprite:playButton selectedSprite:playButtonPressed block:^(id sender){  //[CCMenuItemFont itemWithString:@"Play" block:^(id sender) {
            
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:2.0 scene:[PageOneLayer scene] ]];
        }];

        
       CCMenu* menu = [CCMenu menuWithItems: item1, nil];
        [menu alignItemsVertically];
        [menu alignItemsHorizontallyWithPadding:20];
        [menu setPosition:ccp( size.width/2, size.height/2 - 50)];
      // [self addChild: menu];
	}
	
	return self;
}

-(void) onEnter
{
	[super onEnter];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[MainMenuLayer scene] ]];
}

@end
