//
//  FileUtils.mm
//  Kami
//
//  Created by cem on 12/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#include "FileUtils.h"
#include "Debug.h"

static char* appPath = NULL;

const char* FileUtils::getAppPath()
{
    if (appPath == NULL)
    {
        NSString* nsapppath = [[NSBundle mainBundle] resourcePath];
        appPath = (char*) malloc([nsapppath length]+1 );
        memcpy(appPath, [nsapppath cStringUsingEncoding:1], [nsapppath length]);
        appPath[[nsapppath length] ] = 0;
    }
    return appPath;
}

const std::string FileUtils::loadResource(const char* path, const char* name)
{
    NSString* resourceName = [NSString stringWithFormat:@"%s/%s",path,name];
    NSData* d = [NSData dataWithContentsOfFile:resourceName];
    if(d != nil) {
        std::string content((const char *)[d bytes], [d length]);
        return content;
    } else {
        LOG_ERR("Failed to load file %s", name);
        return std::string();
    }
}
