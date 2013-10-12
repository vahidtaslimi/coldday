//
//  BaseLayer.m
//  ColdDay
//
//  Created by VT on 7/10/13.
//  Copyright (c) 2013 Shaghayegh. All rights reserved.
//

#import "BaseLayer.h"

@implementation BaseLayer

-(void) displayMenuItems
{
    [self addChild:[MenuLayer node]];
}

-(void)addPauseMenuItem
{
	CGSize size = [[CCDirector sharedDirector] winSize];
   
    
	//test
	[CCMenuItemFont setFontSize:40];
	[CCMenuItemFont setFontName: @"TrebuchetMS-Bold"];
		
    CCMenuItem *item1 = [CCMenuItemFont itemWithString:@"II" block:^(id sender) {
       self. touchEnabled=false;
        CCNode *menuNode=[MenuLayer node];
        [self addChild:menuNode z:1002];
        
    }];
    
   CCMenu *menu  = [CCMenu menuWithItems: item1, nil];
	[menu alignItemsVertically];
	[menu alignItemsHorizontallyWithPadding:20];
    [menu setPosition:ccp( size.width-50, size.height -50)];
	[self addChild: menu];
}

-(void) addMenuItems
{
	CGSize size = [[CCDirector sharedDirector] winSize];
	CCSprite *background = [CCSprite spriteWithFile:@"p1-BG.jpg"];
	background.position = ccp(size.width/2, size.height/2);
	[self addChild:background z:0];
	
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
	
	
    CCMenuItem *item1 = [CCMenuItemFont itemWithString:@"Play" block:^(id sender) {}];
    CCMenuItem *item2 = [CCMenuItemFont itemWithString:@"Credit" block:^(id sender) {}];
	CCMenu *menu  = [CCMenu menuWithItems: item1, item2, nil];
	[menu alignItemsVertically];
	[menu alignItemsHorizontallyWithPadding:20];
    [menu setPosition:ccp( size.width/2, size.height/2 - 50)];
	[self addChild: menu];
}

-(void)newLocalScore {
    UIAlertView* dialog = [[UIAlertView alloc] init];
    [dialog setDelegate:self];
    [dialog setTitle:@"Online Access"];
    [dialog setMessage:@"Do you want to connect to the online ranking?"];
    [dialog addButtonWithTitle:@"Yes"];
    [dialog addButtonWithTitle:@"No"];
    [dialog show];
    [dialog release];
}

- (void) alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0) {
        //do stuff
    }
}

@end
