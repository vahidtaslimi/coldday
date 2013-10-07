//
//  MenuLayer.m
//  ColdDay
//
//  Created by VT on 7/10/13.
//  Copyright (c) 2013 Shaghayegh. All rights reserved.
//

#import "MenuLayer.h"
#import "PageOneLayer.h"

@implementation MenuLayer

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	MenuLayer *layer = [MenuLayer node];
	[scene addChild: layer];
	return scene;
}

-(id) init
{
	if( (self=[super init]) ) {
        [[CCDirector sharedDirector] pause];
		self. touchEnabled=TRUE;
        CGSize size = [[CCDirector sharedDirector] winSize];
        CCSprite *background = [CCSprite spriteWithFile:@"p5-BG.jpg"];
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
        
        
        CCMenuItem *itemRestart = [CCMenuItemFont itemWithString:@"Restart" block:^(id sender) {
            [[CCDirector sharedDirector] resume];
            ((CCLayer*) self.parent).touchEnabled =true;
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[PageOneLayer scene] withColor:ccc3(255, 255, 255)]];
                    [self setVisible:false];
            //[[CCDirector sharedDirector] end];
            //	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:2.0 scene:[PageOneLayer scene] ]];
            /*UIAlertView *alert = [[[UIAlertView alloc]
                                   initWithTitle:NSLocalizedString(@"CHANGEPLAYER", nil)
                                   message:nil
                                   delegate:self
                                   cancelButtonTitle:nil
                                   otherButtonTitles:NSLocalizedString(@"OK", nil),
                                   nil
                                   ] autorelease];
            [alert show];*/
        }];
        CCMenuItem *item1 = [CCMenuItemFont itemWithString:@"Resume" block:^(id sender) {
            [[CCDirector sharedDirector] resume];
           ((CCLayer*) self.parent).touchEnabled =true;
            [self setVisible:false];
        }];
        menu = [CCMenu menuWithItems:item1, itemRestart, nil];
        [menu alignItemsVertically];
        [menu alignItemsHorizontallyWithPadding:20];
        [menu setPosition:ccp( size.width/2, size.height/2 - 50)];
        [self addChild: menu];
    }
    
	
    return self;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    (void)alertView;
    (void)buttonIndex;
    
    [[CCDirector sharedDirector] resume];
}

-(void) menuCallback: (id) sender
{
	//start the game
    [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration:0.5f scene:[PageOneLayer scene]]];
	
}

-(void) menuCallback2: (id) sender
{
	//start the game
}
@end
