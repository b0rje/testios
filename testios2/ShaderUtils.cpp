//
//  ShaderUtils.cpp
//  Kami
//
//  Created by cem on 12/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#include "ShaderUtils.h"
#include "FileUtils.h"
#include "Debug.h"

GLuint ShaderUtils::createProgram(const char* vertexShader, const char* fragmentShader) {
 	GLuint vs = loadShader(vertexShader, GL_VERTEX_SHADER);   
 	GLuint fs = loadShader(fragmentShader, GL_FRAGMENT_SHADER);   
    return linkProgram(vs,fs);
}

GLuint ShaderUtils::loadShader(const char* name, GLenum type)
{
    GLuint shader = glCreateShader(type);
    const char* shaderCode = FileUtils::loadResource(FileUtils::getAppPath(), name).c_str();
    glShaderSource(shader, 1, &shaderCode, NULL);
    glCompileShader(shader);
    GLint status = 0;
    glGetShaderiv(shader, GL_COMPILE_STATUS, &status);
    if (status != GL_TRUE)
    {
        LOG_ERR("Compilation of shader %s failed.",name);
        GLint infoLogLength = 0;
        glGetShaderiv(shader, GL_INFO_LOG_LENGTH, &infoLogLength);
        if (infoLogLength > 1)
        {
            char* log = (char*)malloc(infoLogLength);
            glGetShaderInfoLog(shader, infoLogLength, NULL, log);
            LOG_DEBUG("Shader Compile Log:\n %s",log);
            free(log);
        }
        glDeleteShader(shader);
        return NULL;
    }
    return shader;
}

GLuint ShaderUtils::linkProgram(GLuint vertexShader, GLuint fragmentShader)
{
    GLuint program = glCreateProgram();
    glAttachShader(program, vertexShader);
    glAttachShader(program, fragmentShader);
    glLinkProgram(program);
    GLint status = 0;
    glGetProgramiv(program, GL_LINK_STATUS, &status);
    if (status != GL_TRUE)
    {
        LOG_ERR("Failed to link shader Program!");
        GLint infoLogLength = 0;
        glGetProgramiv(program, GL_INFO_LOG_LENGTH, &infoLogLength);
        if (infoLogLength > 1)
        {
            char* log = (char*)malloc(infoLogLength);
            glGetProgramInfoLog(program, infoLogLength, NULL, log);
            LOG_DEBUG("Program Link Log:\n %s", log);
            free(log);
        }
        glDeleteProgram(program);
        return NULL;
    }
    return program;
}