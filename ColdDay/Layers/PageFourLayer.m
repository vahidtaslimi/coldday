//
//  PageFourLayer.m
//  ColdDay
//
//  Created by VT on 31/07/13.
//  Copyright (c) 2013 Shaghayegh. All rights reserved.
//

#import "PageFourLayer.h"

@implementation PageFourLayer
bool lizardHasMoved=false;
bool lillyHasGotLizard=false;
bool lizardHasJumped=false;

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
			self.background = [CCSprite spriteWithFile:@"p4BG.jpg"];
		}
		self.background.position = ccp(size.width/2, size.height/2);
		[self addChild: self.background z:-1];
        [self addLillySprite];
        [self addLizardSprite];
        [self          addWindowSprite];

	}
	return self;
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
    self.windows.position = ccp(870,485);
    self.windows.opacity=0;
    [self addChild:self.windows];
}

-(void) addLillySprite
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    
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
            }]
                                    ,nil]];
        }
        
        lillyHasGotLizard = true;
    }
    else if(CGRectContainsPoint([self.windows boundingBox], location))
    {
        if(lizardHasJumped == false)
        {
            return;
        }
        
        CCTintTo *tintAction=[CCTintTo actionWithDuration:2 red:119 green:119 blue:119 ];
        CCSequence *seq=[CCSequence actions:
                         [CCCallBlock actionWithBlock:^{
            [self.background runAction:tintAction];
            [self.windows runAction:[CCFadeTo actionWithDuration:2 opacity:255]];
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
    
}

@end