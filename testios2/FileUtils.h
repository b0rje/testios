//
//  FileUtils.h
//  Kami
//
//  Created by cem on 12/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#ifndef Kami_FileUtils_h
#define Kami_FileUtils_h

#include <string>

class FileUtils
{
public:
    static const char* getAppPath();
    static const std::string loadResource(const char* path, const char* filename);
};

#endif
