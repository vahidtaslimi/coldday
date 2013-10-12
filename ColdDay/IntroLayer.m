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

        [self addChild:[MenuLayer node]];
		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];

		CCSprite *background;
		
		if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
			background = [CCSprite spriteWithFile:@"Default.png"];
			background.rotation = 90;
		} else {
			//background = [CCSprite spriteWithFile:@"Default-Landscape~ipad.png"];
            background = [CCSprite spriteWithFile:@"intropage-BG.jpg"];
            //
		}
		background.position = ccp(size.width/2, size.height/2);

		// add the label as a child to this Layer
		[self addChild: background];
        
        // create and initialize a Label
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"A Cold Day" fontName:@"Marker Felt" fontSize:64];
        
        // ask director for the window size
        
        // position the label on the center of the screen
        label.position =  ccp( size.width /2 , size.height/2 );
        
        // add the label as a child to this Layer
        [self addChild: label];
        
        
        //test
        [CCMenuItemFont setFontSize:35];
        //[CCMenuItemFont setFontName: @"TrebuchetMS-Bold"];
        
        
        CCMenuItem *item1 = [CCMenuItemFont itemWithString:@"Play" block:^(id sender) {
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:2.0 scene:[PageOneLayer scene] ]];
        }];
      
        
       CCMenu* menu = [CCMenu menuWithItems: item1, nil];
        [menu alignItemsVertically];
        [menu alignItemsHorizontallyWithPadding:20];
        [menu setPosition:ccp( size.width/2, size.height/2 - 50)];
        [self addChild: menu];
	}
	
	return self;
}

-(void) onEnter
{
	[super onEnter];

}
@end
