//
//  ViewController.m
//  testios2
//
//  Created by Boerje Sieling on 10.08.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#include "ShaderUtils.h"
#include "FramebufferTexture.h"
#import "EAGLView.h"
#include "MarchingCubes.h"

#define BUFFER_OFFSET(i) ((char *)NULL + (i))

#define GLERR { GLenum err = glGetError(); if(err != GL_NO_ERROR) NSLog(@"GLERR line %i: %i",__LINE__,err); } 

int WIDTH;
int HEIGHT;

// Uniform index.
enum
{
    UNIFORM_MODELVIEWPROJECTION_MATRIX,
    UNIFORM_NORMAL_MATRIX,
    UNIFORM_TEXTURE,
    UNIFORM_SCREEN,
    NUM_UNIFORMS
};
GLint uniforms[NUM_UNIFORMS];

// Attribute index.
enum
{
    ATTRIB_VERTEX,
    ATTRIB_NORMAL,
    ATTRIB_UV,
    NUM_ATTRIBUTES,
};

GLubyte *testTextureBM;

//GLfloat gauss[] = {0.383f,0.243f,0.065f,0.0f};
GLfloat gauss[] = {1.0f,0.0f,0.0f,0.0f};
GLfloat steps[] = {0.0f,0.0f,0.0f,0.0f};

GLfloat screenQuad[30] = 
{
    // Data layout for each line below is:
    // positionX, positionY, positionZ,     normalX, normalY, normalZ,
    -1.0f,  1.0f, -0.0f,        0.0f, 1.0f,
    -1.0f, -1.0f, -0.0f,        0.0f, 0.0f,
     1.0f,  1.0f, -0.0f,        1.0f, 1.0f,

     1.0f,  1.0f, -0.0f,        1.0f, 1.0f,
    -1.0f, -1.0f, -0.0f,        0.0f, 0.0f,
     1.0f, -1.0f, -0.0f,        1.0f, 0.0f,

};

GLfloat gCubeVertexData[216] = 
{
    // Data layout for each line below is:
    // positionX, positionY, positionZ,     normalX, normalY, normalZ,
    0.5f, -0.5f, -0.5f,        1.0f, 0.0f, 0.0f,
    0.5f, 0.5f, -0.5f,         1.0f, 0.0f, 0.0f,
    0.5f, -0.5f, 0.5f,         1.0f, 0.0f, 0.0f,
    0.5f, -0.5f, 0.5f,         1.0f, 0.0f, 0.0f,
    0.5f, 0.5f, -0.5f,          1.0f, 0.0f, 0.0f,
    0.5f, 0.5f, 0.5f,         1.0f, 0.0f, 0.0f,
    
    0.5f, 0.5f, -0.5f,         0.0f, 1.0f, 0.0f,
    -0.5f, 0.5f, -0.5f,        0.0f, 1.0f, 0.0f,
    0.5f, 0.5f, 0.5f,          0.0f, 1.0f, 0.0f,
    0.5f, 0.5f, 0.5f,          0.0f, 1.0f, 0.0f,
    -0.5f, 0.5f, -0.5f,        0.0f, 1.0f, 0.0f,
    -0.5f, 0.5f, 0.5f,         0.0f, 1.0f, 0.0f,
    
    -0.5f, 0.5f, -0.5f,        -1.0f, 0.0f, 0.0f,
    -0.5f, -0.5f, -0.5f,       -1.0f, 0.0f, 0.0f,
    -0.5f, 0.5f, 0.5f,         -1.0f, 0.0f, 0.0f,
    -0.5f, 0.5f, 0.5f,         -1.0f, 0.0f, 0.0f,
    -0.5f, -0.5f, -0.5f,       -1.0f, 0.0f, 0.0f,
    -0.5f, -0.5f, 0.5f,        -1.0f, 0.0f, 0.0f,
    
    -0.5f, -0.5f, -0.5f,       0.0f, -1.0f, 0.0f,
    0.5f, -0.5f, -0.5f,        0.0f, -1.0f, 0.0f,
    -0.5f, -0.5f, 0.5f,        0.0f, -1.0f, 0.0f,
    -0.5f, -0.5f, 0.5f,        0.0f, -1.0f, 0.0f,
    0.5f, -0.5f, -0.5f,        0.0f, -1.0f, 0.0f,
    0.5f, -0.5f, 0.5f,         0.0f, -1.0f, 0.0f,
    
    0.5f, 0.5f, 0.5f,          0.0f, 0.0f, 1.0f,
    -0.5f, 0.5f, 0.5f,         0.0f, 0.0f, 1.0f,
    0.5f, -0.5f, 0.5f,         0.0f, 0.0f, 1.0f,
    0.5f, -0.5f, 0.5f,         0.0f, 0.0f, 1.0f,
    -0.5f, 0.5f, 0.5f,         0.0f, 0.0f, 1.0f,
    -0.5f, -0.5f, 0.5f,        0.0f, 0.0f, 1.0f,
    
    0.5f, -0.5f, -0.5f,        0.0f, 0.0f, -1.0f,
    -0.5f, -0.5f, -0.5f,       0.0f, 0.0f, -1.0f,
    0.5f, 0.5f, -0.5f,         0.0f, 0.0f, -1.0f,
    0.5f, 0.5f, -0.5f,         0.0f, 0.0f, -1.0f,
    -0.5f, -0.5f, -0.5f,       0.0f, 0.0f, -1.0f,
    -0.5f, 0.5f, -0.5f,        0.0f, 0.0f, -1.0f
};

@implementation ViewController

VertexBuffer buffer(10000*3,6);

- (void)setupGL
{
    testMC(buffer);
    EAGLView* eaglView = [EAGLView sharedView];
    _context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:_context];

    
    GLuint depthBuffer = 0;
    
    glGenFramebuffers(1, &viewBackedFrameBuffer);
    glBindFramebuffer(GL_FRAMEBUFFER, viewBackedFrameBuffer);
    
    glGenRenderbuffers(1, &viewBackedRenderBuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, viewBackedRenderBuffer);
    [_context renderbufferStorage:GL_RENDERBUFFER fromDrawable:[eaglView eaglLayer]];
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, viewBackedRenderBuffer);
    
    
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_WIDTH, &WIDTH);
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_HEIGHT, &HEIGHT);
    
    NSLog(@"size: %d %d \n",WIDTH, HEIGHT);
    
//        glGenRenderbuffers(1, &depthBuffer);
//        glBindRenderbuffer(GL_RENDERBUFFER, depthBuffer);
//        glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT16, WIDTH, HEIGHT);
//        glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, depthBuffer);
    
    GLenum status = glCheckFramebufferStatus(GL_FRAMEBUFFER);
    if (status != GL_FRAMEBUFFER_COMPLETE)
    {
        NSLog(@"Framebuffer not complete. Status is : %X", status);
    }
    glViewport(0, 0,WIDTH, HEIGHT);

    //glBindFramebuffer(GL_FRAMEBUFFER, 0);

    
//    [EAGLContext setCurrentContext:self.context];

    
    _program = ShaderUtils::createProgram("Shader.vsh", "Shader.fsh");
	_vboProgram = ShaderUtils::createProgram("Post.vsh", "Post.fsh");
	_vboProgram2 = ShaderUtils::createProgram("Post2.vsh", "Post.fsh");
       
    
    testTextureBM = (GLubyte*) malloc(WIDTH*HEIGHT*4);
    for(int i=0;i<WIDTH;i++)
        for(int j=0;j<HEIGHT;j++) {
            testTextureBM[(i*HEIGHT+j)*4 + 0] = 0;    
            testTextureBM[(i*HEIGHT+j)*4 + 1] = 255;    
            testTextureBM[(i*HEIGHT+j)*4 + 2] = 0;    
            testTextureBM[(i*HEIGHT+j)*4 + 3] = 255;    
        }
    
    glGenTextures(1, &_testTexture);
    glBindTexture(GL_TEXTURE_2D, _testTexture);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
	glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, 256, 256, 0, GL_RGBA, GL_UNSIGNED_BYTE, testTextureBM);
    glBindTexture(GL_TEXTURE_2D, 0);

    glEnable(GL_DEPTH_TEST);
        
    glGenBuffers(1, &_vertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
    //glBufferData(GL_ARRAY_BUFFER, sizeof(gCubeVertexData), gCubeVertexData, GL_STATIC_DRAW);
    glBufferData(GL_ARRAY_BUFFER, buffer.getByteSize(), buffer.getValues(), GL_STATIC_DRAW);
            
    glGenBuffers(1, &_qvbo);
    glBindBuffer(GL_ARRAY_BUFFER, _qvbo);
    glBufferData(GL_ARRAY_BUFFER, sizeof(screenQuad), screenQuad, GL_STATIC_DRAW);
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    
    _renderTexture = new FramebufferTexture(WIDTH/2,HEIGHT/2,GL_RGB);    
    _renderTexture2 = new FramebufferTexture(WIDTH/2,HEIGHT/2,GL_RGB);        
    _renderTexture->createFrambuffer(GL_DEPTH_COMPONENT16);
    _renderTexture2->createFrambuffer();

    NSLog(@"fbo 1 %d",_renderTexture->m_framebuffer);
    NSLog(@"fbo 2 %d",_renderTexture2->m_framebuffer);
    GLERR;
    
}

- (void)tearDownGL
{
    //[EAGLContext setCurrentContext:self.context];
    
    glDeleteBuffers(1, &_vertexBuffer);
    
    //self.effect = nil;
    
    if (_program) {
        glDeleteProgram(_program);
        _program = 0;
    }
}

#pragma mark - GLKView and GLKViewController delegate methods

- (void)update:(float)passedTime
{
    float aspect = fabsf((float)WIDTH/(float)HEIGHT);
    GLKMatrix4 projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0f), aspect, 0.1f, 100.0f);
    
    GLKMatrix4 baseModelViewMatrix = GLKMatrix4MakeTranslation(0.0f, 0.0f, -4.0f);
    baseModelViewMatrix = GLKMatrix4Rotate(baseModelViewMatrix, _rotation, 0.0f, 1.0f, 0.0f);
            
    // Compute the model view matrix for the object rendered with ES2
    GLKMatrix4 modelViewMatrix = GLKMatrix4MakeTranslation(0.0f, 0.0f, 0.0f);
    modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, _rotation, 1.0f, 1.0f, 1.0f);
    modelViewMatrix = GLKMatrix4Multiply(baseModelViewMatrix, modelViewMatrix);
    
    _normalMatrix = GLKMatrix3InvertAndTranspose(GLKMatrix4GetMatrix3(modelViewMatrix), NULL);
    
    _modelViewProjectionMatrix = GLKMatrix4Multiply(projectionMatrix, modelViewMatrix);
    
    
    _rotation += passedTime * 0.5f;
}

- (void)draw
{
    //[EAGLContext setCurrentContext:_context];

    //GLint origBuffer;
    //glGetIntegerv(GL_FRAMEBUFFER_BINDING, &origBuffer);

    glEnable(GL_DEPTH_TEST);

    glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
    glBindFramebuffer(GL_FRAMEBUFFER, _renderTexture->m_framebuffer);

    glClearColor(0.65f, 1.0f, 0.65f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    GLuint attPosition = glGetAttribLocation(_program, "position");
    GLuint attNormal = glGetAttribLocation(_program, "normal");
    glEnableVertexAttribArray(attPosition);
    glVertexAttribPointer(attPosition, 3, GL_FLOAT, GL_FALSE, 24, BUFFER_OFFSET(0));
    glEnableVertexAttribArray(attNormal);
    glVertexAttribPointer(attNormal, 3, GL_FLOAT, GL_FALSE, 24, BUFFER_OFFSET(12));
	
    // Render the object again with ES2
    glUseProgram(_program);
    
    GLuint unifProj = glGetUniformLocation(_program, "modelViewProjectionMatrix");
    GLuint unifNorm = glGetUniformLocation(_program, "normalMatrix");
    glUniformMatrix4fv(unifProj, 1, 0, _modelViewProjectionMatrix.m);
    glUniformMatrix3fv(unifNorm, 1, 0, _normalMatrix.m);

    glViewport(0, 0,_renderTexture->m_width, _renderTexture->m_height);
    
    glEnable(GL_CULL_FACE);
    glDrawArrays(GL_TRIANGLES, 0, buffer.elems());
 
    const GLenum discards = {GL_DEPTH_ATTACHMENT};
    glDiscardFramebufferEXT(GL_FRAMEBUFFER, 1, &discards);

    /////////////////////////////

    glDisable(GL_DEPTH_TEST);

    glBindFramebuffer(GL_FRAMEBUFFER,_renderTexture2->m_framebuffer);
    
    //glClearColor(0.65f, 0.65f, 0.65f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    glBindBuffer(GL_ARRAY_BUFFER, _qvbo);
    
    attPosition = glGetAttribLocation(_vboProgram, "position");
    GLuint attUV = glGetAttribLocation(_vboProgram, "uv");
    
    glEnableVertexAttribArray(attPosition);
    glVertexAttribPointer(attPosition, 3, GL_FLOAT, GL_FALSE, 20, BUFFER_OFFSET(0));
    glEnableVertexAttribArray(attUV);
    glVertexAttribPointer(attUV, 2, GL_FLOAT, GL_FALSE, 20, BUFFER_OFFSET(12));
    
    glUseProgram(_vboProgram);
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, _renderTexture->m_texId);
    glUniform4f(glGetUniformLocation(_vboProgram, "gauss"), gauss[0],gauss[1],gauss[2],gauss[3]);
    glUniform4f(glGetUniformLocation(_vboProgram, "steps"), steps[0],steps[1],steps[2],steps[3]);
    glUniform1i(glGetUniformLocation(_vboProgram, "texture"), 0);
    glUniform4f(glGetUniformLocation(_vboProgram, "screen"),
                _renderTexture->m_width,(float)_renderTexture->m_width/(float)_renderTexture->m_p2width,
                _renderTexture->m_height,(float)_renderTexture->m_height/(float)_renderTexture->m_p2height);
    glViewport(0, 0,_renderTexture2->m_width, _renderTexture2->m_height);
   
    glDrawArrays(GL_TRIANGLES, 0, 6);

    /////////////////////////////
    
    glBindFramebuffer(GL_FRAMEBUFFER,viewBackedFrameBuffer);
    
    //glClearColor(0.65f, 0.65f, 0.65f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    //glBindBuffer(GL_ARRAY_BUFFER, _qvbo);
    
//    attPosition = glGetAttribLocation(_vboProgram2, "position");
//    attUV = glGetAttribLocation(_vboProgram2, "uv");
//    
//    glEnableVertexAttribArray(attPosition);
//    glVertexAttribPointer(attPosition, 3, GL_FLOAT, GL_FALSE, 20, BUFFER_OFFSET(0));
//    glEnableVertexAttribArray(attUV);
//    glVertexAttribPointer(attUV, 2, GL_FLOAT, GL_FALSE, 20, BUFFER_OFFSET(12));
        
    glUseProgram(_vboProgram2);
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, _renderTexture2->m_texId);
    glUniform4f(glGetUniformLocation(_vboProgram, "gauss"), gauss[0],gauss[1],gauss[2],gauss[3]);
    glUniform4f(glGetUniformLocation(_vboProgram, "steps"), steps[0],steps[1],steps[2],steps[3]);
    glUniform1i(glGetUniformLocation(_vboProgram2, "texture"), 0);
    glUniform4f(glGetUniformLocation(_vboProgram2, "screen"),
                _renderTexture2->m_width,(float)_renderTexture2->m_width/(float)_renderTexture2->m_p2width,
                _renderTexture2->m_height,(float)_renderTexture2->m_height/(float)_renderTexture2->m_p2height);
    glViewport(0, 0,WIDTH, HEIGHT);

    glDrawArrays(GL_TRIANGLES, 0, 6);
    //NSLog(@"%x",glGetError());
   
   // glClearColor(1.0f, 0.0f, 0.0f, 1.0f);
   // glClear(GL_COLOR_BUFFER_BIT);
    
    glBindRenderbuffer(GL_RENDERBUFFER, viewBackedRenderBuffer);
    [_context presentRenderbuffer:GL_RENDERBUFFER];

}

#pragma mark -  OpenGL ES 2 shader compilation

@end
