//
//  LocationController.h
//  ActivityPlanner
//
//  Created by KudoShunsuke on 4/24/15.
//  Copyright (c) 2015 KudoShunsuke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationController : NSObject<CLLocationManagerDelegate>
{
    CLLocationManager *m_locationManager;
    bool m_updategps;
    bool m_gpsscenario;
    NSTimer *m_timer;
    CLLocation *m_location;
    CLHeading *m_heading;
    CLLocationDistance m_distance;
}

-(void)timercallback:(NSTimer*)timer;
-(void)startUpdateLocation;
-(void)stopUpdateLocation;
-(void)startUpdateHeading;
-(void)stopUpdateHeading;

@property (readonly)CLLocation* location;
@property (readonly)CLHeading* heading;
@property (readonly)CLLocationDistance distance;
@end

