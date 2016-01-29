//
//  main.m
//  Mac Enrolment Utility
//
//  Created by Gavin on 29/01/2016.
//  Copyright © 2016 gavin. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AppleScriptObjC/AppleScriptObjC.h>

int main(int argc, const char * argv[]) {
    [[NSBundle mainBundle] loadAppleScriptObjectiveCScripts];
    return NSApplicationMain(argc, argv);
}
