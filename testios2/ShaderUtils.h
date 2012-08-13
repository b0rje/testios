//
//  ShaderUtils.h
//  Kami
//
//  Created by cem on 12/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#ifndef Kami_ShaderUtils_h
#define Kami_ShaderUtils_h

#include <OpenGLES/ES2/gl.h>
#include <OpenGLES/ES2/glext.h>
#include <string>

class ShaderUtils
{
public:
    static GLuint loadShader(const char* name, GLenum type);
    static GLuint linkProgram(GLuint vertexSahder, GLuint fragmentShader);
    static GLuint createProgram(const char* vertexShader, const char* fragmentShader);
};

#endif
