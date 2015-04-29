//
//  SensorManager.m
//  ActivityPlanner
//
//  Created by KudoShunsuke on 4/24/15.
//  Copyright (c) 2015 KudoShunsuke. All rights reserved.
//

#import "SensorManager.h"
#import "logtrace.h"
#import "Utility.h"

@implementation SensorManager

-(id)init
{
    TRACE_VERB(@"");
    self->m_logfile = NULL;
    self->m_wroteLogHeader = false;
    self->m_locationcontroller = [[LocationController alloc] init];
    [self->m_locationcontroller startUpdateLocation];
    
    m_logheader = [[NSArray alloc] initWithObjects:
                   @"Time",
                   // LocationController
                   @"GPS Time",
                   @"Latitude",
                   @"Longitude",
                   @"Altitude",
                   @"HorizontalAccuracy",
                   @"VerticalAccuracy",
                   @"Course",
                   @"Speed",
                   // MotionActivityController
                   // MotionController
                   nil];
    self->m_timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timercallback:) userInfo:nil repeats:YES];
    return self;
}

+ (instancetype)getInstance
{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}


-(void)openSensorLog
{
    if (self->m_logfile != NULL)
    {
        return;
    }
    
    char pathName[PATH_MAX];
    sprintf(pathName,"%s/%s",[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] UTF8String],"sensorlog.csv");
    
    // Additionally write
    self->m_logfile = fopen(pathName, "a");
    if (NULL == self->m_logfile)
    {
        TRACE_ERROR(@"fail to open sensor.log : %s", pathName);
    }
}

-(void)writeSensorLogHeader
{
    for (NSString *item in m_logheader)
    {
        fprintf(self->m_logfile, "%s,", [item UTF8String]);
    }
    fprintf(self->m_logfile, "\n");
    self->m_wroteLogHeader = true;
}

-(void)writeSensorLog
{
    [self openSensorLog];
    
    if (!self->m_wroteLogHeader)
    {
        [self writeSensorLogHeader];
    }
    fprintf(self->m_logfile, "%s,", [[Utility cnvDateToString:[NSDate date] formatString:@"yyyy/MM/dd HH:mm:ss"] UTF8String]);
    [self writeLocationLog];

    fprintf(self->m_logfile, "\n");
    fflush(self->m_logfile);
}

-(void)writeLocationLog
{
    fprintf(self->m_logfile, "%s,", [[Utility cnvDateToString:self->m_locationcontroller.location.timestamp formatString:@"yyyy/MM/dd HH:mm:ss"] UTF8String]);
    fprintf(self->m_logfile, "%f,", self->m_locationcontroller.location.coordinate.latitude);
    fprintf(self->m_logfile, "%f,", self->m_locationcontroller.location.coordinate.longitude);
    fprintf(self->m_logfile, "%f,", self->m_locationcontroller.location.altitude);
    fprintf(self->m_logfile, "%f,", self->m_locationcontroller.location.horizontalAccuracy);
    fprintf(self->m_logfile, "%f,", self->m_locationcontroller.location.verticalAccuracy);
    fprintf(self->m_logfile, "%f,", self->m_locationcontroller.location.course);
    fprintf(self->m_logfile, "%f,", self->m_locationcontroller.location.speed);
}

-(void)writeMotionLog
{
    
}

-(void)writeMotionActivityLog
{
    
}

-(void)timercallback:(NSTimer *)timer
{
    [self writeSensorLog];
}

@end
