//
//  PageOneLayer.m
//  ColdDay
//
//  Created by VT on 14/07/13.
//  Copyright (c) 2013 Shaghayegh. All rights reserved.
//

#import "PageOneLayer.h"
#import "PageTwoLayer.h"
#include "SimpleAudioEngine.h"
#include "IntroLayer.h"

@implementation PageOneLayer
{
    CCSprite *eyes;
    CCSprite *hat;
    CCSprite *snow1;
    CCSprite *lilly;
    CCSprite *head;
    CCSprite *nose;
    CCSprite *leftHand;
    CCSprite *rightHand;
    CCSprite *background;
    CCSprite *window;
    CCSprite * windowBlink;
}

bool isLightOn = false;
bool isEyesInPlace = true;
bool isHatInPlace = true;
bool isRightHandInPlace = true;
bool isLeftHandInPlace = true;
bool isNoseInPlace = true;
bool isHeadInPlace = true;
bool isSnowmanFixed=true;
bool hasFixedSnowManForAtleastOneTime=false;
bool canLightTurnOn=false;
bool hasUserTouchedSnow =false;
bool hasUserTouchedLights=false;
bool lillyIsMoving = false;
CCSpriteBatchNode *spinSpriteSheet;
CGPoint headLocation;
CGPoint hatLocation;
CGPoint eyesLocation;
CGPoint rightHandLocation;
CGPoint leftHandLocation;
CGPoint noseLocation;


+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	PageOneLayer *layer = [PageOneLayer node];
	[scene addChild: layer];
	return scene;
}

-(id) init
{
 isLightOn = false;
   isEyesInPlace = true;
   isHatInPlace = true;
   isRightHandInPlace = true;
   isLeftHandInPlace = true;
   isNoseInPlace = true;
   isHeadInPlace = true;
   isSnowmanFixed=true;
   hasFixedSnowManForAtleastOneTime=false;
   canLightTurnOn=false;
   hasUserTouchedSnow =false;
   hasUserTouchedLights=false;
   lillyIsMoving = false;
    
	if( (self=[super init]) ) {
        hatLocation= ccp(894,454);
        
		self. touchEnabled=TRUE;
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
			background = [CCSprite spriteWithFile:@"Default.png"];
			background.rotation = 90;
		} else {
			background = [CCSprite spriteWithFile:@"p1-BG.jpg"];
		}
		background.position = ccp(size.width/2, size.height/2);
		[self addChild: background z:-1];
        
        
        head=[CCSprite spriteWithFile:@"p1-head.png"];
        head.anchorPoint=ccp(0,0);
        headLocation=   ccp(840,383);
        head.position=headLocation;
        [self addChild:head];
        
        eyes=[CCSprite spriteWithFile:@"p1-eyes.png"];
        //eyes.anchorPoint=ccp(0,0);
        eyesLocation=ccp(878,430);
        eyes.position=eyesLocation;
        [self addChild:eyes];
        
        hat=[CCSprite spriteWithFile:@"p1-hat.png"];
        //hat.anchorPoint=ccp(0,0);
        hatLocation= ccp(892,451);
        hat.position=hatLocation;
        [self addChild:hat];
        
        nose=[CCSprite spriteWithFile:@"p1-nose.png"];
        nose.anchorPoint=ccp(0,0);
        noseLocation=ccp(820,399);
        nose.position=noseLocation;
        [self addChild:nose];
        
        leftHand=[CCSprite spriteWithFile:@"p1-lhand.png"];
        leftHand.anchorPoint=ccp(0,0);
        leftHandLocation=  ccp(780,330);
        leftHand.position=leftHandLocation;
        [self addChild:leftHand];
        
        rightHand=[CCSprite spriteWithFile:@"p1-rhand.png"];
        rightHand.anchorPoint=ccp(0,0);
        rightHandLocation=ccp(899,360);
        rightHand.position=rightHandLocation;
        [self addChild:rightHand];
        
        /* snow1=[CCSprite spriteWithFile:@"snow1.png"];
         snow1.anchorPoint=ccp(0,0);
         snow1.position=ccp(850,470);
         snow1.anchorPoint =  ccp(0.5,0.1);
         id rotateleft = [CCRotateBy actionWithDuration:0.5 angle:-10];
         id rotateright = [CCRotateBy actionWithDuration:0.5 angle:10];
         [snow1 runAction:[CCRepeatForever actionWithAction:[CCSequence actions:rotateleft,rotateright,nil]]];
         [self addChild:snow1];
         */
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"PageOne_SnowFall.plist"];
        CCSpriteBatchNode *snowFallSpriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"PageOne_SnowFall.png"];
        [self addChild:snowFallSpriteSheet];
        
        NSMutableArray *snowFallAnimFrames = [NSMutableArray array];
        for (int i=0; i<=8; i++) {
            [snowFallAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"snow0%d.png",i]]];
        }
        snow1 = [CCSprite spriteWithSpriteFrameName:@"snow00.png"];
        snow1.position=ccp(830,330);
        snow1.scale=1.2;
        [snowFallSpriteSheet addChild:snow1];
        CCAnimation *snowFallAnimimation = [CCAnimation animationWithSpriteFrames:snowFallAnimFrames delay:0.1f];
        self.snowFallAction = [CCAnimate actionWithAnimation:snowFallAnimimation];
        snow1.anchorPoint =  ccp(0.5,0.1);
        id rotateleft = [CCRotateBy actionWithDuration:0.5 angle:-2];
        id rotateright = [CCRotateBy actionWithDuration:0.5 angle:2];
        [snow1 runAction:[CCRepeatForever actionWithAction:[CCSequence actions:rotateleft,rotateright,nil]]];
        
        
        window=[CCSprite spriteWithFile:@"p1-window.png"];
        window.anchorPoint=ccp(0,0);
        window.position=ccp(19,320);
        window.opacity = 0;
        [self addChild:window];
        
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"p1-lilly-spritesheet.plist"];
        CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"p1-lilly-spritesheet.png"];
        [self addChild:spriteSheet];
        
        NSMutableArray *skateAnimFrames = [NSMutableArray array];
        for (int i=0; i<=8; i++) {
            [skateAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"skate-0%d.png",i]]];
        }
        
        lilly = [CCSprite spriteWithSpriteFrameName:@"1.png"];
        lilly.position = ccp(410, 400);
        lilly.scale=0.5;
        [spriteSheet addChild:lilly];
        CCAnimation *skateAnimimation = [CCAnimation animationWithSpriteFrames:skateAnimFrames delay:0.1f];
        self.skateAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:skateAnimimation]];
        
        NSMutableArray *spinAnimFrames = [NSMutableArray array];
        CCSpriteFrame* frame1=[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"skate-00.png"];
        [spinAnimFrames addObject:frame1];
        [spinAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"skate-01.png"]];
        for (int i=1; i<=7; i++) {
            NSString *frameName=[NSString stringWithFormat:@"spin-0%d.png",i];
            
            if(i>9)
            {
                frameName=[NSString stringWithFormat:@"spin-0%d.png",i];
            }
            
            [spinAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              frameName]];
        }
        
        [spinAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"1.png"]];
        
        CCAnimation *spinAnimimation = [CCAnimation animationWithSpriteFrames:spinAnimFrames delay:0.15f];
        self.lillySpinAction = [CCAnimate actionWithAnimation:spinAnimimation];
        
        
        NSMutableArray *firstColdAnimFrames = [NSMutableArray array];
        for (int i=1; i<=7; i++) {
            [firstColdAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"%d.png",i]]];
        }
        
        NSMutableArray *repeateColdAnimFrames = [NSMutableArray array];
        for (int i=8; i<=9; i++) {
            [repeateColdAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"%d.png",i]]];
        }
        
        CCAnimation *repeateColdAnimation = [CCAnimation animationWithSpriteFrames:repeateColdAnimFrames delay:0.1f];
        self.lillyRepeateColdAction= [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:repeateColdAnimation]];
        
        CCAnimation *firstColdAnimation = [CCAnimation animationWithSpriteFrames:firstColdAnimFrames delay:0.4f];
        self.lillyColdAction= [CCAnimate actionWithAnimation:firstColdAnimation];
        
        
        
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"P1-BG.mp3"];
        [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:0.6];
        
        [self addPauseMenuItem];
	}
	return self;
}

-(void) addLillyColdSpriteSheet
{
    
    CCSpriteFrameCache* cache = [CCSpriteFrameCache sharedSpriteFrameCache];
    CCSpriteFrame* frame = [cache spriteFrameByName:@"1.png"];
    [lilly setDisplayFrame:frame];
    
    
    CCSequence* seq=[CCSequence actions:
                     self.lillyColdAction,
                     [CCCallBlock actionWithBlock:^{
        [lilly runAction:self.lillyRepeateColdAction];
    }]
                     , nil];
    [lilly runAction:seq];
    
}



// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
    
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
   
    UITouch *touch=[touches anyObject];
    CGPoint location =[touch locationInView:[touch view]];
    location=[[CCDirector sharedDirector]convertToGL:location];
    if(CGRectContainsPoint([eyes boundingBox], location))
    {
        if(isEyesInPlace || !isHeadInPlace)
        {
            return;
        }
        isEyesInPlace=true;
        
        id scale = [CCScaleTo actionWithDuration:1 scale:1] ;
        [eyes runAction:[CCMoveTo actionWithDuration:1 position:eyesLocation]];
        [eyes runAction:scale];
        //[eyes runAction:[CCTintTo actionWithDuration:1 red:255 green:0 blue:0]];
        //[eyes runAction:[CCAnimate actionWithAnimation:[self getAnimationWithFrames:1 to:10] restoreOriginalFrame:NO]];
        [self updateCanLillyMove];
    }
    else if(CGRectContainsPoint([rightHand boundingBox], location))
    {
        if(isRightHandInPlace)
        {
            return;
        }
        isRightHandInPlace=true;
        id scale = [CCScaleTo actionWithDuration:1 scale:1] ;
        
        [rightHand runAction:[CCMoveTo actionWithDuration:1 position:rightHandLocation]];
        [rightHand runAction:scale];
        [self updateCanLillyMove];
    }
    else if(CGRectContainsPoint([leftHand boundingBox], location))
    {
        if(isLeftHandInPlace )
        {
            return;
        }
        isLeftHandInPlace=true;
        
        [leftHand runAction:[CCMoveTo actionWithDuration:1 position:leftHandLocation]];
        [self updateCanLillyMove];
    }
    else if(CGRectContainsPoint([nose boundingBox], location))
    {
        if(isNoseInPlace || !isHeadInPlace)
        {
            return;
        }
        isNoseInPlace=true;
        id scale = [CCScaleTo actionWithDuration:1 scale:1] ;
        [nose runAction:[CCMoveTo actionWithDuration:1 position:noseLocation]];
        [nose runAction:scale];
        [self updateCanLillyMove];
    }
    else if(CGRectContainsPoint([head boundingBox], location))
    {
        NSLog(@"Tappedon HEAD");
        if(isHeadInPlace)
        {
            return;
        }
        isHeadInPlace=true;
        id scale = [CCScaleTo actionWithDuration:1 scale:1] ;
        [head runAction:[CCMoveTo actionWithDuration:1 position:headLocation]];
        [head runAction:scale];
        
        [self updateCanLillyMove];
    }
    else if(CGRectContainsPoint([hat boundingBox], location))
    {
        if(isHatInPlace || !isHeadInPlace)
        {
            return;
        }
        isHatInPlace=true;
        
        id scale = [CCScaleTo actionWithDuration:1 scale:1] ;
        [hat runAction:[CCMoveTo actionWithDuration:1 position:hatLocation]];
        [hat runAction:scale];
        //[hat runAction:[CCTintTo actionWithDuration:1 red:255 green:0 blue:0]];
        
        [self updateCanLillyMove];
    }
    else if(CGRectContainsPoint([snow1 boundingBox], location))
    {
        
        if(isSnowmanFixed == false || hasUserTouchedSnow )
        {
            return;
        }
        
        NSLog(@"Tapped on SNOW");
        
        location=ccp(850, 250);
        
        id scale = [CCScaleTo actionWithDuration:1 scale:0.0] ;
        //[snow1 runAction:[CCMoveTo actionWithDuration:1 position:location]];
        //[snow1 runAction:scale];
        
        [snow1 stopAction:self.snowFallAction];
        // [snow1 runAction:self.snowFallAction];
        
        [snow1 runAction:[CCSequence actions:
                          self.snowFallAction,
                          [CCCallFunc actionWithTarget:self selector:@selector(hideSnow1)],
                          nil]];
        
        
        [[SimpleAudioEngine sharedEngine] playEffect:@"p1-SnowFall.mp3"];
        
        //eyes.position=ccp(950,207);
        location=ccp(950,207);
        scale = [CCScaleTo actionWithDuration:1 scale:1.2] ;
        [eyes runAction:[CCMoveTo actionWithDuration:1 position:location]];
        [eyes runAction:scale];
        
        //hat.position=ccp(694,329);
        location=ccp(694,329);
        [hat runAction:[CCMoveTo actionWithDuration:1 position:location]];
        scale = [CCScaleTo actionWithDuration:1 scale:1.1] ;
        [hat runAction:scale];
        
        location=ccp(594,209);
        [nose runAction:[CCMoveTo actionWithDuration:1 position:location]];
        scale = [CCScaleTo actionWithDuration:1 scale:1.3] ;
        [nose runAction:scale];
        
        location=ccp(654,359);
        [leftHand runAction:[CCMoveTo actionWithDuration:1 position:location]];
        
        location=ccp(604,150);
        [rightHand runAction:[CCMoveTo actionWithDuration:1 position:location]];
        scale = [CCScaleTo actionWithDuration:1 scale:1.4] ;
        [rightHand runAction:scale];
        
        location=ccp(794,129);
        [head runAction:[CCMoveTo actionWithDuration:1 position:location]];
        scale = [CCScaleTo actionWithDuration:1 scale:1.4] ;
        [head runAction:scale];
        
        [self runAction:[CCSequence actions:
                         [CCDelayTime actionWithDuration:1],
                         [CCCallBlock actionWithBlock:^{
            
            isHatInPlace=false;
            isEyesInPlace=false;
            isHeadInPlace=false;
            isNoseInPlace=false;
            isLeftHandInPlace=false;
            isRightHandInPlace=false;
            hasUserTouchedSnow =true;
            isSnowmanFixed = false;
            
        }]
                         , nil]];
        
        /*
         lilly.anchorPoint =  ccp(0.5,0.1);
         id rotateleft = [CCRotateBy actionWithDuration:0.5 angle:-10];
         id rotateright = [CCRotateBy actionWithDuration:0.5 angle:10];
         [lilly runAction:[CCRepeatForever actionWithAction:[CCSequence actions:rotateleft,rotateright,nil]]];
         */
    }
    else if(CGRectContainsPoint([lilly boundingBox], location))
    {
        if(isSnowmanFixed ==false  || hasFixedSnowManForAtleastOneTime ==false)
        {
            return;
        }
        
        if(lillyIsMoving)
        {
            return;
        }
        
        if(hasUserTouchedLights)
        {
            [lilly stopAllActions];
            [lilly runAction:self.skateAction];
            //CCAction *moveLilly=[CCMoveTo actionWithDuration:1 position:location];
            location=ccp(1250,150);
            CCSequence *seq=[CCSequence actions:
                             [CCMoveTo actionWithDuration:2 position:location],
                             [CCCallFunc actionWithTarget:self selector:@selector(moveToSceneTwo)],
                             nil];
            
            [lilly runAction:seq];
            return;
        }
        
        if(canLightTurnOn)
        {
            [self spinLilly];
            return;
        }
        
        [lilly stopAction:self.skateAction];
        [lilly runAction:self.skateAction];
        /*
         ccBezierConfig bezier;
         bezier.controlPoint_1 = ccp(0, 500);
         bezier.controlPoint_2 = ccp(300, -500);
         bezier.endPosition = ccp(300,100);
         
         id bezierForward = [CCBezierBy actionWithDuration:3 bezier:bezier];
         [lilly runAction:bezierForward];
         */
        ccBezierConfig bezier;
        //400 360
        
        bezier.controlPoint_1 = CGPointMake(104, -85.0f);
        bezier.controlPoint_2 = CGPointMake(550, -120.0f);
        bezier.endPosition =CGPointMake(350.0f,-160.0f);
        
        self.lillySkateMove1 = [CCBezierBy actionWithDuration:3 bezier:bezier];
        ccBezierConfig bezier2;
        bezier2.controlPoint_1 = CGPointMake(-600.0f, 190.0f);
        bezier2.controlPoint_2 = CGPointMake(-600, -80.0f);
        bezier2.endPosition =CGPointMake(-350.0f,50.0f);
        
        self.lillySkateMove2 = [CCBezierBy actionWithDuration:3 bezier:bezier2];
        id scale = [CCScaleTo actionWithDuration:2 scale:1] ;
        id flipXAction=[CCFlipX actionWithFlipX:true];
        id flipXActionNo=[CCFlipX actionWithFlipX:false];
        
        //id resetAction=[CCMoveTo actionWithDuration:1 position:ccp(400, 360)];
        [lilly runAction:scale];
        lillyIsMoving=true;
        [lilly runAction: [CCSequence actions:
                           [CCBezierBy actionWithDuration:3 bezier:bezier],
                           flipXAction,
                           self.lillySkateMove2,
                           flipXActionNo,
                           [CCCallFunc actionWithTarget:self selector:@selector(skateMoveEnded)],
                           nil]];
        
        
    }
    else if(CGRectContainsPoint([window boundingBox], location))
    {
        if( canLightTurnOn ==false || isLightOn)
        {
            return;
        }
        isHeadInPlace=true;
        [[SimpleAudioEngine sharedEngine] playEffect:@"p1-Switch.mp3"];
        
        [background runAction:[CCTintTo actionWithDuration:2 red:119 green:119 blue:119 ]];
        [head runAction:[CCTintTo actionWithDuration:2 red:119 green:119 blue:119 ]];
        [hat runAction:[CCTintTo actionWithDuration:2 red:119 green:119 blue:119 ]];
        [snow1 runAction:[CCTintTo actionWithDuration:2 red:119 green:119 blue:119 ]];
        [nose runAction:[CCTintTo actionWithDuration:2 red:119 green:119 blue:119 ]];
        CCTexture2D* tex = [[CCTextureCache sharedTextureCache] addImage:@"p1-BGdark.jpg"];
        [background setTexture: tex];
        CCAction *fadeAction = [CCFadeTo actionWithDuration:2 opacity:1];
        [window runAction:fadeAction];
        hasUserTouchedLights=true;
        
        if(windowBlink)
        {
            [self removeChild:windowBlink];
        }
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        CCParticleSnow *emitter =[[CCParticleSnow alloc]init];
        emitter.position=ccp(size.width/2,size.height);
        emitter.speed=30;
        [emitter setDuration:kCCParticleDurationInfinity];
        emitter.texture=[[CCTextureCache sharedTextureCache]addImage:@"page2snow1.png"];
        [self addChild:emitter];
        [self addLillyColdSpriteSheet];
    }
    else if(CGRectContainsPoint(CGRectMake(1000, 0, 200, 200), location))
    {
        [self moveToSceneTwo];
    }
    
}

-(void) spinLilly
{
    CCSpriteFrameCache* cache = [CCSpriteFrameCache sharedSpriteFrameCache];
    CCSpriteFrame* frame = [cache spriteFrameByName:@"skate-00.png"];
    [lilly setDisplayFrame:frame];
    lilly.scale=1;
    /*CGPoint position=lilly.position;
     [self removeChild:lilly];
     lilly = [CCSprite spriteWithSpriteFrameName:@"00secondlillyPNG01.png"];
     lilly.position = position;
     [spinSpriteSheet addChild:lilly];
     */
    [lilly stopAction:self.lillySpinAction];
    
    [lilly runAction:self.lillySpinAction];
}

- (void) moveToSceneTwo
{
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[PageTwoLayer scene] ]];
}

- (void) skateMoveEnded
{
    [lilly stopAction:self.skateAction];
    canLightTurnOn = true;
    lillyIsMoving = false;
    canLightTurnOn =true;
    [self spinLilly];
    CCDelayTime *delay=[CCDelayTime actionWithDuration:4];
    CCCallBlock *addBlinkBlock=[CCCallBlock actionWithBlock:^{
        if(hasUserTouchedLights)
        {
            return ;
        }
        
        windowBlink=[CCSprite spriteWithFile:@"p1-dazzle.png"];
        windowBlink.scale=1;
        windowBlink.anchorPoint=ccp(0,0);
        windowBlink.position=ccp(53,413);
        [windowBlink runAction:[CCTintTo actionWithDuration:1 red:255 green:216 blue:0]];
        [self addChild:windowBlink];
        CCFadeTo *fade = [[CCFadeTo alloc] initWithDuration:1 opacity:255];
        CCFadeTo *fadeOut = [[CCFadeTo alloc] initWithDuration:1 opacity:50];
        CCSequence *sequence = [[CCSequence alloc] initOne:fade two:fadeOut];
        CCRepeatForever *repeat = [[CCRepeatForever alloc] initWithAction:sequence];
        [windowBlink runAction:repeat];
    }];
    CCSequence *AddBlinkSeq=[CCSequence actions:
                             delay,
                             addBlinkBlock, nil];
    [self runAction:AddBlinkSeq];
    
}

- (void) hideSnow1
{
    snow1.visible=false;
}

- (void) resetSnow1
{
    CCSpriteFrameCache* cache = [CCSpriteFrameCache sharedSpriteFrameCache];
    CCSpriteFrame* frame = [cache spriteFrameByName:@"snow00.png"];
    [snow1 setDisplayFrame:frame];
    snow1.visible=true;
    [snow1 stopAllActions];
}

- (void) updateCanLillyMove
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"P1-POP.mp3"];
    
    if(hasUserTouchedSnow == false)
    {
        return;
    }
    
    if(
       isHatInPlace==true &&
       isEyesInPlace==true &&
       isHeadInPlace==true &&
       isNoseInPlace==true &&
       isLeftHandInPlace==true &&
       isRightHandInPlace==true )
    {
        [self resetSnow1];
        isSnowmanFixed =true;
        [lilly stopAction:self.skateAction];
        [lilly runAction:self.skateAction];
        
        hasFixedSnowManForAtleastOneTime=true;
    }
}
@end
