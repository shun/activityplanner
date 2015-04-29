//
//  SensorManager.h
//  ActivityPlanner
//
//  Created by KudoShunsuke on 4/24/15.
//  Copyright (c) 2015 KudoShunsuke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationController.h"

@interface SensorManager : NSObject
{
    LocationController *m_locationcontroller;
    FILE *m_logfile;
    bool m_wroteLogHeader;
    NSTimer *m_timer;
    NSArray *m_logheader;
}
+ (instancetype)getInstance;
-(void)openSensorLog;
-(void)writeSensorLog;
-(void)writeSensorLogHeader;
-(void)writeLocationLog;
-(void)writeMotionLog;
-(void)writeMotionActivityLog;
-(void)timercallback:(NSTimer *)timer;
@end
