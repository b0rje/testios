//
//  ViewController.h
//  testios2
//
//  Created by Boerje Sieling on 10.08.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#undef __ARM_NEON__
#import <GLKit/GLKit.h>
#include "FramebufferTexture.h"


@interface ViewController : NSObject
{
    GLuint _program;
    GLuint _vboProgram;
    GLuint _vboProgram2;
    
    GLKMatrix4 _modelViewProjectionMatrix;
    GLKMatrix3 _normalMatrix;
    float _rotation;
    
    GLuint viewBackedFrameBuffer;
    GLuint viewBackedRenderBuffer;
    GLuint _depthBuffer;
    GLuint _frameBuffer;
    GLuint _vertexBuffer;
    GLuint _renderBuffer;
    GLuint _testTexture;
    
    EAGLContext * _context;
    
    FramebufferTexture* _renderTexture;
    FramebufferTexture* _renderTexture2;
    
    GLuint _qvbo;
    
    
}

- (void)setupGL;
- (void)tearDownGL;
- (void) update:(float)passedTime;
- (void) draw;
- (BOOL)loadShaders;
- (BOOL)loadVboShaders;
- (BOOL)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file;
- (BOOL)linkProgram:(GLuint)prog;
- (BOOL)validateProgram:(GLuint)prog;
@end
