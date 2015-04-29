//
//  logtrace.h
//  ActivityPlanner
//
//  Created by KUDO Shunsuke on 2015/04/23.
//  Copyright (c) 2015年 KUDO Shunsuke. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ENABLE_TRACE 1
//#define DISABLE_TRACE_VERB
//#define DISABLE_TRACE_DEBUG
//#define DISABLE_TRACE_INFO
//#define DISABLE_TRACE_WARN
//#define DISABLE_TRACE_ERROR

#define TRACE_LVL_NONE      (0)
#define TRACE_LVL_VERB      (1)
#define TRACE_LVL_DEBUG     (2)
#define TRACE_LVL_INFO      (3)
#define TRACE_LVL_WARN      (4)
#define TRACE_LVL_ERROR     (5)

#if ENABLE_TRACE && !defined(DONOT_TRACE)

#if !defined(DISABLE_TRACE_VERB)
#define TRACE_VERB(...)  [[LogTrace getInstance] trace:TRACE_LVL_VERB  filePath:@__FILE__ lineNum:__LINE__ functionString:__FUNCTION__ formatString:__VA_ARGS__]
#else
#define TRACE_VERB(...)
#endif  // ENABLE_TRACE_VERB

#if !defined(DISABLE_TRACE_DEBUG)
#define TRACE_DEBUG(...) [[LogTrace getInstance] trace:TRACE_LVL_DEBUG filePath:@__FILE__ lineNum:__LINE__ functionString:__FUNCTION__ formatString:__VA_ARGS__]
#else
#define TRACE_DEBUG(...)
#endif  // ENABLE_TRACE_DEBUG

#if !defined(DISABLE_TRACE_INFO)
#define TRACE_INFO(...)  [[LogTrace getInstance] trace:TRACE_LVL_INFO  filePath:@__FILE__ lineNum:__LINE__ functionString:__FUNCTION__ formatString:__VA_ARGS__]
#else
#define TRACE_INFO(...)
#endif  // ENABLE_TRACE_INFO

#if !defined(DISABLE_TRACE_WARN)
#define TRACE_WARN(...)  [[LogTrace getInstance] trace:TRACE_LVL_WARN  filePath:@__FILE__ lineNum:__LINE__ functionString:__FUNCTION__ formatString:__VA_ARGS__]
#else
#define TRACE_WARN(...)
#endif  // ENABLE_TRACE_WARN

#if !defined(DISABLE_TRACE_ERROR)
#define TRACE_ERROR(...) [[LogTrace getInstance] trace:TRACE_LVL_ERROR filePath:@__FILE__ lineNum:__LINE__ functionString:__FUNCTION__ formatString:__VA_ARGS__]
#else
#define TRACE_ERROR(...)
#endif  // ENABLE_TRACE_ERROR

#else
#define TRACE_VERB(...)
#define TRACE_DEBUG(...)
#define TRACE_INFO(...)
#define TRACE_WARN(...)
#define TRACE_ERROR(...)
#endif

@interface LogTrace : NSObject
{
    int m_tracelevel;
}
+ (instancetype)getInstance;
-(void) trace:(int)level filePath:(NSString*)filepath lineNum:(unsigned int)linenum functionString:(const char *)function formatString:(NSString *)format, ...;
@end
