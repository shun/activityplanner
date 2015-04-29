//
//  AppMainController.m
//  ActivityPlanner
//
//  Created by KudoShunsuke on 4/24/15.
//  Copyright (c) 2015 KudoShunsuke. All rights reserved.
//

#import "AppMainController.h"
#import "logtrace.h"

@implementation AppMainController
-(id)init
{
    TRACE_VERB(@"");
    self->m_sensormanager = [SensorManager getInstance];
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

-(void)runloop
{
    TRACE_VERB(@"");
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_async(queue, ^{
        //タスク
        int counter = 0;
        while (true)
        {
            NSLog(@"%d", counter);
            counter++;
            sleep(100);
        }
    });
}

@end
