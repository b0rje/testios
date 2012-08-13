
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

    mediump float scalw = screen.y;        
    mediump float dsize = 1.0/(screen.x*1.0 * scalw);
    lowp vec2 step = vec2(dsize,0.0);
	
    varUV3.x = uv.x * screen.y;
    varUV3.y = uv.y * screen.w;

    varUV2.xy = varUV3.xy - step.xy;
//    varUV2.x = varUV3.x - dsize;
//    varUV2.y = varUV3.y;

    varUV1.xy = varUV2.xy - step.xy;
//    varUV1.x = varUV2.x - dsize;
//    varUV1.y = varUV3.y;

    varUV4.xy = varUV3.xy + step.xy;
//    varUV4.x = varUV3.x + dsize;
//    varUV4.y = varUV3.y;

    varUV5.xy = varUV4.xy + step.xy;
//    varUV5.x = varUV4.x + dsize;
//    varUV5.y = varUV3.y;

    gl_Position = position;
}
