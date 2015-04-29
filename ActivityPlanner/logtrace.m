//
//  logtrace.m
//  ActivityPlanner
//
//  Created by KUDO Shunsuke on 2015/04/23.
//  Copyright (c) 2015年 KUDO Shunsuke. All rights reserved.
//

#import "logtrace.h"

@implementation LogTrace

-(id)init
{
    self->m_tracelevel = TRACE_LVL_VERB;
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

-(void) trace:(int)level filePath:(NSString*)filepath lineNum:(unsigned int)linenum functionString:(const char *)function formatString:(NSString *)format, ...
{
    if ((self->m_tracelevel == TRACE_LVL_NONE) ||
        (level < self->m_tracelevel)) return;
    
    NSArray *levels = [[NSArray alloc] initWithObjects:@"[NONE] ", @"[VERB] ", @"[DEBUG]", @"[INFO] ", @"[WARN] ", @"[ERROR]", nil];
    NSString *header = [[NSString alloc] initWithFormat:@"%@ %@(%d) [%s]", [levels objectAtIndex:level], [filepath lastPathComponent], linenum, function];
    
    va_list args;
    va_start(args, format);
    NSString * contents = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    NSLog(@"%@ %@", header, contents);
}
@end
