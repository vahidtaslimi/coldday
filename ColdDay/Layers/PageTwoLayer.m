//
//  PageTwoLayer.m
//  ColdDay
//
//  Created by VT on 22/07/13.
//  Copyright (c) 2013 Shaghayegh. All rights reserved.
//

#import "PageTwoLayer.h"
#import "pageTwoSnow.h"
#import "PageOneLayer.h"
#import "SimpleAudioEngine.h"
#import "PageThreeLayer.h"
#import "PageFourLayer.h"
#import "PageThreeLayerNew.h"
#import "ccTypes.h"

NSUserDefaults *defaults;

@implementation PageTwoLayer
{
    
    
    
}

int _numberOfTimesPlayed;
bool _hasSnowFallStarted=false;
CCSprite *background;
        CDSoundSource* _teethSound;

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	PageTwoLayer *layer = [PageTwoLayer node];
	[scene addChild: layer];
	return scene;
}

-(id) init
{
    _numberOfTimesPlayed;
    _hasSnowFallStarted=false;
    
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

        _teethSound = [ [ SimpleAudioEngine sharedEngine ] soundSourceForFile:@"p2-teethcht.mp3" ];
        _teethSound.looping = YES;
        
        [self addLillySpriteSheet];
        
        lives = 5;
        hearthArray = [[NSMutableArray alloc] init];
        for(NSInteger i = 0; i<lives; i++){
            CCSprite *hearth = [CCSprite spriteWithFile:@"hearth.png"];
            [hearthArray insertObject:hearth atIndex:i];
            hearth.position = ccp( ((i+1)*50), size.height - 50);
            //[self addChild:hearth];
        }
        
        stars =5;
        starArray = [[NSMutableArray alloc] init];
        for(NSInteger i = 0; i<stars; i++){
            CCSprite *star = [CCSprite spriteWithFile:@"star.png"];
            [starArray insertObject:star atIndex:i];
            star.position = ccp( ((size.width-300)+(i*50)), size.height - 50);
            //[self addChild:star];
        }
       [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"p2-bg.mp3"];
            [[SimpleAudioEngine sharedEngine] setEffectsVolume:1.0];
        [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:0.6];
        [self addPauseMenuItem];
	}
	return self;
}


-(void) startSnow
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCParticleSnow *emitter =[[CCParticleSnow alloc]init];
    emitter.position=ccp(size.width/2,size.height);
    emitter.speed=30;
    [emitter setDuration:kCCParticleDurationInfinity];
    emitter.texture=[[CCTextureCache sharedTextureCache]addImage:@"page2snow1.png"];
    [self addChild:emitter];
    
    defaults = [NSUserDefaults standardUserDefaults];
    NSObject * object = [defaults objectForKey:@"sound"];
    if(object == nil){
        NSNumber *soundValue = [[NSNumber alloc ] initWithInt:1];
        [defaults setObject:soundValue forKey:@"sound"];
    }
    
    int soundDefault = [defaults integerForKey:@"sound"];
    if (soundDefault == 1) {
        //[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"backgroundSound.caf"];
        [[SimpleAudioEngine sharedEngine] setEffectsVolume:0.4f];
    }
    [self initSnows];
    _hasSnowFallStarted=true;
    
}


-(void)addLillySpriteSheet
{
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"p2-lilly-spritesheet.plist"];
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"p2-lilly-spritesheet.png"];
    [self addChild:spriteSheet];
    
    NSMutableArray *firstAnimFrames = [NSMutableArray array];
    for (int i=0; i<=5; i++) {
        [firstAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"lilly1-0%d.png",i]]];
    }
    CCAnimation *firstAnimimation = [CCAnimation animationWithSpriteFrames:firstAnimFrames delay:0.3f];
    self.firstLillyAction = [CCAnimate actionWithAnimation:firstAnimimation];
    
    NSMutableArray *winkAnimFrames = [NSMutableArray array];
    [winkAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"lilly1-00.png"]];
    [winkAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"lilly1-03.png"]];
    [winkAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"lilly1-01.png"]];
    CCAnimation *winkAnimimation = [CCAnimation animationWithSpriteFrames:winkAnimFrames delay:0.2f];
    self.winkAction = [CCAnimate actionWithAnimation:winkAnimimation];
    
    
    NSMutableArray *secondAnimFrames = [NSMutableArray array];
    for (int i=4; i<=5; i++) {
        [secondAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"lilly1-0%d.png",i]]];
    }
    
    CCAnimation *secondAnimimation = [CCAnimation animationWithSpriteFrames:secondAnimFrames delay:0.5f];
    CCSequence *secondSeq=[CCSequence actions:
                           [CCCallBlock actionWithBlock:^{
        _numberOfTimesPlayed++;
    }],
                           [CCDelayTime actionWithDuration:2],
                           [CCCallBlock actionWithBlock:^{
        
        [self.lilly runAction:[CCAnimate actionWithAnimation:secondAnimimation] ];
    }],
                           [CCCallBlock actionWithBlock:^{
        
        if(_numberOfTimesPlayed %2==0)
        {
            NSLog(@"%d",_numberOfTimesPlayed);
            [self.lilly runAction:self.winkAction];
        }
    }],
                           nil];
     self.secondtLillyAction = [CCRepeatForever actionWithAction:secondSeq];
    
    self.lilly = [CCSprite spriteWithSpriteFrameName:@"lilly1-00.png"];
    self.lilly.position = ccp(400, 310);
    //lilly.scale=0.6;
    [spriteSheet addChild:self.lilly];
    
    
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"p2-lilly-spritesheet2.plist"];
    CCSpriteBatchNode* spriteSheet2=[CCSpriteBatchNode batchNodeWithFile:@"p2-lilly-spritesheet2.png"];
    [self addChild:spriteSheet2];
    
    NSMutableArray *thirdAnimFrames = [NSMutableArray array];
    for (int i=0; i<=5; i++) {
        [thirdAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"lilly2-0%d.png",i]]];
    }
    CCAnimation *thirdAnimimation = [CCAnimation animationWithSpriteFrames:thirdAnimFrames delay:0.3f];
    self.thirdLillyAction = [CCAnimate actionWithAnimation:thirdAnimimation];
    
    NSMutableArray *shiverAnimFrames = [NSMutableArray array];
    [shiverAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"lilly2-04.png"]];
    [shiverAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"lilly2-05.png"]];
    [shiverAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"lilly2-04.png"]];
    CCAnimation *shiverAnimimation = [CCAnimation animationWithSpriteFrames:shiverAnimFrames delay:0.07f];
    self.shiverAction =[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:shiverAnimimation]];
    

    
    self.lillyShiver = [CCSprite spriteWithSpriteFrameName:@"lilly2-00.png"];
    self.lillyShiver.position = ccp(400, 310);
    self.lillyShiver.visible=false;
    [spriteSheet2 addChild:self.lillyShiver];
    
    CCSequence *firstSeq=[CCSequence actions:
                          self.firstLillyAction,
                          [CCDelayTime actionWithDuration:1],
                          [CCCallBlock actionWithBlock:^{
        [self.lilly runAction:self.secondtLillyAction];
    }]
                          , nil];
    [self.lilly runAction:firstSeq];
    
}

-(void)startLillyShiver
{
    [self.lillyShiver stopAllActions];
    
    CCSequence *seq=[CCSequence actions:
                     self.thirdLillyAction,
                     [CCDelayTime actionWithDuration:2],
                     [CCCallBlock actionWithBlock:^{
        [self.lillyShiver runAction:self.shiverAction];
              _teethSound= [[SimpleAudioEngine sharedEngine] playEffect:@"p2-teethcht.mp3" loop:YES];
        
    }]
                     , nil];
    
    [self.lillyShiver runAction:seq];
}

-(void)playSmileAction
{
    [self.lillyShiver stopAllActions];
    [[SimpleAudioEngine    sharedEngine]stopEffect:_teethSound];
    CCSequence *seq=[CCSequence actions:
                     [CCCallBlock actionWithBlock:^{
        CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"lilly2-06.png"];
        [self.lillyShiver setDisplayFrame:frame];
        
    }],
                     [CCDelayTime actionWithDuration:2],
                     [CCCallBlock actionWithBlock:^{
        [self startLillyShiver];
    }]
                     
                     , nil];
    
    [self.lillyShiver runAction:seq];
}

-(void) initSnows
{
    _snowsOnScreen = [[NSMutableArray alloc] init];
    _snows = [[NSMutableArray alloc] init];
    pageTwoSnow *m1 = [[pageTwoSnow alloc] init];
    [m1 setTag:(1)];
    [m1 setMonsterSprite:@"page2snow3.png"];
    [m1 setSplashSprite:@"page2snow4.png"];
    [m1 setMinVelocity:2];
    [m1 setMaxVelocity:8];
    [m1 setMovement:1];
    [m1 setKillMethod:1];
    [_snows addObject:m1];
    
    m1 = [[pageTwoSnow alloc] init];
    [m1 setTag:(2)];
    [m1 setMonsterSprite:@"page2snow1.png"];
    [m1 setSplashSprite:@"page2snow1.png"];
    [m1 setMinVelocity:4];
    [m1 setMaxVelocity:10];
    [m1 setMovement:2];
    [m1 setKillMethod:2];
    [_snows addObject:m1];
    
    m1 = [[pageTwoSnow alloc] init];
    [m1 setTag:(3)];
    [m1 setMonsterSprite:@"page2snow4.png"];
    [m1 setSplashSprite:@"page2snow4.png"];
    [m1 setMinVelocity:2];
    [m1 setMaxVelocity:8];
    [m1 setMovement:1];
    [m1 setKillMethod:1];
    [_snows addObject:m1];
    [self schedule:@selector(addSnows:) interval:0.5];
}


- (void) addSnows:(ccTime)dt {
    
    //select a random monster from the _monsters Array
    int selectedSnow= arc4random() % [_snows count];
    
    //get some monster caracteristics
    pageTwoSnow *snow = [_snows objectAtIndex:selectedSnow];
    int m = [snow movement];
    
    //!IMPORTANT -- Every Sprite in Screen must be an new CCSprite! Each Sprite can only be one time on screen
    CCSprite *spriteSnow = [[CCSprite alloc] initWithFile:[snow monsterSprite]];
    spriteSnow.tag = [snow tag];
    
    //BLOCK 1 - Determine where to spawn the monster along the Y axis
    CGSize winSize = [CCDirector sharedDirector].winSize;
    int minX = spriteSnow.contentSize.width / 2;
    int maxX = winSize.width - spriteSnow.contentSize.width/2;
    int rangeX = maxX - minX;
    int actualY = (arc4random() % rangeX) + minX;
    
    //BLOCK 2 - Determine speed of the monster
    int minDuration = [snow minVelocity];
    int maxDuration = [snow maxVelocity];
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    if(m == 1){ //STRAIGHT MOVIMENT
        
        //BLOCK 3 - Create the monster slightly off-screen along the right edge,
        // and along a random position along the Y axis as calculated above
        spriteSnow.position = ccp( actualY,winSize.height + spriteSnow.contentSize.height/2);
        [self addChild:spriteSnow];
        
        //BLOCK 4 - Create the actions
        CCMoveTo * actionMove = [CCMoveTo actionWithDuration:actualDuration position:ccp( actualY,-spriteSnow.contentSize.height/2)];
        CCCallBlockN * actionMoveDone = [CCCallBlockN actionWithBlock:^(CCNode *node) {
            [_snowsOnScreen removeObject:node];
            [node removeFromParentAndCleanup:YES];
            
            // Remove lifes
            /*lives--;
             [self removeChild:[hearthArray lastObject] cleanup:YES];
             [hearthArray removeLastObject];
             
             if(lives == 0)
             [[CCDirector sharedDirector] replaceScene:[PageOneLayer scene]];
             */
            
        }];
        
        [spriteSnow runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
        
        [_snowsOnScreen addObject:spriteSnow];
    }
    else if(m == 2){ //ZIGZAG-SNAKE MOVIMENT
        
        /* Create the monster slightly off-screen along the right edge,
         and along a random position along the Y axis as calculated above
         */
        spriteSnow.position = ccp( actualY,winSize.height + spriteSnow.contentSize.height/2);
        [self addChild:spriteSnow];
        
        CCCallBlockN * actionMoveDone = [CCCallBlockN actionWithBlock:^(CCNode *node) {
            [_snowsOnScreen removeObject:node];
            [node removeFromParentAndCleanup:YES];
            
            lives--;
            [self removeChild:[hearthArray lastObject] cleanup:YES];
            [hearthArray removeLastObject];
          //  [[SimpleAudioEngine sharedEngine] playEffect:@"p2-missed.mp3"];
            
            /* if(lives == 0)
             [[CCDirector sharedDirector] replaceScene:[PageOneLayer scene]];
             */
        }];
        
        // ZigZag movement Start
        NSMutableArray *arrayBezier = [[NSMutableArray alloc] init];
        ccBezierConfig bezier;
        id bezierAction1;
        float splitDuration = actualDuration / 6.0;
        for(int i = 0; i< 6; i++){
            
            if(i % 2 == 0){
                bezier.controlPoint_1 = ccp(actualY+100,winSize.height-(100+(i*200)));
                bezier.controlPoint_2 = ccp(actualY+100,winSize.height-(100+(i*200)));
                bezier.endPosition = ccp(actualY,winSize.height-(200+(i*200)));
                bezierAction1 = [CCBezierTo actionWithDuration:splitDuration bezier:bezier];
            }
            else{
                bezier.controlPoint_1 = ccp(actualY-100,winSize.height-(100+(i*200)));
                bezier.controlPoint_2 = ccp(actualY-100,winSize.height-(100+(i*200)));
                bezier.endPosition = ccp(actualY,winSize.height-(200+(i*200)));
                bezierAction1 = [CCBezierTo actionWithDuration:splitDuration bezier:bezier];
            }
            
            [arrayBezier addObject:bezierAction1];
        }
        
        [arrayBezier addObject:actionMoveDone];
        
        id seq = [CCSequence actionsWithArray:arrayBezier];
        
        [spriteSnow runAction:seq];
        // ZigZag movement End
        
        [_snowsOnScreen addObject:spriteSnow];
    }
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    NSMutableArray *monstersToDelete = [[NSMutableArray alloc] init];
    
    UITouch * touch = [[touches allObjects] objectAtIndex:0];
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    CGPoint location =[touch locationInView:[touch view]];
    
   /* if(CGRectContainsPoint(CGRectMake(1000, 750, 200, 200), location))
    {
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        [[SimpleAudioEngine sharedEngine] stopEffect:_teethSound];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[PageThreeLayerNew scene]]];
    }
    */
    if(_hasSnowFallStarted ==false)
    {
        //CCTexture2D* texture=[[CCTextureCache sharedTextureCache]addImage:@"P2-Lilly2.png"];
        
        [self startSnow];
        
        id delay = [CCDelayTime actionWithDuration: 2];
        id callbackAction = [CCCallBlock actionWithBlock:^{
            //[self.lilly setTexture:texture];
        } ];
        
        id sequence = [CCSequence actions: delay, callbackAction, nil];
        [self runAction: sequence];
        
        self.lillyShiver.visible=true;
        self.lilly.visible=false;
        [self startLillyShiver];
        
    }
    
    for (CCSprite *monster in _snowsOnScreen) {
        if (CGRectContainsPoint(monster.boundingBox, touchLocation)) {
            [monstersToDelete addObject:monster];
            
            //add animation with fade - splash
            pageTwoSnow *snow = [_snows objectAtIndex:(monster.tag-1)];
            snow.position = monster.position;
            CCSprite *splashPool = [[CCSprite alloc] initWithFile:[snow splashSprite]];
            splashPool.scale=0.5;
            
            if([snow killMethod] == 1){
                
                /*
                 splashPool.position = monster.position;
                 [self addChild:splashPool];
                 CCFadeOut *fade = [CCFadeOut actionWithDuration:2];  //this will make it fade
                 CCCallFuncN *remove = [CCCallFuncN actionWithTarget:self selector:@selector(removeSprite:)];
                 CCSequence *sequencia = [CCSequence actions: fade, remove, nil];
                 
                 [splashPool runAction:sequencia];
                 //finish splash
                 */
            }
            if([snow killMethod] == 2){ // Particles
                if(score<5)
                {
                    CCFadeOut *fade = [CCFadeOut actionWithDuration:2];
                    CCCallFuncND *emitter = [CCCallFuncND actionWithTarget:self selector:@selector(startExplosion:data:) data:monster];
                    CCCallFuncN *remove = [CCCallFuncN actionWithTarget:self selector:@selector(removeSprite:)];
                    CCSequence *sequencia = [CCSequence actions:emitter,fade,remove, nil];
                    
                    splashPool.position = monster.position;
                    [self addChild:splashPool];
                    
                    //if([defaults integerForKey:@"sound"]==1)
                    [[SimpleAudioEngine sharedEngine] playEffect:@"p2-ding.mp3"];
                    [splashPool runAction:sequencia];
                    CCSprite *star=[starArray objectAtIndex:score];
                    //star.color=ccc3(255, 216, 0);
                    [star runAction:[CCTintTo actionWithDuration:0.5 red:255 green:216 blue:0]];
                    
                    [self playSmileAction];
                    
                    score++;
                    if(score == 5)
                    {
                        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
                        [[SimpleAudioEngine sharedEngine] stopEffect:_teethSound];
                        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[PageThreeLayerNew scene]]];
                    }
                }
                
            }
            for (CCSprite *monster in monstersToDelete) {
                [monster stopAllActions];
                [_snowsOnScreen removeObject:monster];
                [self removeChild:monster cleanup:YES];
            }
            break;
        }
    }
    
    
}

-(void) removeSprite:(id)sender {
    [self removeChild:sender cleanup:YES];
}

//Positions the explosion emitter and sets it off
- (void)startExplosion:(id)sender data:(CCSprite*)monster {
    particleExplosion = [[CCParticleExplosion alloc] initWithTotalParticles:809];
    particleExplosion.texture = [[CCTextureCache sharedTextureCache] addImage:@"textureRed copy.png"];
    particleExplosion.life = 0.0f;
    particleExplosion.lifeVar = 0.708f;
    particleExplosion.startSize = 5;
    particleExplosion.startSizeVar = 4;
    particleExplosion.endSize = 2;
    particleExplosion.endSizeVar = 0;
    particleExplosion.angle = 360;
    particleExplosion.angleVar = 360;
    particleExplosion.speed = 243;
    particleExplosion.speedVar = 1;
    CGPoint g = CGPointMake(1.15, 1.58);
    particleExplosion.gravity = g;
    ccColor4F startC =ccc4FFromccc4B(ccc4(255,255,7,255));// {0.89f, 0.56f, 0.36f, 1.0f};
    particleExplosion.startColor = startC;
    ccColor4F endC =ccc4FFromccc4B(ccc4(255,255,7,50));;// {0.255f,0.255f,0.7f,1.0f};//{1.0f,0.0f,0.0f,1.0f};
    particleExplosion.endColor = endC;
    
    [self addChild:particleExplosion];
	particleExplosion.position = [monster position];
	[particleExplosion resetSystem];
}

-(void)createDustParticle{
    //make it local if you're going to remove it 1 second later...
    CCParticleSystemQuad *dustOnJump = [CCParticleSystemQuad particleWithFile:@"Dust.plist"];
    [self.parent.parent addChild:dustOnJump];
    dustOnJump.position = self.position;
    NSLog(@"createDustParticle");
    id waitForDust = [CCDelayTime actionWithDuration:1.0];
    id removeDust = [CCCallBlock actionWithBlock:^{
        [self removeChild:dustOnJump cleanup:YES];
    }];
    [self runAction:[CCSequence actions:waitForDust, removeDust,nil]];
}
@end
