//
//  EAGLView.cpp
//  Kami
//
//  Created by Cem Aslan on 1/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EAGLView.h"

static EAGLView* view = nil;

@implementation EAGLView



+ (Class) layerClass
{
    return [CAEAGLLayer class];
}

+ (id) viewWithFrame:(CGRect)frame
{
	return [[[self alloc] initWithFrame:frame] autorelease];
}

- (id) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        CAEAGLLayer* eaglLayer = (CAEAGLLayer*) self.layer;
        eaglLayer.opaque = true;
        eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [NSNumber numberWithBool:FALSE], kEAGLDrawablePropertyRetainedBacking, kEAGLColorFormatRGBA8, kEAGLDrawablePropertyColorFormat, nil];

        view = self;
    }
    return self;
}


- (void) dealloc
{
    [super dealloc];
}

+ (EAGLView*) sharedView
{
    return view;
}

- (CAEAGLLayer*) eaglLayer
{
    return (CAEAGLLayer*) self.layer;
}



@end

