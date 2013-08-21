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

NSUserDefaults *defaults;

@implementation PageTwoLayer
{
    
}


bool _hasSnowFallStarted=false;
CCSprite *background;

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	PageTwoLayer *layer = [PageTwoLayer node];
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
			background = [CCSprite spriteWithFile:@"P2-page2bg.png"];
		}
        
		background.position = ccp(size.width/2, size.height/2);
		[self addChild: background z:-1];        
        
        self.lilly=[CCSprite spriteWithFile:@"P2-Lilly1.png"];
        self.lilly.position=ccp(size.width/2, size.height/2);
        [self addChild:self.lilly];
        
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

-(void) initSnows
{
    _snowsOnScreen = [[NSMutableArray alloc] init];
    _snows = [[NSMutableArray alloc] init];
    pageTwoSnow *m1 = [[pageTwoSnow alloc] init];
    [m1 setTag:(1)];
    [m1 setMonsterSprite:@"page2snow1.png"];
    [m1 setSplashSprite:@"page2snow2.png"];
    [m1 setMinVelocity:2];
    [m1 setMaxVelocity:8];
    [m1 setMovement:1];
    [m1 setKillMethod:1];
    [_snows addObject:m1];
    
    m1 = [[pageTwoSnow alloc] init];
    [m1 setTag:(2)];
    [m1 setMonsterSprite:@"page2snow1.png"];
    [m1 setSplashSprite:@"page2snow2.png"];
    [m1 setMinVelocity:4];
    [m1 setMaxVelocity:10];
    [m1 setMovement:2];
    [m1 setKillMethod:2];
    [_snows addObject:m1];
    
    m1 = [[pageTwoSnow alloc] init];
    [m1 setTag:(3)];
    [m1 setMonsterSprite:@"page2snow1.png"];
    [m1 setSplashSprite:@"page2snow2.png"];
    [m1 setMinVelocity:2];
    [m1 setMaxVelocity:8];
    [m1 setMovement:1];
    [m1 setKillMethod:1];
    [_snows addObject:m1];
    [self schedule:@selector(addSnows:) interval:0.5];
}


- (void) addSnows:(ccTime)dt {
    
    //select a random monster from the _monsters Array
    int selectedMonster = arc4random() % [_snows count];
    
    //get some monster caracteristics
    pageTwoSnow *monster = [_snows objectAtIndex:selectedMonster];
    int m = [monster movement];
    
    //!IMPORTANT -- Every Sprite in Screen must be an new CCSprite! Each Sprite can only be one time on screen
    CCSprite *spriteMonster = [[CCSprite alloc] initWithFile:[monster monsterSprite]];
    spriteMonster.tag = [monster tag];
    
    //BLOCK 1 - Determine where to spawn the monster along the Y axis
    CGSize winSize = [CCDirector sharedDirector].winSize;
    int minX = spriteMonster.contentSize.width / 2;
    int maxX = winSize.width - spriteMonster.contentSize.width/2;
    int rangeX = maxX - minX;
    int actualY = (arc4random() % rangeX) + minX;
    
    //BLOCK 2 - Determine speed of the monster
    int minDuration = [monster minVelocity];
    int maxDuration = [monster maxVelocity];
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    if(m == 1){ //STRAIGHT MOVIMENT
        
        //BLOCK 3 - Create the monster slightly off-screen along the right edge,
        // and along a random position along the Y axis as calculated above
        spriteMonster.position = ccp( actualY,winSize.height + spriteMonster.contentSize.height/2);
        [self addChild:spriteMonster];
        
        //BLOCK 4 - Create the actions
        CCMoveTo * actionMove = [CCMoveTo actionWithDuration:actualDuration position:ccp( actualY,-spriteMonster.contentSize.height/2)];
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
        
        [spriteMonster runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
        
        [_snowsOnScreen addObject:spriteMonster];
    }
    else if(m == 2){ //ZIGZAG-SNAKE MOVIMENT
        
        /* Create the monster slightly off-screen along the right edge,
         and along a random position along the Y axis as calculated above
         */
        spriteMonster.position = ccp( actualY,winSize.height + spriteMonster.contentSize.height/2);
        [self addChild:spriteMonster];
        
        CCCallBlockN * actionMoveDone = [CCCallBlockN actionWithBlock:^(CCNode *node) {
            [_snowsOnScreen removeObject:node];
            [node removeFromParentAndCleanup:YES];
            
            lives--;
            [self removeChild:[hearthArray lastObject] cleanup:YES];
            [hearthArray removeLastObject];
            [[SimpleAudioEngine sharedEngine] playEffect:@"P2-Missed.mp3"];
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
        
        [spriteMonster runAction:seq];
        // ZigZag movement End
        
        [_snowsOnScreen addObject:spriteMonster];
    }
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    NSMutableArray *monstersToDelete = [[NSMutableArray alloc] init];
    
    UITouch * touch = [[touches allObjects] objectAtIndex:0];
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
        CGPoint location =[touch locationInView:[touch view]];
    
    if(CGRectContainsPoint(CGRectMake(1000, 750, 200, 200), location))
    {
      [[CCDirector sharedDirector] replaceScene:[PageThreeLayer scene]];
    }
    
    if(_hasSnowFallStarted ==false)
    {
           CCTexture2D* texture=[[CCTextureCache sharedTextureCache]addImage:@"P2-Lilly2.png"];
        [self startSnow];
        id delay = [CCDelayTime actionWithDuration: 2];
        id callbackAction = [CCCallBlock actionWithBlock:^{
                     [self.lilly setTexture:texture];
        } ];
        
        id sequence = [CCSequence actions: delay, callbackAction, nil];
        [self runAction: sequence];
        
    }
    
    for (CCSprite *monster in _snowsOnScreen) {
        if (CGRectContainsPoint(monster.boundingBox, touchLocation)) {
            [monstersToDelete addObject:monster];
            
            //add animation with fade - splash
            pageTwoSnow *m = [_snows objectAtIndex:(monster.tag-1)];
            m.position = monster.position;
    CCSprite *splashPool = [[CCSprite alloc] initWithFile:[m splashSprite]];
            
            if([m killMethod] == 1){
               /* splashPool.position = monster.position;
                [self addChild:splashPool];
                
                CCFadeOut *fade = [CCFadeOut actionWithDuration:3];  //this will make it fade
                CCCallFuncN *remove = [CCCallFuncN actionWithTarget:self selector:@selector(removeSprite:)];
                CCSequence *sequencia = [CCSequence actions: fade, remove, nil];
                if([defaults integerForKey:@"sound"]==1)
                    [[SimpleAudioEngine sharedEngine] playEffect:@"SplatEffect.caf"];
                [splashPool runAction:sequencia];
                //finish splash*/
                
            }
            if([m killMethod] == 2){ // Particles
            
                
                CCCallFuncND *emitter = [CCCallFuncND actionWithTarget:self selector:@selector(startExplosion:data:) data:monster];
                CCSequence *sequencia = [CCSequence actions:emitter, nil];
                
                //if([defaults integerForKey:@"sound"]==1)
                    [[SimpleAudioEngine sharedEngine] playEffect:@"P2-Smashed.mp3"];
                [splashPool runAction:sequencia];
                CCSprite *star=[starArray objectAtIndex:score];
                //star.color=ccc3(255, 216, 0);
                [star runAction:[CCTintTo actionWithDuration:0.5 red:255 green:216 blue:0]];
                score++;
                if(score == 5)
                    [[CCDirector sharedDirector] replaceScene:[PageThreeLayer scene]];
                
                for (CCSprite *monster in monstersToDelete) {
                    [monster stopAllActions];
                    [_snowsOnScreen removeObject:monster];
                    [self removeChild:monster cleanup:YES];
                }
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
    particleExplosion.texture = [[CCTextureCache sharedTextureCache] addImage:@"textureRed.png"];
    particleExplosion.life = 0.0f;
    particleExplosion.lifeVar = 0.708f;
    particleExplosion.startSize = 40;
    particleExplosion.startSizeVar = 38;
    particleExplosion.endSize = 14;
    particleExplosion.endSizeVar = 0;
    particleExplosion.angle = 360;
    particleExplosion.angleVar = 360;
    particleExplosion.speed = 243;
    particleExplosion.speedVar = 1;
    CGPoint g = CGPointMake(1.15, 1.58);
    particleExplosion.gravity = g;
    ccColor4F startC =  {0.89f, 0.56f, 0.36f, 1.0f};
    particleExplosion.startColor = startC;
    ccColor4F endC = {1.0f,0.0f,0.0f,1.0f};
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
