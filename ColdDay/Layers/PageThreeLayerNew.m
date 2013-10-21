//
//  PageThreeLayerNew.m
//  ColdDay
//
//  Created by VT on 27/09/13.
//  Copyright (c) 2013 Shaghayegh. All rights reserved.
//

#import "PageThreeLayerNew.h"
#import "PageTwoLayer.h"
#import "SimpleAudioEngine.h"
#import "PageFourLayer.h"


@implementation PageThreeLayerNew

{
    
}

CCSprite *background;
bool hasActionStarted=false;
CCParticleGalaxy *sleepEmitter;

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	PageThreeLayerNew *layer = [PageThreeLayerNew node];
	[scene addChild: layer];
	return scene;
}

-(id) init
{
hasActionStarted=false;    
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
        
        [self addLillySpriteSheet];
        
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"p3-bg.mp3"];
        [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:0.6];
        
        [self runAction:[CCSequence actions:
                         [CCDelayTime actionWithDuration:2],
                         [CCCallBlock actionWithBlock:^{
            
            [self startPageAction];
        }],
                         nil]];
        [self addPauseMenuItem];
	}
	return self;
}

-(void)addLillySpriteSheet
{
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"p3-lilly-spritesheet.plist"];
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"p3-lilly-spritesheet.png"];
    [self addChild:spriteSheet];
    
    NSMutableArray *firstAnimFrames = [NSMutableArray array];
    for (int i=0; i<=7; i++) {
        [firstAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"lillydeam-0%d.png",i]]];
    }
    CCAnimation *firstAnimimation = [CCAnimation animationWithSpriteFrames:firstAnimFrames delay:1.0f];
    self.firstLillyAction = [CCAnimate actionWithAnimation:firstAnimimation];
    
    self.lilly = [CCSprite spriteWithSpriteFrameName:@"lillydeam-00.png"];
    self.lilly.position = ccp(400, 310);
    //lilly.scale=0.6;
    [self addChild:self.lilly z:2];
    
    
    
}

-(void) displaySleepEmitter
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    sleepEmitter =[[CCParticleGalaxy alloc]init];
    sleepEmitter.position=ccp(300,510);
    sleepEmitter.speed=30;
    [sleepEmitter setDuration:kCCParticleDurationInfinity];
    
    sleepEmitter.texture=[[CCTextureCache sharedTextureCache]addImage:@"P3-sun.png"];
    [sleepEmitter runAction:[CCScaleTo actionWithDuration:10 scale:12]];
    
    [self addChild:sleepEmitter z:0];
}

-(void) startPageAction
{
    [self.lilly runAction:self.firstLillyAction];
    [self displaySleepEmitter];
    hasActionStarted=true;
    CCSequence *seq=[CCSequence actions:
                     [CCDelayTime actionWithDuration:2],
                     [CCCallBlock actionWithBlock:^{
        
        id my_wavesAction = [CCWaves actionWithWaves:4 amplitude:4 horizontal:YES
                                            vertical:NO grid:ccg(15,10) duration:5];
        [background runAction: [CCRepeatForever actionWithAction:my_wavesAction]];
        
    }],
                     [CCDelayTime actionWithDuration:5],
                     
                     [CCCallBlock actionWithBlock:^{
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:4.0 scene:[PageFourLayer scene] ]];
    }]
                     ,nil
                     ];
    [self.lilly runAction:seq];
    
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch * touch = [[touches allObjects] objectAtIndex:0];
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    CGPoint location =[touch locationInView:[touch view]];
    
  /*  if(CGRectContainsPoint(CGRectMake(1000, 750, 200, 200), location))
    {
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        [[CCDirector sharedDirector] replaceScene:[PageFourLayer scene]];
    }
    */
    
    if(CGRectContainsPoint([self.lilly boundingBox], location))
    {
        if(hasActionStarted ==false)
        {
        }
    }
}

@end
