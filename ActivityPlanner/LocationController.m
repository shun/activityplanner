//
//  LocationController.m
//  ActivityPlanner
//
//  Created by KudoShunsuke on 4/24/15.
//  Copyright (c) 2015 KudoShunsuke. All rights reserved.
//

#import "LocationController.h"
#import "logtrace.h"
@implementation LocationController
@synthesize location = m_location;
@synthesize heading = m_heading;
@synthesize distance = m_distance;

-(id)init
{
    TRACE_VERB(@"");
    self->m_gpsscenario = false;
    self->m_updategps = false;
    self->m_distance = 0.0;
    self->m_location = nil;
    self->m_heading = nil;
    
    self->m_locationManager = [[CLLocationManager alloc] init];
    self->m_locationManager.pausesLocationUpdatesAutomatically = NO;    // 一定時間GPSが更新されな買った場合、自動的に停止させない
    self->m_locationManager.delegate = self;
    self->m_locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    
    
    if ([CLLocationManager headingAvailable]) {
        // 方位の変更通知は22.5度（16方向）
        CLLocationDegrees headingFilter = 22.5;

        // GPSの更新通知は10m以上
        self->m_locationManager.distanceFilter = 10.0;

        // Deviceの上部を基準とする
        CLDeviceOrientation headingOrientation = CLDeviceOrientationPortrait;
        self->m_locationManager.headingFilter = headingFilter;
        self->m_locationManager.headingOrientation = headingOrientation;
    }
    return self;
}

-(void)timercallback:(NSTimer*)timer
{
    TRACE_VERB(@"");
    
}

-(void)startUpdateLocation
{
    TRACE_VERB(@"");
    if ([self->m_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
    {
        TRACE_VERB(@"This OS is after iOS8");
        [self->m_locationManager requestAlwaysAuthorization];
    }
    else
    {
        TRACE_VERB(@"This OS is before iOS8");
        [self->m_locationManager startUpdatingLocation];
    }
    self->m_timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(timercallback:) userInfo:nil repeats:YES];
}

-(void)stopUpdateLocation
{
    TRACE_VERB(@"");
    [self->m_locationManager stopUpdatingLocation];
    [self->m_timer invalidate];
}

-(void)startUpdateHeading
{
    TRACE_VERB(@"");
    [self->m_locationManager startUpdatingHeading];
}

-(void)stopUpdateHeading
{
    TRACE_VERB(@"");
    [self->m_locationManager stopUpdatingHeading];
}

#pragma mark delegate:CLLocationManager
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    TRACE_VERB(@"");
    double distance = 0.0;
    CLLocation *lastlocation = [locations lastObject];
    
    distance = [self->m_location distanceFromLocation:lastlocation];
    
    if ((nil != self->m_location) && (distance < 10.0))
    {
        // 移動距離が10m未満の場合は移動していないと判断する
        TRACE_DEBUG(@"stay position : %f", distance);
        return;
    }
    self->m_distance = distance;
    TRACE_DEBUG(@"distance : %f", self->m_distance);
    self->m_location = lastlocation;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    TRACE_VERB(@"");
    self->m_heading = newHeading;
    TRACE_DEBUG(@"trueHeading = %f",newHeading.trueHeading);
    TRACE_DEBUG(@"magneticHeading = %f",newHeading.magneticHeading);
}

-(void)locationManagerDidPauseLocationUpdates:(CLLocationManager *)manager
{
    TRACE_VERB(@"");
}

-(void)locationManagerDidResumeLocationUpdates:(CLLocationManager *)manager
{
    TRACE_VERB(@"");
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusAuthorizedAlways ||
        status == kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        TRACE_DEBUG(@"start updating location\n");
        [manager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didVisit:(CLVisit *)visit
{
    TRACE_DEBUG(@"arrivalDate = %@",visit.arrivalDate);
    TRACE_DEBUG(@"departureDate = %@",visit.departureDate);
}

@end
