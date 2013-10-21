//
//  PageFiveLayer.m
//  ColdDay
//
//  Created by VT on 7/10/13.
//  Copyright (c) 2013 Shaghayegh. All rights reserved.
//

#import "PageFiveLayer.h"
#include "SimpleAudioEngine.h"

@implementation PageFiveLayer
CCSprite *background;
CCParticleSnow *emitter;

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
                [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"P1-BG.mp3"];
		background.position = ccp(size.width/2, size.height/2);
		[self addChild: background z:0];
        [self addSnowFall];
        [self addLillySpriteSheet];
        
        [self addPauseMenuItem];
	}
	return self;
}

-(void) addSnowFall
{
     CGSize size = [[CCDirector sharedDirector] winSize];
    emitter =[[CCParticleSnow alloc]init];
    emitter.position=ccp(size.width/2,size.height);
    emitter.speed=30;
    [emitter setDuration:kCCParticleDurationInfinity];
    emitter.texture=[[CCTextureCache sharedTextureCache]addImage:@"page2snow1.png"];
    [self addChild:emitter];

}

-(void) addHouse
{
    CCSprite* houseSprite = [CCSprite spriteWithFile:@"p5-front.png"];
    houseSprite.position=ccp(188, 345);
    [self addChild:houseSprite z:5];
    [houseSprite runAction:[CCTintTo actionWithDuration:1 red:0 green:0 blue:0]];
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
    self.lilly.position = ccp(661, 78);
    self.lilly.anchorPoint=ccp(0,0);
    //lilly.scale=0.6;
    [self addChild:self.lilly z:2];

    
    id scale = [CCScaleTo actionWithDuration:1 scale:0.9] ;
    id flipXAction=[CCFlipX actionWithFlipX:true];
   
    
    CCSequence *seq=[CCSequence actions:
                     [CCDelayTime actionWithDuration:2],
                      self.lilywakesupActionOne,
                      self.lilywakesupActionTwo,
                      self.lilywakesupActionThree,
                      [CCDelayTime actionWithDuration:1],
                     [CCCallBlock actionWithBlock:^{
           [[SimpleAudioEngine sharedEngine] playEffect:@"p5-s1.mp3"];
        [self.lilly runAction:self.skateAction];
        self.lilly.flipX=true;
       [self.lilly runAction:scale];
    }],
                     [CCMoveTo actionWithDuration:1.5 position:ccp(69,94)],
                     [CCFlipX actionWithFlipX:false],
                     [CCCallBlock actionWithBlock:^{
          [self.lilly runAction:[CCScaleTo actionWithDuration:1.5 scale:0.7]];
    }],
                     [CCMoveTo actionWithDuration:1.5 position:ccp(541,209)],
                     [CCCallBlock actionWithBlock:^{
        [self.lilly stopAction:self.skateAction];
         self.houseSprite = [CCSprite spriteWithFile:@"p5-front.png"];
        self.houseSprite.position=ccp(188, 345);
        [self addChild:self.houseSprite z:5];
        //[houseSprite runAction:[CCTintTo actionWithDuration:1 red:0 green:0 blue:0]];
    }],
                     lilybyeActionOne,
                     lilybyeActionTwo,
                     lilybyeActionThree,
                     [CCDelayTime actionWithDuration:0.5],
                     [CCCallBlock actionWithBlock:^{
          [[SimpleAudioEngine sharedEngine] playEffect:@"p5-s2.mp3"];
        [self.lilly runAction:self.skateAction];
        [self.lilly runAction:[CCScaleTo actionWithDuration:3 scale:0.3]];
        [self.lilly runAction:[CCFlipX actionWithFlipX:true]];
    }],
                     [CCMoveTo actionWithDuration:1.5 position:ccp(400,273)],
                     [CCMoveTo actionWithDuration:2.5 position:ccp(51,337)],
                     [CCCallBlock actionWithBlock:^{
        [self.children removeObject:emitter];
         [self.houseSprite runAction:[CCTintTo actionWithDuration:2 red:119 green:119 blue:119 ]];
        [background runAction:[CCTintTo actionWithDuration:2 red:119 green:119 blue:119 ]];
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"The End" fontName:@"Marker Felt" fontSize:64];
        CGSize size = [[CCDirector sharedDirector] winSize];
        label.position =  ccp( size.width /2 , size.height/2 );
        [self addChild: label];
    }]
                     ,nil];
    
    
    
    [self.lilly runAction:seq];
}


-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch * touch = [[touches allObjects] objectAtIndex:0];
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    CGPoint location =[touch locationInView:[touch view]];
    NSLog(@"Touced %f,%f", touchLocation.x,touchLocation.y);
    //[self.lilly runAction:[CCMoveTo actionWithDuration:1 position:touchLocation]];
}
@end
