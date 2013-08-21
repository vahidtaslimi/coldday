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
    
    
}
bool isLightOn = false;
bool isEyesInPlace = true;
bool isHatInPlace = true;
bool isRightHandInPlace = true;
bool isLeftHandInPlace = true;
bool isNoseInPlace = true;
bool isHeadInPlace = true;
bool isSnowmanFixed=true;
bool canLightTurnOn=false;
bool hasUserTouchedSnow =false;
bool hasUserTouchedLights=false;
bool lillyIsMoving = false;

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	PageOneLayer *layer = [PageOneLayer node];
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
			background = [CCSprite spriteWithFile:@"page1bg.png"];
		}
		background.position = ccp(size.width/2, size.height/2);
		[self addChild: background z:-1];
        
        
        head=[CCSprite spriteWithFile:@"head.png"];
        head.anchorPoint=ccp(0,0);
        head.position=ccp(850,390);
        [self addChild:head];
        
        eyes=[CCSprite spriteWithFile:@"eyes.png"];
        //eyes.anchorPoint=ccp(0,0);
        eyes.position=ccp(872,414);
        [self addChild:eyes];
        
        hat=[CCSprite spriteWithFile:@"hat.png"];
        //hat.anchorPoint=ccp(0,0);
        hat.position=ccp(874,434);
        [self addChild:hat];
        
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
        snow1.position=ccp(850,330);
        [snowFallSpriteSheet addChild:snow1];
        CCAnimation *snowFallAnimimation = [CCAnimation animationWithSpriteFrames:snowFallAnimFrames delay:0.1f];
        self.snowFallAction = [CCAnimate actionWithAnimation:snowFallAnimimation];
        snow1.anchorPoint =  ccp(0.5,0.1);
        id rotateleft = [CCRotateBy actionWithDuration:0.5 angle:-2];
        id rotateright = [CCRotateBy actionWithDuration:0.5 angle:2];
        [snow1 runAction:[CCRepeatForever actionWithAction:[CCSequence actions:rotateleft,rotateright,nil]]];
        
        nose=[CCSprite spriteWithFile:@"nose.png"];
        nose.anchorPoint=ccp(0,0);
        nose.position=ccp(872,405);
        [self addChild:nose];
        
        leftHand=[CCSprite spriteWithFile:@"lhand.png"];
        leftHand.anchorPoint=ccp(0,0);
        leftHand.position=ccp(820,360);
        [self addChild:leftHand];
        
        rightHand=[CCSprite spriteWithFile:@"rhand.png"];
        rightHand.anchorPoint=ccp(0,0);
        rightHand.position=ccp(885,376);
        [self addChild:rightHand];
        
        window=[CCSprite spriteWithFile:@"window1.png"];
        window.anchorPoint=ccp(0,0);
        window.position=ccp(19,320);
        window.opacity = 0;
        [self addChild:window];
        
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"PageOne_Lilly.plist"];
        CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"PageOne_Lilly.png"];
        [self addChild:spriteSheet];
        
        NSMutableArray *skateAnimFrames = [NSMutableArray array];
        for (int i=0; i<=8; i++) {
            [skateAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"Lilly%d.png",i]]];
        }
        lilly = [CCSprite spriteWithSpriteFrameName:@"Lilly0.png"];
        lilly.position = ccp(400, 360);
        lilly.scale=0.6;
        [spriteSheet addChild:lilly];
        CCAnimation *skateAnimimation = [CCAnimation animationWithSpriteFrames:skateAnimFrames delay:0.1f];
        self.skateAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:skateAnimimation]];
         [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"P1-BG.mp3"];
         [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:0.6];
        
	}
	return self;
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
        
        location=ccp(872,414);
        id scale = [CCScaleTo actionWithDuration:1 scale:1] ;
        [eyes runAction:[CCMoveTo actionWithDuration:1 position:location]];
        [eyes runAction:scale];
        [eyes runAction:[CCTintTo actionWithDuration:1 red:255 green:0 blue:0]];
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
        location=ccp(885,376);
        [rightHand runAction:[CCMoveTo actionWithDuration:1 position:location]];
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
        
        location=ccp(820,360);
        [leftHand runAction:[CCMoveTo actionWithDuration:1 position:location]];
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
        location=ccp(872,405);
        [nose runAction:[CCMoveTo actionWithDuration:1 position:location]];
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
        location=ccp(850,390);
        [head runAction:[CCMoveTo actionWithDuration:1 position:location]];
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
        
        location=ccp(874,434);
        id scale = [CCScaleTo actionWithDuration:1 scale:1] ;
        [hat runAction:[CCMoveTo actionWithDuration:1 position:location]];
        [hat runAction:scale];
        [hat runAction:[CCTintTo actionWithDuration:1 red:255 green:0 blue:0]];
       
        [self updateCanLillyMove];
    }
    else if(CGRectContainsPoint([snow1 boundingBox], location))
    {
        if(isSnowmanFixed == false)
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
        
        isHatInPlace=false;
        isEyesInPlace=false;
        isHeadInPlace=false;
        isNoseInPlace=false;
        isLeftHandInPlace=false;
        isRightHandInPlace=false;
        hasUserTouchedSnow =true;
        isSnowmanFixed = false;
        
        /*
         lilly.anchorPoint =  ccp(0.5,0.1);
         id rotateleft = [CCRotateBy actionWithDuration:0.5 angle:-10];
         id rotateright = [CCRotateBy actionWithDuration:0.5 angle:10];
         [lilly runAction:[CCRepeatForever actionWithAction:[CCSequence actions:rotateleft,rotateright,nil]]];
         */
    }
    else if(CGRectContainsPoint([lilly boundingBox], location))
    {
        if(isSnowmanFixed ==false)
        {
            return;
        }
        
        if(lillyIsMoving)
        {
            return;
        }
        
        if(hasUserTouchedLights)
        {
            [lilly stopAction:self.skateAction];
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
        
        bezier.controlPoint_1 = CGPointMake(104, -55.0f);
        bezier.controlPoint_2 = CGPointMake(650, -150.0f);
        bezier.endPosition =CGPointMake(550.0f,-190.0f);
        
        self.lillySkateMove1 = [CCBezierBy actionWithDuration:3 bezier:bezier];
        ccBezierConfig bezier2;
        bezier2.controlPoint_1 = CGPointMake(-700.0f, 190.0f);
        bezier2.controlPoint_2 = CGPointMake(-780, -80.0f);
        bezier2.endPosition =CGPointMake(-250.0f,-50.0f);
        
        self.lillySkateMove2 = [CCBezierBy actionWithDuration:3 bezier:bezier2];
        id scale = [CCScaleTo actionWithDuration:2 scale:1.2] ;
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
        CCAction *tintAction = [CCTintTo actionWithDuration:2 red:119 green:119 blue:119];
        [background runAction:[CCTintTo actionWithDuration:2 red:119 green:119 blue:119 ]];
        [head runAction:tintAction];
        CCTexture2D* tex = [[CCTextureCache sharedTextureCache] addImage:@"page1bg-Dark.png"];
        [background setTexture: tex];
        CCAction *fadeAction = [CCFadeTo actionWithDuration:2 opacity:1];
        [window runAction:fadeAction];
        hasUserTouchedLights=true;
    }
    else if(CGRectContainsPoint(CGRectMake(1000, 0, 200, 200), location))
    {
        [self moveToSceneTwo];
    }
    
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
    }
}
@end
