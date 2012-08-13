//
//  FramebufferTexture.h
//  testios2
//
//  Created by Boerje Sieling on 11.08.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#ifndef testios2_FramebufferTexture_h
#define testios2_FramebufferTexture_h

#include <OpenGLES/ES2/GL.h>

class FramebufferTexture {

public:
    
	GLuint m_texId;    
    GLuint m_width;
    GLuint m_height;
    GLuint m_p2width;
    GLuint m_p2height;

    GLuint m_framebuffer;
    
    FramebufferTexture(GLuint width, GLuint height, GLenum type);
    void createFrambuffer(GLenum depthType = -1);
    
    GLfloat getRatioW() { return m_width / m_p2width; }
    GLfloat getRatioH() { return m_height / m_p2height; }
    
};

#endif
