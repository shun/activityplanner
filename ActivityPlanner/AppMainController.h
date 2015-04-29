//
//  AppMainController.h
//  ActivityPlanner
//
//  Created by KudoShunsuke on 4/24/15.
//  Copyright (c) 2015 KudoShunsuke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SensorManager.h"

@interface AppMainController : NSObject
{
    SensorManager *m_sensormanager;
}
+ (instancetype)getInstance;
-(void)runloop;
@end
