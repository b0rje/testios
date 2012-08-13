attribute vec4 position;
attribute vec2 uv;

uniform mediump vec4 screen;

varying lowp vec2 varUV1;
varying lowp vec2 varUV2;
varying lowp vec2 varUV3;
varying lowp vec2 varUV4;
varying lowp vec2 varUV5;

void main()
{    
    
    mediump float scalh = screen.w;        
    mediump float dsize = 1.0/(screen.z*1.0 * scalh);
	lowp vec2 step = vec2(0.0,dsize);
    varUV3.x = uv.x * screen.y;
    varUV3.y = uv.y * screen.w;

    varUV2.xy = varUV3.xy - step;
//    varUV2.x = varUV3.x;
//    varUV2.y = varUV3.y - dsize;
    
    varUV1.xy = varUV2.xy - step;
//    varUV1.x = varUV3.x;
//    varUV1.y = varUV2.y - dsize;
    
    varUV4.xy = varUV3.xy + step;
//    varUV4.x = varUV3.x;
//    varUV4.y = varUV3.y + dsize;
    
    varUV5.xy = varUV4.xy + step;
//    varUV5.x = varUV3.x;
//    varUV5.y = varUV4.y + dsize;
    
    gl_Position = position;
}
