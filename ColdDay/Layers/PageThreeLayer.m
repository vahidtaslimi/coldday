//
//  PageThreeLayer.m
//  ColdDay
//
//  Created by VT on 28/07/13.
//  Copyright (c) 2013 Shaghayegh. All rights reserved.
//

#import "PageThreeLayer.h"
#import "CCParticleSystemQuad.h"
#import "PageFourLayer.h"
#import "CCFerris.h"

@implementation PageThreeLayer
{
    CCParticleSystemQuad *vehicleParticleSystem ;
    CCParticleSmoke *trailEmitter;
    CCParticleSun *sunEmitter;
    
}

bool _hasLillyStaredSkating=false;
int lapNumber=1;

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	PageThreeLayer *layer = [PageThreeLayer node];
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
			self.background = [CCSprite spriteWithFile:@"p3-BG.jpg"];
		}
		self.background.position = ccp(size.width/2, size.height/2);
		[self addChild: self.background z:-1];
        
        [self addLillySprite];
        
	}
	return self;
}
-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSMutableArray *monstersToDelete = [[NSMutableArray alloc] init];
    UITouch * touch = [[touches allObjects] objectAtIndex:0];
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    CGPoint location =[touch locationInView:[touch view]];
    
    if(_hasLillyStaredSkating ==false)
    {
        [self displaySun];
        [self runFerries];
            [self schedule:@selector(updateParticleSystem:) interval:0.1];
        _hasLillyStaredSkating=true;
    }
    
}

-(void) displaySun
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    sunEmitter =[[CCParticleSun alloc]init];
    sunEmitter.position=ccp(size.width/2,size.height/2);
    sunEmitter.speed=30;
    [sunEmitter setDuration:kCCParticleDurationInfinity];
    sunEmitter.position = ccp(size.width/2,size.height/2);
    sunEmitter.texture=[[CCTextureCache sharedTextureCache]addImage:@"P3-sun.png"];
    [sunEmitter runAction:[CCScaleTo actionWithDuration:18 scale:7]];
    
    [self addChild:sunEmitter z:2];
}

-(void) addLillySprite
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    int xOffset=90;
    int yOffset=90;
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"page3-LillySkate.plist"];
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"page3-LillySkate.png"];
    [self addChild:spriteSheet];
    
    NSMutableArray *skateAnimFrames = [NSMutableArray array];
    for (int i=1; i<=25; i++) {
        NSString *frameName;
        if(i<10)
        {
            frameName=[NSString stringWithFormat:@"Layer-0%d.png",i];
        }
        else
        {
            frameName=[NSString stringWithFormat:@"Layer-%d.png",i];
        }
        [skateAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          frameName]];
    }
    self.lilly = [CCSprite spriteWithSpriteFrameName:@"Layer-01.png"];
    self.lilly.position = ccp(xOffset,size.height/2);
    
    [spriteSheet addChild:self.lilly];
    CCAnimation *skateAnimimation = [CCAnimation animationWithSpriteFrames:skateAnimFrames delay:0.32f];
    self.skateAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:skateAnimimation]];
    
    
    trailEmitter =[[CCParticleSmoke alloc]init];
    trailEmitter.position = ccp(self.lilly.position.x - self.lilly.contentSize.width/3, self.lilly.position.y - self.lilly.contentSize.height/3);
    //  [trailEmitter setDuration:kCCParticleDurationInfinity];
    trailEmitter.texture=[[CCTextureCache sharedTextureCache]addImage:@"particleTexture.png"];
    //[self addChild:trailEmitter];
    
 

}

-(void) runFerries
{
   if(lapNumber==8)
   {
       [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:2.0 scene:[PageFourLayer scene] ]];
   }
   else{
        float lapDuration=4.0/lapNumber;
        CGSize size = [[CCDirector sharedDirector] winSize];
    CCAction *ferris = [CCFerris actionWithDuration:lapDuration
                                           position:ccp(size.width/2,size.height/2)
                                             radius:320
                                          direction:1
                                           rotation:0
                                              angle:360];
    [self.lilly runAction:[CCSequence actions:
                           ferris,
                           [CCCallBlock actionWithBlock:^{
        lapNumber++;
        [self runFerries];
    }],
                           nil]];
   }}

- (void) updateParticleSystem:(ccTime)dt {
    trailEmitter.position = ccp(self.lilly.position.x - self.lilly.contentSize.width/3, self.lilly.position.y - self.lilly.contentSize.height/3);
}

-(void) runLillySkateAnimation
{
    [self.lilly stopAction:self.skateAction];
    int xOffset=90;
    int yOffset=90;
    float lapDuration=2.0/lapNumber;
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    
    ccBezierConfig bezier;
    bezier.controlPoint_1 = ccp(size.width*0.15,size.height*0.95);
    bezier.controlPoint_2 =ccp(size.width*0.25,size.height*0.75);
    bezier.endPosition = ccp(size.width/2,size.height-yOffset) ;
    id bezierForward = [CCBezierTo actionWithDuration:lapDuration bezier:bezier];
    
    ccBezierConfig bezier1;
    bezier1.controlPoint_1 = ccp(size.width*0.95,size.height*0.95);
    bezier1.controlPoint_2 =ccp(size.width*0.75,size.height*0.75);
    bezier1.endPosition = ccp(size.width-xOffset,size.height/2) ;
    id bezierForward2 = [CCBezierTo actionWithDuration:lapDuration bezier:bezier1];
    
    ccBezierConfig bezier2;
    bezier2.controlPoint_1 = ccp(size.width*0.95,size.height*0.25) ;
    bezier2.controlPoint_2 =ccp(size.width*0.75,size.height*0.10);
    bezier2.endPosition = ccp(size.width/2,0+yOffset);
    id bezierReturn = [CCBezierTo actionWithDuration:lapDuration bezier:bezier2];
    
    ccBezierConfig bezier3;
    bezier3.controlPoint_1 = ccp(size.width*0.15,0+size.height*0.10) ;
    bezier3.controlPoint_2 =ccp(size.width*0.30,size.height*0.25);
    bezier3.endPosition = ccp(xOffset,size.height/2);
    id bezierReturn2 = [CCBezierTo actionWithDuration:lapDuration bezier:bezier3];


    id stopLillySakteAction=[CCCallFunc actionWithTarget:self selector:@selector(lillyAnimationFinished)];
    self.lillyMoveAnimation=  [CCSequence actions:
                               bezierForward,
                               bezierForward2,
                               bezierReturn,
                               bezierReturn2,
                               stopLillySakteAction,
                               nil];
    [self.lilly runAction:self.skateAction];
    //[self.lilly runAction:[CCRepeatForever actionWithAction:self.lillyMoveAnimation]];
    [self.lilly runAction:self.lillyMoveAnimation];
    [self schedule:@selector(updateParticleSystem:) interval:0.1];
    
}

-(void) lillyAnimationFinished
{
    lapNumber+=1;
    if(lapNumber <8)
        [self runLillySkateAnimation];
    else
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:2.0 scene:[PageFourLayer scene] ]];
}

- (CGPoint) RotateAroundPt:(CGPoint) centerPt withAngle:(float)  radAngle withRadius:(float) radius  {
    
    float x = centerPt.x + cosf(radAngle) * radius;
    float y = centerPt.y + sinf(radAngle) * radius;
    return ccp(x, y);
}

float omega =0;
float theta=0;
float x0 = 100.0f; // center of circle in x dimension
float yZero = 100.0f; //

-(void)move:(ccTime)dt {
    theta += dt*omega;
    float x = x0 + cosf(theta);
    float y= yZero + sinf(theta);
    CGPoint location= ccp(x,y);
    [self.lilly runAction:[CCMoveTo actionWithDuration:1 position:location]];
}

/*
 -(void) addLillySprite
 {
 [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"page3-LillySkate.plist"];
 CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"page3-LillySkate.png"];
 [self addChild:spriteSheet];
 
 NSMutableArray *skateAnimFrames = [NSMutableArray array];
 for (int i=1; i<=25; i++) {
 NSString *frameName;
 if(i<10)
 {
 frameName=[NSString stringWithFormat:@"Layer-0%d.png",i];
 }
 else
 {
 frameName=[NSString stringWithFormat:@"Layer-%d.png",i];
 }
 [skateAnimFrames addObject:
 [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
 frameName]];//Layer-01.png
 }
 self.lilly = [CCSprite spriteWithSpriteFrameName:@"Layer-01.png"];
 //self.lilly = [CCSprite spriteWithFile:@"page3lilly.jpg"];
 self.lilly.position = ccp(400, 360);
 //self.lilly.scale=0.6;
 self.lilly.color=ccc3(255, 216, 0);
 [spriteSheet addChild:self.lilly];
 CCAnimation *skateAnimimation = [CCAnimation animationWithSpriteFrames:skateAnimFrames delay:0.3f];
 self.skateAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:skateAnimimation]];
 [self.lilly runAction:self.skateAction];
 }
 
 -(void) addLillySprite2
 {
 [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"page3-LillySkate.plist"];
 CCSpriteBatchNode *snowFallSpriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"page3-LillySkate.png"];
 [self addChild:snowFallSpriteSheet];
 
 NSMutableArray *snowFallAnimFrames = [NSMutableArray array];
 for (int i=1; i<=8; i++) {
 NSString *frameName;
 if(i<10)
 {
 frameName=[NSString stringWithFormat:@"Layer-0%d.png",i];
 }
 else
 {
 frameName=[NSString stringWithFormat:@"Layer-%d.png",i];
 }
 
 [snowFallAnimFrames addObject:
 [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
 frameName]];
 }
 self.lilly  = [CCSprite spriteWithSpriteFrameName:@"Layer-01.png"];
 self.lilly .position=ccp(850,330);
 [snowFallSpriteSheet addChild:self.lilly];
 CCAnimation *snowFallAnimimation = [CCAnimation animationWithSpriteFrames:snowFallAnimFrames delay:0.5f];
 self.skateAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:snowFallAnimimation]];
 [self.lilly runAction:self.skateAction];
 }
 
 -(void) addLillySprite1
 {
 [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"PageOne_SnowFall.plist"];
 CCSpriteBatchNode *snowFallSpriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"PageOne_SnowFall.png"];
 [self addChild:snowFallSpriteSheet];
 
 NSMutableArray *snowFallAnimFrames = [NSMutableArray array];
 for (int i=0; i<=8; i++) {
 [snowFallAnimFrames addObject:
 [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
 [NSString stringWithFormat:@"snow0%d.png",i]]];
 }
 self.lilly  = [CCSprite spriteWithSpriteFrameName:@"snow00.png"];
 self.lilly .position=ccp(850,330);
 [snowFallSpriteSheet addChild:self.lilly];
 CCAnimation *snowFallAnimimation = [CCAnimation animationWithSpriteFrames:snowFallAnimFrames delay:1.1f];
 self.skateAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:snowFallAnimimation]];
 [self.lilly runAction:self.skateAction];
 }
 -(void) addLillySprite3
 {
 CGSize size = [[CCDirector sharedDirector] winSize];
 [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"lilllyMovieclip.plist"];
 CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"lilllyMovieclip.png"];
 [self addChild:spriteSheet];
 
 NSMutableArray *skateAnimFrames = [NSMutableArray array];
 for (int i=10000; i<=10025; i++) {
 NSString *frameName;
 frameName=[NSString stringWithFormat:@"Symbol %d",i];
 
 [skateAnimFrames addObject:
 [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
 frameName]];//Layer-01.png
 }
 self.lilly = [CCSprite spriteWithSpriteFrameName:@"Symbol 10000"];
 //self.lilly = [CCSprite spriteWithFile:@"page3lilly.jpg"];
 self.lilly.position = ccp(size.width/2, size.height/2);
 //self.lilly.scale=0.6;
 self.lilly.color=ccc3(255, 216, 0);
 [spriteSheet addChild:self.lilly];
 CCAnimation *skateAnimimation = [CCAnimation animationWithSpriteFrames:skateAnimFrames delay:0.1f];
 self.skateAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:skateAnimimation]];
 [self.lilly runAction:self.skateAction];
 }
 -(void) addLillySprite6
 {
 CGSize size = [[CCDirector sharedDirector] winSize];
 [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"lillly1.plist"];
 CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"lillly1.png"];
 [self addChild:spriteSheet];
 
 NSMutableArray *skateAnimFrames = [NSMutableArray array];
 for (int i=20000; i<=10024; i++) {
 NSString *frameName;
 frameName=[NSString stringWithFormat:@"Symbol %d",i];
 
 [skateAnimFrames addObject:
 [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
 frameName]];//Layer-01.png
 }
 self.lilly = [CCSprite spriteWithSpriteFrameName:@"Symbol 20000"];
 //self.lilly = [CCSprite spriteWithFile:@"page3lilly.jpg"];
 self.lilly.position = ccp(size.width/2, size.height/2);
 //self.lilly.scale=0.6;
 self.lilly.color=ccc3(255, 216, 0);
 [spriteSheet addChild:self.lilly];
 CCAnimation *skateAnimimation = [CCAnimation animationWithSpriteFrames:skateAnimFrames delay:0.1f];
 self.skateAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:skateAnimimation]];
 [self.lilly runAction:self.skateAction];
 }
 -(void) addLillySprite5
 {
 [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"page3-LillySkate_default.plist"];
 CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"page3-LillySkate_default.png"];
 [self addChild:spriteSheet];
 
 NSMutableArray *skateAnimFrames = [NSMutableArray array];
 for (int i=1; i<=25; i++) {
 NSString *frameName;
 if(i<10)
 {
 frameName=[NSString stringWithFormat:@"Layer-0%d.png",i];
 }
 else
 {
 frameName=[NSString stringWithFormat:@"Layer-%d.png",i];
 }
 [skateAnimFrames addObject:
 [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
 frameName]];//Layer-01.png
 }
 self.lilly = [CCSprite spriteWithSpriteFrameName:@"Layer-01.png"];
 //self.lilly = [CCSprite spriteWithFile:@"page3lilly.jpg"];
 self.lilly.position = ccp(450, 350);
 //self.lilly.scale=0.6;
 self.lilly.color=ccc3(255, 216, 0);
 [spriteSheet addChild:self.lilly];
 CCAnimation *skateAnimimation = [CCAnimation animationWithSpriteFrames:skateAnimFrames delay:0.3f];
 self.skateAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:skateAnimimation]];
 [self.lilly runAction:self.skateAction];
 }
 
 - (void)drawBezierFrom:(CGPoint)from to:(CGPoint)to controlA:(CGPoint)a controlB:(CGPoint)b color:(NSUInteger)color
 {
 float qx, qy;
 float q1, q2, q3, q4;
 int plotx, ploty;
 float t = 0.0;
 
 while (t <= 1)
 {
 q1 = t*t*t*-1 + t*t*3 + t*-3 + 1;
 q2 = t*t*t*3 + t*t*-6 + t*3;
 q3 = t*t*t*-3 + t*t*3;
 q4 = t*t*t;
 
 qx = q1*from.x + q2*a.x + q3*b.x + q4*to.x;
 qy = q1*from.y + q2*a.y + q3*b.y + q4*to.y;
 
 plotx = round(qx);
 ploty = round(qy);
 
 [self drawPixelColor:color atX:plotx y:ploty];
 
 t = t + 0.003;
 }
 }
 */
@end
