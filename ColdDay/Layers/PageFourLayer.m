//
//  PageFourLayer.m
//  ColdDay
//
//  Created by VT on 31/07/13.
//  Copyright (c) 2013 Shaghayegh. All rights reserved.
//

#import "PageFourLayer.h"
#include "SimpleAudioEngine.h"

@implementation PageFourLayer
bool lizardHasMoved=false;
bool lillyHasGotLizard=false;
bool lizardHasJumped=false;
bool hasPalyedFishOnce=false;
bool isPlayingFish=false;

+(CCScene *) scene
{
    CCScene *scene = [CCScene node];
    PageFourLayer *layer = [PageFourLayer node];
    [scene addChild: layer];
    return scene;
}
-(id) init
{
    
    if( (self=[super init]) ) {
        self. touchEnabled=TRUE;
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
            self.background = [CCSprite spriteWithFile:@"Default.png"];
            self.background.rotation = 90;
        } else {
            self.background = [CCSprite spriteWithFile:@"p4-BG.jpg"];
        }
        self.background.position = ccp(size.width/2, size.height/2);
        [self addChild: self.background z:-1];
        [self addLillySprite];
        [self addLizardSprite];
        [self addWindowSprite];
        [self addWaterfallSprite];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"p4.mp3"];
        [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:0.6];
    }
    return self;
}


-(void) addFishSprite
{
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"p4-fish-sheet.plist"];
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"p4-fish-sheet.png"];
    [self addChild:spriteSheet];
    
    NSMutableArray *animFrames = [NSMutableArray array];
    for (int i=1; i<=2; i++) {
        NSString *frameName;
        frameName=[NSString stringWithFormat:@"%d.png",i];
        
        [animFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          frameName]];
    }
    
    self.fish = [CCSprite spriteWithSpriteFrameName:@"1.png"];
    self.fish.scale=0.4;
    self.fish.opacity=0;
    self.fish.rotation=-75;
    self.fish.position = ccp(120,255);
    [spriteSheet addChild:self.fish];
    CCAnimation *animimation = [CCAnimation animationWithSpriteFrames:animFrames delay:0.15f];
    CCAction *action= [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:animimation]];
    [self.fish runAction:action];
}

-(void) addWaterfallSprite
{
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"p4-waterfall-sheet.plist"];
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"p4-waterfall-sheet.png"];
    [self addChild:spriteSheet];
    
    NSMutableArray *animFrames = [NSMutableArray array];
    for (int i=1; i<=2; i++) {
        NSString *frameName;
        frameName=[NSString stringWithFormat:@"%d.png",i];
        
        [animFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          frameName]];
    }
    
    self.waterfall = [CCSprite spriteWithSpriteFrameName:@"1.png"];
    
    self.waterfall.position = ccp(95,410);
    [spriteSheet addChild:self.waterfall z:3];
    CCAnimation *waterfallAnimimation = [CCAnimation animationWithSpriteFrames:animFrames delay:0.15f];
    CCAction *action= [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:waterfallAnimimation]];
    [self.waterfall runAction:action];
}

-(void) addToradoSprite
{
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"p4-tornado.plist"];
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"p4-tornado.png"];
    [self addChild:spriteSheet];
    
    NSMutableArray *animFrames = [NSMutableArray array];
    for (int i=1; i<=3; i++) {
        NSString *frameName;
        frameName=[NSString stringWithFormat:@"p4-storm%d.png",i];
        
        [animFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          frameName]];
    }
    
    self.tornado = [CCSprite spriteWithSpriteFrameName:@"p4-storm1.png"];
    // self.tornado.position = ccp(250,650);
    self.tornado.position = ccp(250,650);
    self.tornado.scale=0.2f;
    self.tornado.opacity=0;
    [spriteSheet addChild:self.tornado z:3];
    CCAnimation *skateAnimimation = [CCAnimation animationWithSpriteFrames:animFrames delay:0.15f];
    self.tornadoAction= [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:skateAnimimation]];
    [self.tornado runAction:[CCFadeIn actionWithDuration:1]];
    //[self.tornado runAction:[CCScaleTo actionWithDuration:1 scale:0.2f]];
}

-(void) addWindowSprite
{
    self.windows = [CCSprite spriteWithFile:@"p4-windows.png"];
    self.windows.position = ccp(920,505);
    self.windows.opacity=0;
    [self addChild:self.windows];
    
    self.doors = [CCSprite spriteWithFile:@"p4-nightdoor.png"];
    self.doors.position = ccp(880,460);
    self.doors.opacity=0;
    [self addChild:self.doors];
}

-(void) addLillySprite
{
    self.lilly = [CCSprite spriteWithFile:@"p4-lil1.png"];
    self.lilly.position = ccp(600,350);
    [self addChild:self.lilly];
}

-(void) addLizardSprite
{
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"p4-liz-walk.plist"];
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"p4-liz-walk.png"];
    [self addChild:spriteSheet];
    
    NSMutableArray *skateAnimFrames = [NSMutableArray array];
    for (int i=1; i<=2; i++) {
        NSString *frameName;
        frameName=[NSString stringWithFormat:@"p4-Liz%d.png",i];
        
        [skateAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          frameName]];
    }
    self.lizard = [CCSprite spriteWithSpriteFrameName:@"p4-Liz1.png"];
    self.lizard.position = ccp(200,100);
    
    [spriteSheet addChild:self.lizard];
    CCAnimation *skateAnimimation = [CCAnimation animationWithSpriteFrames:skateAnimFrames delay:0.32f];
    self.lizardWalkAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:skateAnimimation]];
}

-(void) runLizardJumpAction
{
    CGPoint location =ccp(500,400);
    // CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p4-Liz3jump.png"];
    //[self.lizard setDisplayFrame:frame];
    
    self.lizardJumpAction=[CCJumpTo actionWithDuration:1 position:location height:1 jumps:1];
    [self.lizard runAction:self.lizardJumpAction];
}

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch=[touches anyObject];
    CGPoint location =[touch locationInView:[touch view]];
    location=[[CCDirector sharedDirector]convertToGL:location];
    if(CGRectContainsPoint([self.lizard boundingBox], location))
    {
        if(lizardHasMoved == false)
        {
            location=ccp(400,200);
            [self.lizard runAction:self.lizardWalkAction];
            id moveToAction=[CCMoveTo actionWithDuration:2 position:location];
            [self.lizard runAction:[CCSequence actions:
                                    moveToAction,
                                    [CCCallBlock actionWithBlock:^{
                [self.lizard stopAction:self.lizardWalkAction];
                lizardHasMoved=true;
            }]
                                    ,nil]];
        }
        
    }
    else if(CGRectContainsPoint([self.lilly boundingBox], location))
    {
        if(lizardHasMoved == false)
        {
            return;
        }
        
        if(lillyHasGotLizard ==false)
        {
            self.lilly.texture = [[CCTextureCache sharedTextureCache] addImage:@"p4-lil2.png"];
            id delay = [CCDelayTime actionWithDuration: 1];
            [self.lizard runAction:[CCSequence actions:
                                    [CCCallFunc actionWithTarget:self selector:@selector(runLizardJumpAction)],
                                    delay,
                                    [CCCallBlock actionWithBlock:^{
                CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"p4-Liz2.png"];
                [self.lizard setDisplayFrame:frame];
                lizardHasJumped=true;
            }],
                                    [CCCallBlock actionWithBlock:^{
                [self addDoorHint];
            }]
                                    ,nil]];
        }
        
        lillyHasGotLizard = true;
    }
    else if(CGRectContainsPoint([self.windows boundingBox], location) || CGRectContainsPoint([self.doors boundingBox], location))
    {
        if(lizardHasJumped == false)
        {
            return;
        }
        
        CCTintTo *tintAction=[CCTintTo actionWithDuration:2 red:119 green:119 blue:119 ];
        CCSequence *seq=[CCSequence actions:
                         [CCCallBlock actionWithBlock:^{
            [self.background runAction:tintAction];
            [self.waterfall runAction:[CCTintTo actionWithDuration:2 red:119 green:119 blue:119 ]];
            self.doorHint.visible =false;
            [self.windows runAction:[CCFadeTo actionWithDuration:2 opacity:255]];
            [self.doors runAction:[CCFadeTo actionWithDuration:2 opacity:255]];
        }]        ,
                         [CCDelayTime actionWithDuration:2],
                         [CCCallBlock actionWithBlock:^{
            [self addToradoSprite];
        }]
                         ,[CCCallBlock actionWithBlock:^{
            [self.tornado runAction:self.tornadoAction];
        }]
                         ,
                         nil];
        
        [self runAction:seq];
    }
    else if(CGRectContainsPoint([self.tornado boundingBox], location))
    {
        float duration=3;
        id scale = [CCScaleTo actionWithDuration:duration scale:1] ;
        ccBezierConfig bezier;
        bezier.controlPoint_1 = CGPointMake(50,-650.0f);
        bezier.controlPoint_2 = CGPointMake(450, 50.0f);
        bezier.endPosition =CGPointMake(350, -130.0f);
        
        [self.tornado runAction:scale];
        [self.tornado runAction: [CCBezierBy actionWithDuration:duration bezier:bezier]];
        
    }
    else if(CGRectContainsPoint([self.waterfall boundingBox], location))
    {
        if(isPlayingFish ==false)
        {
            isPlayingFish=true;
            
            [self addFishSprite];
            CCSequence *seq=[CCSequence actions:
                             [CCCallBlock actionWithBlock:^{
                [self.fish runAction:[CCFadeIn actionWithDuration:0.5]];
                CGPoint location =ccp(150,450);
                CCAction *action=[CCJumpTo actionWithDuration:1 position:location height:1 jumps:1];
                [self.fish runAction:action];
            }],
                             [CCDelayTime actionWithDuration:1],
                             [CCCallBlock actionWithBlock:^{
                self.fish.rotation=70;
                [self.fish runAction:[CCFadeOut actionWithDuration:1]];
                CGPoint location =ccp(120,250);
                CCAction *action=[CCJumpTo actionWithDuration:1 position:location height:1 jumps:1];
                [self.fish runAction:action];
            }]
                             ,[CCCallBlock actionWithBlock:^{
                isPlayingFish=false;
                [self addDoorHint];
            }],
                             
                             nil];
            [self.fish runAction:seq];
            
        }
        hasPalyedFishOnce=true;
    }
}

-(void) addDoorHint
{
    
    /*
     id move = [CCMoveBy actionWithDuration:1 position:ccp(0,200)];
     //id move_back = [move reverse];
     id move_ease = [CCEaseSineInOut actionWithAction:move ];
     id move_ease_back = [move_ease reverse];
     
     id move2 = [CCMoveBy actionWithDuration:1 position:ccp(0,200)];
     //id move_back = [move reverse];
     id move_ease2 = [CCEaseSineInOut actionWithAction:move2 ] ;
     id move_ease_back2 = [move_ease2 reverse];
     
     //id seq1 = [CCSequence actions: move_ease, move_ease_back, nil];
     //id seq2 = [CCSequence actions: [CCDelayTime actionWithDuration:0.05f], move_ease2, move_ease_back2, nil];
     //[self.doorHint runAction: [CCRepeatForever actionWithAction:seq1]];
     //[self.doorHint runAction: [CCRepeatForever actionWithAction:seq2]];
     */
    
    if(hasPalyedFishOnce ==false)
    {
        return;
    }
    
    if(self.doorHint != NULL)
    {
        return;
    }
    
    self.doorHint = [CCSprite spriteWithFile:@"p4-hint.png"];
    self.doorHint.position = ccp(880,495);
    // self.doorHint.opacity=0;
    [self addChild:self.doorHint];
    
    
    
    float duration=1;
    ccBezierConfig bezier;
    bezier.controlPoint_1 = CGPointMake(30,-20);
    bezier.controlPoint_2 = CGPointMake(60, -40.0f);
    bezier.endPosition =CGPointMake(90, -60.0f);
    CCAction *action1=[CCBezierBy actionWithDuration:duration bezier:bezier];
    
    ccBezierConfig bezier2;
    bezier.controlPoint_1 = CGPointMake(-30,20);
    bezier.controlPoint_2 = CGPointMake(-60, 40.0f);
    bezier.endPosition =CGPointMake(-90, 60.0f);
    CCAction *action2=[CCBezierBy actionWithDuration:duration bezier:bezier];
    
    ccBezierConfig bezier3;
    bezier.controlPoint_1 = CGPointMake(-30,-20);
    bezier.controlPoint_2 = CGPointMake(-60, -40.0f);
    bezier.endPosition =CGPointMake(-80, -50.0f);
    CCAction *action3=[CCBezierBy actionWithDuration:duration bezier:bezier];
    
    ccBezierConfig bezier4;
    bezier.controlPoint_1 = CGPointMake(30,20);
    bezier.controlPoint_2 = CGPointMake(60, 40.0f);
    bezier.endPosition =CGPointMake(80, 50.0f);
    CCAction *action4=[CCBezierBy actionWithDuration:duration bezier:bezier];
    CCSequence *seq=[CCSequence actions:
                     action1,
                     action2,
                     action3,
                     action4,
                     nil];
    
    [self.doorHint runAction:[CCRepeatForever actionWithAction:seq]];
    
}


/*
 -(CGPoint[]) addPoints
 {
 NSMutableArray *array=[NSMutableArray array];
 CGPoint centerPt=ccp(100,100);
 for (int i = 0; i < 360; i += 5)
 {
 CGPoint pt = ccpAdd(centerPt, ccpMult(ccpForAngle(CC_DEGREES_TO_RADIANS(i)), 30));
 [array addObject:pt];
 }
 
 return array;
 }
 
 float currentAngle=0;
 - (void)tick {
 float anglePerTick = 0.1; // this will determine your speed
 currentAngle += anglePerTick;
 self.position = ccpAdd(ccpMult(ccpForAngle(currentAngle), radius)),
 circleCenter);
 self.rotation = currentAngle * 180 / M_PI; // Convert from radians to degrees
 }
 
 */

@end