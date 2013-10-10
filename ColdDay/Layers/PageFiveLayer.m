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
			background = [CCSprite spriteWithFile:@"p5-BG.jpg"];
		}
        
		background.position = ccp(size.width/2, size.height/2);
		[self addChild: background z:0];
        [self addLillySpriteSheet];
        
        [self addPauseMenuItem];
	}
	return self;
}

-(void)addLillySpriteSheet
{
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"p5-lilly-spritesheet.plist"];
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"p5-lilly-spritesheet.png"];
    [self addChild:spriteSheet];
    
    //lilywakesup-00.png 16
    NSMutableArray *firstAnimFrames = [NSMutableArray array];
    for (int i=0; i<=5; i++) {
        [firstAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"lilywakesup-0%d.png",i]]];
    }
    CCAnimation *firstAnimimation = [CCAnimation animationWithSpriteFrames:firstAnimFrames delay:0.7f];
    self.lilywakesupActionOne = [CCAnimate actionWithAnimation:firstAnimimation];
    
    NSMutableArray *secondAnimFrames = [NSMutableArray array];
    for (int i=4; i<=5; i++) {
        [secondAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"lilywakesup-0%d.png",i]]];
    }
    CCAnimation *secondAnimimation = [CCAnimation animationWithSpriteFrames:secondAnimFrames delay:0.2f];
    self.lilywakesupActionTwo =[CCRepeat actionWithAction:[CCAnimate actionWithAnimation:secondAnimimation] times:2] ;
    
    
    NSMutableArray *thirdAnimFrames = [NSMutableArray array];
    for (int i=6; i<=16; i++) {
        NSString* frameName=[NSString stringWithFormat:@"lilywakesup-0%d.png",i];
        if(i>9)
        {
            frameName=   [NSString stringWithFormat:@"lilywakesup-%d.png",i];
        }
        
        [thirdAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          frameName]];
    }
    CCAnimation *thirdAnimimation = [CCAnimation animationWithSpriteFrames:thirdAnimFrames delay:0.6f];
    self.lilywakesupActionThree = [CCAnimate actionWithAnimation:thirdAnimimation];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"p1-lilly-spritesheet.plist"];
    CCSpriteBatchNode *spriteSheet2 = [CCSpriteBatchNode batchNodeWithFile:@"p1-lilly-spritesheet.png"];
    [self addChild:spriteSheet2];
    
    NSMutableArray *skateAnimFrames = [NSMutableArray array];
    for (int i=0; i<=8; i++) {
        [skateAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"skate-0%d.png",i]]];
    }
    
    CCAnimation *skateAnimimation = [CCAnimation animationWithSpriteFrames:skateAnimFrames delay:0.1f];
    self.skateAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:skateAnimimation]];
    
    //lilybye-00.png 10 0-3 4-10 4-0
    NSMutableArray *firstByeAnimFrames = [NSMutableArray array];
    for (int i=0; i<=3; i++) {
        [firstByeAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"lilybye-0%d.png",i]]];
    }
    CCAnimation *firstByeAnimimation = [CCAnimation animationWithSpriteFrames:firstByeAnimFrames delay:0.1f];
    CCAction* lilybyeActionOne = [CCAnimate actionWithAnimation:firstByeAnimimation];
    
    NSMutableArray *secondByeAnimFrames = [NSMutableArray array];
    for (int i=4; i<=10; i++) {
        NSString* frameName=[NSString stringWithFormat:@"lilybye-0%d.png",i];
        if(i>9)
        {
            frameName=   [NSString stringWithFormat:@"lilybye-%d.png",i];
        }
        [secondByeAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          frameName]];
    }
    CCAnimation *secondByeAnimimation = [CCAnimation animationWithSpriteFrames:secondByeAnimFrames delay:0.1f];
    CCAction* lilybyeActionTwo =[CCRepeat actionWithAction:[CCAnimate actionWithAnimation:secondByeAnimimation] times:3] ;
    
    NSMutableArray *thirdByeAnimFrames = [NSMutableArray array];
    for (int i=4; i>=0; i--) {
        [thirdByeAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"lilybye-0%d.png",i]]];
    }
    CCAnimation *thirdByeAnimimation = [CCAnimation animationWithSpriteFrames:thirdByeAnimFrames delay:0.1f];
    CCAction* lilybyeActionThree = [CCAnimate actionWithAnimation:thirdByeAnimimation];
    
    self.lilly = [CCSprite spriteWithSpriteFrameName:@"lilywakesup-00.png"];
    self.lilly.position = ccp(800, 310);
    //lilly.scale=0.6;
    [self addChild:self.lilly z:2];
    
    ccBezierConfig bezier;
    bezier.controlPoint_1 = CGPointMake(-950, -105.0f);
    bezier.controlPoint_2 = CGPointMake(-600, 150.0f);
    bezier.endPosition =CGPointMake(-90.0f,50.0f);
    
    ccBezierConfig bezier2;
    bezier2.controlPoint_1 = CGPointMake(-700.0f, 190.0f);
    bezier2.controlPoint_2 = CGPointMake(-780, -80.0f);
    bezier2.endPosition =CGPointMake(-100.0f,20.0f);
    
    id scale = [CCScaleTo actionWithDuration:3 scale:0.7] ;
    id flipXAction=[CCFlipX actionWithFlipX:true];
    id flipXActionNo=[CCFlipX actionWithFlipX:false];
    
    
    
    
    
    CCSequence *seq=[CCSequence actions:
                     [CCDelayTime actionWithDuration:2],
                      self.lilywakesupActionOne,
                      self.lilywakesupActionTwo,
                      self.lilywakesupActionThree,
                      [CCDelayTime actionWithDuration:2],
                     [CCCallBlock actionWithBlock:^{
        [self.lilly runAction:self.skateAction];
        self.lilly.flipX=true; //[CCFlipX actionWithFlipX:true];
       [self.lilly runAction:scale];
    }],
                    [CCBezierBy actionWithDuration:3 bezier:bezier],
                     //[CCBezierBy actionWithDuration:3 bezier:bezier2],
                     [CCCallBlock actionWithBlock:^{
        [self.lilly stopAction:self.skateAction];
    }],
                     lilybyeActionOne,
                     lilybyeActionTwo,
                     lilybyeActionThree,
                     nil];
    
    
    
    [self.lilly runAction:seq];
}

@end
