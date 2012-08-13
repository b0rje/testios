//
//  Shader.fsh
//  testios2
//
//  Created by Boerje Sieling on 10.08.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
