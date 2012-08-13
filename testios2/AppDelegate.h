//
//  AppDelegate.h
//  testios2
//
//  Created by Boerje Sieling on 10.08.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    CADisplayLink* m_displayLink;
    CFTimeInterval m_applicationStart;
    ViewController* m_controller;
}
@property (strong, nonatomic) UIWindow *window;

@end
