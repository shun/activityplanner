//
//  AppDelegate.h
//  ActivityPlanner
//
//  Created by KudoShunsuke on 4/18/15.
//  Copyright (c) 2015 KudoShunsuke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppMainController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    AppMainController *m_maincontroller;
}
@property (strong, nonatomic) UIWindow *window;


@end

