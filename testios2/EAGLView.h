//
//  EAGLView.h
//  Kami
//
//  Created by Cem Aslan on 1/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface EAGLView : UIView
{
}

+ (id) viewWithFrame:(CGRect)frame;
+ (EAGLView*) sharedView;
- (CAEAGLLayer*) eaglLayer;
@end
