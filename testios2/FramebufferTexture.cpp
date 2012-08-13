//
//  FramebufferTexture.cpp
//  testios2
//
//  Created by Boerje Sieling on 11.08.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#include "FramebufferTexture.h"

GLint nextPowerOf2(GLint x) {
    x--;
    x |= x >> 1;
    x |= x >> 2;
    x |= x >> 4;
    x |= x >> 8;
    x |= x >> 16;
    x++;
	return x;
}

void FramebufferTexture::createFrambuffer(GLenum depthType) {
    
    glGenFramebuffers(1, &m_framebuffer);
    GLint orig;
    glGetIntegerv(GL_FRAMEBUFFER_BINDING, &orig);
    glBindFramebuffer(GL_FRAMEBUFFER, m_framebuffer);
    glFramebufferTexture2D(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_TEXTURE_2D, m_texId, 0);
    
    if (depthType != -1) {
        GLuint depthBuffer;
        glGenRenderbuffers(1, &depthBuffer);
        glBindRenderbuffer(GL_RENDERBUFFER, depthBuffer);
        glRenderbufferStorage(GL_RENDERBUFFER,depthType,m_p2width,m_p2height);
        glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, depthBuffer);        
    }
    
    glBindFramebuffer(GL_FRAMEBUFFER, orig);

}

FramebufferTexture::FramebufferTexture(GLuint width, GLuint height, GLenum type) {
    
    m_width = width;
	m_height = height;
    m_p2width = nextPowerOf2(width);
    m_p2height = nextPowerOf2(height);
    
    glGenTextures(1, &m_texId);
    glBindTexture(GL_TEXTURE_2D, m_texId);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
	glTexImage2D(GL_TEXTURE_2D, 0, type, m_p2width, m_p2height, 0, type, GL_UNSIGNED_BYTE, 0);

}
