//
//  main.m
//  ColdDay
//
//  Created by VT on 14/07/13.
//  Copyright Shaghayegh 2013. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char *argv[]) {
    
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil,NSStringFromClass([AppController class]));// @"AppController");
    [pool release];
    return retVal;
    //vahid
}
