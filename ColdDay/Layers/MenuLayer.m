//
//  MenuLayer.m
//  ColdDay
//
//  Created by VT on 7/10/13.
//  Copyright (c) 2013 Shaghayegh. All rights reserved.
//

#import "MenuLayer.h"
#import "PageOneLayer.h"
#import "MainMenuLayer.h"
#import "PageFiveLayer.h"

@implementation MenuLayer

CCSprite* resumeButton;
CCSprite* resumeButtonPressed;
CCSprite* restartButton;
CCSprite* restartButtonPressed;
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
        CCSprite *background = [CCSprite spriteWithFile:@"pausepage-BG.jpg"];
        background.position = ccp(size.width/2, size.height/2);
        //[self addChild:background z:0];
      
        
        ccColor4B color = {0,0,0,150};
        CCLayerColor *colorLayer = [CCLayerColor layerWithColor:color];
        [self addChild:colorLayer z:0];

        
        resumeButton=[CCSprite spriteWithFile:@"resume.png"];
        //resumeButton.position=ccp(690, 350);
        resumeButton.scale=0.8;
       
        resumeButtonPressed=[CCSprite spriteWithFile:@"resume.png"];
        //resumeButtonPressed.position=ccp(690, 350);
        resumeButtonPressed.scale=0.78;
        //[self addChild:resumeButton];
        
        restartButton=[CCSprite spriteWithFile:@"mainmenu.png"];
        //restartButton.position=ccp(350, 350);
        restartButton.scale=0.8;
        //[self addChild:restartButton];
        restartButtonPressed=[CCSprite spriteWithFile:@"mainmenu.png"];
        //restartButtonPressed.position=ccp(350, 350);
        restartButtonPressed.scale=0.78;
        //[self addChild:restartButton];
        
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"A Cold Day" fontName:@"Marker Felt" fontSize:64];
        label.position =  ccp( size.width /2 , size.height/2 );
        //[self addChild: label];

        [CCMenuItemFont setFontSize:35];
        //[CCMenuItemFont setFontName: @"TrebuchetMS-Bold"];
        
        CCMenuItem *itemRestart = [CCMenuItemSprite itemWithNormalSprite:restartButton selectedSprite:restartButtonPressed block:^(id sender){  //[CCMenuItemFont itemWithString:@"Restart" block:^(id sender) {
  
            ((CCLayer*) self.parent).touchEnabled =true;
          //  [self setVisible:false];
            CCScene *scene=[MainMenuLayer scene];
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:scene withColor:ccc3(255, 255, 255)]];
          [[CCDirector sharedDirector] resume];
        }];
        

        CCMenuItem *item1 =[CCMenuItemSprite itemWithNormalSprite:resumeButton selectedSprite:resumeButtonPressed block:^(id sender){ //[CCMenuItemFont itemWithString:@"Resume" block:^(id sender) {
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

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch=[touches anyObject];
    CGPoint location =[touch locationInView:[touch view]];
    location=[[CCDirector sharedDirector]convertToGL:location];
    return;
    
    if(CGRectContainsPoint([resumeButton boundingBox], location))
    {
        [[CCDirector sharedDirector] resume];
        ((CCLayer*) self.parent).touchEnabled =true;
        [self setVisible:false];
    }
   else if(CGRectContainsPoint([restartButton boundingBox], location))
    {
        [[CCDirector sharedDirector] resume];
        ((CCLayer*) self.parent).touchEnabled =true;
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[PageOneLayer scene] withColor:ccc3(255, 255, 255)]];
        [self setVisible:false];
    }
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
