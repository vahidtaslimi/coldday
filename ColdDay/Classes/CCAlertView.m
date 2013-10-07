//
//  CCAlertView.m
//  ColdDay
//
//  Created by VT on 7/10/13.
//  Copyright (c) 2013 Shaghayegh. All rights reserved.
//

#import "CCAlertView.h"

#import "CCAlertView.h"

#define FONTNAME @"HelveticaNeue-Bold"

@implementation CCAlertView

@synthesize Message, SubMessage, Button1, Button2, button1Target, button1Selector, button2Target, button2Selector;

-(id) init  {
    
    if((self == [super init]))
        
    {
        self.isTouchEnabled = YES;
        //tODO
        alertViewSprite = [CCSprite spriteWithFile:@"pn.png"];
        [self addChild:alertViewSprite z:-1];
        // 287X139
        //CGSize size = CGSizeMake(287, 139);
        CGSize size = alertViewSprite.contentSize;
        self.anchorPoint = ccp(0,0);
        
        //self.Message = @"Do You Want to Try Again?";
        //self.SubMessage = @"All Game Data Will Be Reset!";
        Button1 = @"Okay";
        Button2 = @"Cancel";
        
        NSString * previousFontName = [CCMenuItemFont fontName];
        int previousFontSize = [CCMenuItemFont fontSize];
        
        [CCMenuItemFont setFontName:FONTNAME];
        [CCMenuItemFont setFontSize:18];
        
        OK = [CCMenuItem itemFromString:Button1 target:self selector:@selector(buttonOneClicked:)];
        Cancel = [CCMenuItem itemFromString:Button2 target:self selector:@selector(buttonTwoClicked:)];
        
        [CCMenuItemFont setFontName:previousFontName];
        [CCMenuItemFont setFontSize:previousFontSize];
        
        OK.anchorPoint = ccp(.5,0);
        Cancel.anchorPoint = ccp(.5,0);
        
        CCMenu *alertMenu = [CCMenu menuWithItems:Cancel, OK, nil];
        alertMenu.anchorPoint = ccp(.5,0);
        [alertMenu alignItemsHorizontallyWithPadding:10];
        alertMenu.position = ccp(size.width/2, 0);
        [alertViewSprite addChild:alertMenu];
        
        alertViewSprite.scale = .6;
        alertViewSprite.opacity = 150;
        
        id fadeIn = [CCFadeIn actionWithDuration:0.1];
        id scale1 = [CCSpawn actions:fadeIn, [CCScaleTo actionWithDuration:0.15 scale:1.1], nil];
        id scale2 = [CCScaleTo actionWithDuration:0.1 scale:0.9];
        id scale3 = [CCScaleTo actionWithDuration:0.05 scale:1.0];
        id pulse = [CCSequence actions:scale1, scale2, scale3, nil];
        
        [alertViewSprite runAction:pulse];
    }
    
    return self;
}

-(void) buttonOneClicked:(id) sender
{
    [self removeFromParentAndCleanup:YES];
    
    NSMethodSignature * sig = nil;
    
    if( button1Target && button1Selector ) {
        sig = [button1Target methodSignatureForSelector:button1Selector];
        
        NSInvocation *invocation = nil;
        invocation = [NSInvocation invocationWithMethodSignature:sig];
        [invocation setTarget:button1Target];
        [invocation setSelector:button1Selector];
#if NS_BLOCKS_AVAILABLE
        if ([sig numberOfArguments] == 3)
#endif
            [invocation setArgument:&self atIndex:2];
        
        [invocation invoke];
    }
}

-(void) buttonTwoClicked:(id) sender
{
    [self removeFromParentAndCleanup:YES];
    
    NSMethodSignature * sig = nil;
    
    if( button2Target && button2Selector ) {
        sig = [button2Target methodSignatureForSelector:button2Selector];
        
        NSInvocation *invocation = nil;
        invocation = [NSInvocation invocationWithMethodSignature:sig];
        [invocation setTarget:button2Target];
        [invocation setSelector:button2Selector];
#if NS_BLOCKS_AVAILABLE
        if ([sig numberOfArguments] == 3)
#endif
            [invocation setArgument:&self atIndex:2];
        
        [invocation invoke];
    }
}

-(void)setMessage:(NSString *)Message_{
    if (Message == nil) {
        [MessageLabel removeFromParentAndCleanup:YES];
    }
    [Message release];
    Message = [Message_ retain];
    
    if (Message_ != nil) {
        
        MessageLabel = [CCLabelTTF labelWithString:Message fontName:FONTNAME fontSize:18 strokeSize:1 stokeColor:ccBLACK];
        MessageLabel.anchorPoint = ccp(.5,1);
        MessageLabel.position = ccp(alertViewSprite.contentSize.width/2, alertViewSprite.contentSize.height);
        [alertViewSprite addChild:MessageLabel];
    }
}

-(void)setSubMessage:(NSString *)SubMessage_{
    if (SubMessage == nil) {
        [SubMessageLabel removeFromParentAndCleanup:YES];
    }
    [SubMessage release];
    SubMessage = [SubMessage_ retain];
    
    if (SubMessage_ != nil) {
        SubMessageLabel = [CCLabelTTF labelWithString:SubMessage fontName:FONTNAME fontSize:14 strokeSize:1 stokeColor:ccBLACK];
        SubMessageLabel.position = ccp(alertViewSprite.contentSize.width/2, alertViewSprite.contentSize.height/2);
        [alertViewSprite addChild:SubMessageLabel];
    }
}

-(void)setButton1:(NSString *)Button1_{
    if (Button1_ == nil) {
        Button1 = @" ";
    }else{
        Button1 = [Button1_ retain];
    }
    [OK setString:Button1];
    
}

-(void)setButton2:(NSString *)Button2_{
    if (Button2_ == nil) {
        Button2 = @" ";
    }else{
        Button2 = [Button2_ retain];
    }
    [Cancel setString:Button2];
}

@end

/*
 CCMenuItemFontWithStroke * quit = [CCMenuItemFontWithStroke itemFromString:@"Quit" block:^(id sender){
 if ([defaults boolForKey:PlaySoundEffectsKey]) {
 [[SimpleAudioEngine sharedEngine] playEffect:MenuClickSound];
 }
 
 CCAlertView *alertView = [[CCAlertView alloc] init];
 alertView.isRelativeAnchorPoint = YES;
 alertView.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
 alertView.Message = @"Are you sure?";
 alertView.SubMessage = @"Your progress will not be saved.";
 alertView.Button1 = @"Yes";
 alertView.button1Target = self;
 alertView.button1Selector = @selector(quit:);
 alertView.Button2 = @"NO";
 
 [self addChild:alertView z:1001];
 
 }];

*/