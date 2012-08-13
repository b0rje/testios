//
//  Logger.cpp
//  Kami
//
//  Created by cem on 12/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#include "Logger.h"
#include <string>

void Logger::Log(const char* level, const char* file, int line)
{
    std::string filestr(file);
    int idx = filestr.find("/Kami");
    if (idx != std::string::npos)
        filestr = filestr.substr(idx);
    printf("<%s %s:%d> ",level,filestr.c_str(), line);
}

