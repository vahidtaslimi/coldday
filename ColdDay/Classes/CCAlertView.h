//
//  CCAlertView.h
//  ColdDay
//
//  Created by VT on 7/10/13.
//  Copyright (c) 2013 Shaghayegh. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"

@interface CCAlertView : CCLayer {
    NSString *Message;
    NSString *SubMessage;
    NSString *Button1;
    NSString *Button2;
    
    CCSprite *alertViewSprite;
    
    CCLabelTTF *MessageLabel;
    CCLabelTTF *SubMessageLabel;
    CCMenuItem *OK;
    CCMenuItem *Cancel;
    
    id button1Target;
    SEL button1Selector;
    
    id button2Target;
    SEL button2Selector;
    
}

@property (nonatomic, retain) NSString *Message;
@property (nonatomic, retain) NSString *SubMessage;
@property (nonatomic, retain) NSString *Button1;
@property (nonatomic, retain) NSString *Button2;
@property (nonatomic, retain) id button1Target;
@property (nonatomic) SEL button1Selector;
@property (nonatomic, retain) id button2Target;
@property (nonatomic) SEL button2Selector;
@end