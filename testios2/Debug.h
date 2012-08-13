//
//  Debug.h
//  Kami
//
//  Created by cem on 12/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#ifndef Kami_Debug_h
#define Kami_Debug_h

#include "Logger.h"
#include <stdio.h>

#define LOG_LEVEL_DEBUG 0
#define LOG_LEVEL_INFO 1
#define LOG_LEVEL_WARN 2
#define LOG_LEVEL_ERROR 3

#define LOG_LEVEL_NO_LOG 100

#define LOG_LEVEL LOG_LEVEL_DEBUG

#ifndef DEBUG
#if LOG_LEVEL != LOG_LEVEL_NO_LOG
#undef LOG_LEVEL
#define LOG_LEVEL LOG_LEVEL_ERROR
#endif
#endif

#define LOG_(level,  s, ...) Logger::Log(level,__FILE__,__LINE__); printf(s, ##__VA_ARGS__); printf("\n");

#if LOG_LEVEL <= LOG_LEVEL_DEBUG
    #define LOG_DEBUG(s, ... ) LOG_("DEBUG",s, ##__VA_ARGS__)
#else
    #define LOG_DEBUG(s, ... )
#endif

#if LOG_LEVEL <= LOG_LEVEL_WARN
    #define LOG_WARN(s, ... ) LOG_("WARN",s, ##__VA_ARGS__)
#else
    #define LOG_WARN(s, ... )
#endif

#if LOG_LEVEL <= LOG_LEVEL_INFO
    #define LOG_INFO(s, ... ) LOG_("INFO",s, ##__VA_ARGS__)
#else
    #define LOG_INFO(s, ... )
#endif

#if LOG_LEVEL <= LOG_LEVEL_ERROR
    #define LOG_ERR(s, ... ) LOG_("ERROR",s, ##__VA_ARGS__)
#else
    #define LOG_ERR(s, ... )
#endif


#endif
