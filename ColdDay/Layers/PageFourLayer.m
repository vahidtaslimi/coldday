//
//  PageFourLayer.m
//  ColdDay
//
//  Created by VT on 31/07/13.
//  Copyright (c) 2013 Shaghayegh. All rights reserved.
//

#import "PageFourLayer.h"
#include "SimpleAudioEngine.h"
#import "PageThreeLayerNew.h"
#import "PageFiveLayer.h"

@implementation PageFourLayer
bool lizardHasMoved=false;
bool lillyHasGotLizard=false;
bool lizardHasJumped=false;
bool hasPalyedFishOnce=false;
bool isPlayingFish=false;
bool hasTornadoMoved=false;
bool hasTornadoMovedOut=false;
bool isTornadoMoving=false;

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
        [self addRockSprite];
        [self addLollySprite:0.5];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"p4.mp3"];
        [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:0.6];
    }
    return self;
}


-(void) addLillySprite
{
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"p4-lilly-spritesheet.plist"];//p4-lilly-spritesheet
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"p4-lilly-spritesheet.png"];
    [self addChild:spriteSheet];
    
    NSMutableArray *lillyFramesOne = [NSMutableArray array];
    for (int i=0; i<=13; i++) {
        NSString *frameName;
        if(i<10)
        {
            frameName=[NSString stringWithFormat:@"lily1-0%d.png",i];
        }
        else
        {
            frameName=[NSString stringWithFormat:@"lily1-%d.png",i];
        }
        
        [lillyFramesOne addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:frameName]];
    }
    CCAnimation *lillyAnimimation = [CCAnimation animationWithSpriteFrames:lillyFramesOne delay:0.5f];
    self.lillyActionOne = [CCAnimate actionWithAnimation:lillyAnimimation];
    
    
    NSMutableArray *lillyFramesTwo = [NSMutableArray array];
    for (int i=13; i<=15; i++) {
        NSString *frameName;
        frameName=[NSString stringWithFormat:@"lily1-%d.png",i];
        [lillyFramesTwo addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:frameName]];
    }
    //[lillyFramesTwo addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"lily1-13.png"]];
    CCAnimation *lillyAnimimationTwo = [CCAnimation animationWithSpriteFrames:lillyFramesTwo delay:0.5f];
    self.lillyActionTwoWaitingForLizard = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:lillyAnimimationTwo]];
    
    
    NSMutableArray *lillyFramesThree = [NSMutableArray array];
    [lillyFramesThree addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"lily1-13.png"]];
    [lillyFramesThree addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"lily1-16.png"]];
    CCAnimation *lillyAnimimationThree = [CCAnimation animationWithSpriteFrames:lillyFramesThree delay:0.32f];
    self.lillyActionThreeHandMove = [CCAnimate actionWithAnimation:lillyAnimimationThree];
    
    
    NSMutableArray *lillyFramesFour = [NSMutableArray array];
    [lillyFramesFour addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"lily1-16.png"]];
    [lillyFramesFour addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"lily1-17.png"]];
    CCAnimation *lillyAnimimationFour = [CCAnimation animationWithSpriteFrames:lillyFramesFour delay:0.32f];
    self.lillyActionFourLizardDrop = [CCAnimate actionWithAnimation:lillyAnimimationFour];
    
    
    NSMutableArray *lillyFramesFive = [NSMutableArray array];
    [lillyFramesFive addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"lily1-18.png"]];
    [lillyFramesFive addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"lily1-19.png"]];
    CCAnimation *lillyAnimimationFive = [CCAnimation animationWithSpriteFrames:lillyFramesFive delay:0.32f];
    self.lillyActionFiveTurnBack = [CCAnimate actionWithAnimation:lillyAnimimationFive];
    
    
    
    NSMutableArray *legsFrames = [NSMutableArray array];
    [legsFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"legs-00.png"]];
    [legsFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"legs-01.png"]];
    [legsFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"legs-02.png"]];
    CCAnimation *legsAnimation = [CCAnimation animationWithSpriteFrames:legsFrames delay:0.15f];
    self.legsAction =[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:legsAnimation]];
    
    self.lilly = [CCSprite spriteWithSpriteFrameName:@"lily1-00.png"];
    self.lilly.position = ccp(600,350);
    [self addChild:self.lilly];
    
    
    CGPoint location=ccp(400,200);
    id moveToAction=[CCMoveTo actionWithDuration:2 position:location];
    
    CCSequence *seq2=[CCSequence actions:
                      moveToAction,
                      [CCCallBlock actionWithBlock:^{
        [self.lizard stopAction:self.lizardWalkAction];
        lizardHasMoved=true;
    }]
                      ,nil];
    
    
    CCSequence *seq=[CCSequence actions:
                     [CCDelayTime actionWithDuration:1.5],
                     self.lillyActionOne,
                     [CCCallBlock actionWithBlock:^{
        [self.lizard runAction:self.lizardWalkAction];
        [self.lizard runAction:seq2];
    }],  [CCDelayTime actionWithDuration:1.5],
                     [CCCallBlock actionWithBlock:^{
        [self.lilly runAction:self.lillyActionTwoWaitingForLizard];
    }]
                     ,
                     nil];
    [self.lilly runAction:seq];
    
    
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
    // self.fish.opacity=0;
    self.fish.rotation=-75;
    self.fish.position = ccp(120,320);
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
    self.waterfallAction= [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:waterfallAnimimation]];
}

-(void) runWaterfallAction
{
    [self.waterfall stopAllActions];
    [self.waterfall runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:2],
      [CCCallBlock actionWithBlock:^{
         [self.waterfall runAction:self.waterfallAction ];
     }]
      , nil]
     ];
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
    [self addLollySprite:0.2];
}


-(void) addRockSprite
{
    self.rock= [CCSprite spriteWithFile:@"p4-rock.png"];
    self.rock.position = ccp(110,350);
    // rock.color=ccc3(255,216,0);
    [self addChild:self.rock z:5];
    //[self.rock runAction:[CCTintTo actionWithDuration:0 red:0 green:0 blue:0]];
}

-(void) addLollySprite:(float) speed
{
    CCSprite *lolly= [CCSprite spriteWithFile:@"p4-loli.png"];
    lolly.position = ccp(925,650);
    id spin = [CCRotateBy actionWithDuration:speed angle: 360];
    id spins = [CCRepeatForever actionWithAction:spin];
    [self addChild:lolly z:5];
    [lolly runAction:spins];
    
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

-(void) addLizardSprite
{
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"p4-liz-walk.plist"];//p4-lilly-spritesheet
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"p4-liz-walk.png"];
    [self addChild:spriteSheet];
    
    NSMutableArray *skateAnimFrames = [NSMutableArray array];
    for (int i=0; i<=1; i++) {
        NSString *frameName;
        frameName=[NSString stringWithFormat:@"Lizard-0%d.png",i];
        
        [skateAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          frameName]];
    }
    self.lizard = [CCSprite spriteWithSpriteFrameName:@"Lizard-00.png"];
    self.lizard.position = ccp(200,100);
    
    [spriteSheet addChild:self.lizard];
    CCAnimation *skateAnimimation = [CCAnimation animationWithSpriteFrames:skateAnimFrames delay:0.32f];
    self.lizardWalkAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:skateAnimimation]];
}

-(void) runLizardJumpAction
{
    
    CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"Lizard-02.png"];
    [self.lizard setDisplayFrame:frame];
    CGPoint location =ccp(480,420);
    self.lizardJumpAction=[CCJumpTo actionWithDuration:1 position:location height:1 jumps:1];
    [self.lizard runAction:self.lizardJumpAction];
    [self runWaterfallAction];
}

-(void) runLizardJumpDownAction
{
    CCSpriteFrame* lillyFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"lily1-18.png"];
    [self.lilly setDisplayFrame:lillyFrame];
    
    CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"Lizard-02.png"];
    [self.lizard setDisplayFrame:frame];
    CGPoint location =ccp(480,-120);
    self.lizardJumpAction=[CCJumpTo actionWithDuration:1 position:location height:1 jumps:1];
    [self.lizard runAction:self.lizardJumpAction];
}

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch=[touches anyObject];
    CGPoint location =[touch locationInView:[touch view]];
    location=[[CCDirector sharedDirector]convertToGL:location];
    
    if(CGRectContainsPoint(CGRectMake(0, 0, 200, 200), location))
    {
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        [[CCDirector sharedDirector] replaceScene:[PageThreeLayerNew scene]];
    }
    
    if(CGRectContainsPoint([self.lizard boundingBox], location))
    {
        if(lizardHasMoved == false)
        {
            return;
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
            [self.lilly stopAction:self.lillyActionTwoWaitingForLizard];
            [self.lilly runAction:self.lillyActionThreeHandMove];
            
            id delay = [CCDelayTime actionWithDuration: 1];
            [self.lizard runAction:[CCSequence actions:
                                    [CCDelayTime actionWithDuration:0.5],
                                    [CCCallFunc actionWithTarget:self selector:@selector(runLizardJumpAction)],
                                    delay,
                                    [CCCallBlock actionWithBlock:^{
                CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"Lizard-01.png"];
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
            [self.rock runAction:[CCTintTo actionWithDuration:2 red:119 green:119 blue:119]];
            
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
        }],
                         [CCCallBlock actionWithBlock:^{
            [self runLizardJumpDownAction];
        }]
                         ,
                         nil];
        
        [self runAction:seq];
    }
    else if(CGRectContainsPoint([self.tornado boundingBox], location))
    {
        if(isTornadoMoving)
        {
            return;
        }
        
        isTornadoMoving=true;
        
        if(hasTornadoMoved==false)
        {
            CCSpriteFrame* lillyFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"lily1-19.png"];
            [self.lilly setDisplayFrame:lillyFrame];
            
            float duration=3;
            id scale = [CCScaleTo actionWithDuration:duration scale:1] ;
            ccBezierConfig bezier;
            bezier.controlPoint_1 = CGPointMake(50,-650.0f);
            bezier.controlPoint_2 = CGPointMake(450, 50.0f);
            bezier.endPosition =CGPointMake(350, -130.0f);
            
            
            [self.tornado runAction:scale];
            [self.tornado runAction: [CCBezierBy actionWithDuration:duration bezier:bezier]];
            [self.lilly runAction:[CCSequence actions:
                                   [CCDelayTime actionWithDuration:3],
                                   [CCCallBlock actionWithBlock:^{
                isTornadoMoving=false;
                hasTornadoMoved=true;
                self.lilly.position = ccp(600,250);
                [self.lilly runAction: self.legsAction];
            }],
                                   
                                   nil]];
            
            CCSequence *seq=[CCSequence actions:
                             [CCDelayTime actionWithDuration:6],
                             [CCCallBlock actionWithBlock:^{
                
                CGPoint outLocation=ccp(1100, 250);
                [self.tornado runAction:[CCMoveTo actionWithDuration:2 position:outLocation]];
                [self.lilly runAction:[CCMoveTo actionWithDuration:2 position:outLocation]];
                
            }],

                             [CCDelayTime actionWithDuration:1],
[CCCallBlock actionWithBlock:^{
     [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:4.0 scene:[PageFiveLayer scene] ]];
}]
                             , nil];
            
            [self runAction:seq];

            
        }
        else if(hasTornadoMovedOut ==false)
        {
            hasTornadoMovedOut=true;
            
                    //
            
        }
    }
    else if(CGRectContainsPoint([self.waterfall boundingBox], location))
    {
        if(isPlayingFish ==false)
        {
            isPlayingFish=true;
            CGPoint location =ccp(150,490);
            CGPoint location2 =ccp(105,270);
            CCAction *jumpAction=[CCJumpTo actionWithDuration:1.5 position:location height:1 jumps:1];
            CCAction *rotateAction=[CCRotateTo actionWithDuration:0.5 angle:70];
            CCAction *returnAction=[CCJumpTo actionWithDuration:1.5 position:location2 height:1 jumps:1];
            
            
            [self addFishSprite];
            CCSequence *seq=[CCSequence actions:
                             jumpAction,
                             //[CCDelayTime actionWithDuration:1.5],
                             rotateAction,
                             returnAction,
                             [CCCallBlock actionWithBlock:^{
                self.fish.visible=false;
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
    
    if(hasPalyedFishOnce ==false || lillyHasGotLizard == false)
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