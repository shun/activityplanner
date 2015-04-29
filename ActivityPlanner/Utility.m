//
//  Utility.m
//  ActivityPlanner
//
//  Created by KudoShunsuke on 4/29/15.
//  Copyright (c) 2015 KudoShunsuke. All rights reserved.
//

#import "Utility.h"

@implementation Utility
+(NSString *)cnvDateToString:(NSDate*)date formatString:(NSString *)format
{
    NSString *ret = nil;

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"JST"]];
    [formatter setDateFormat:format];
    ret = [formatter stringFromDate:date];
    return ret;
}
@end
