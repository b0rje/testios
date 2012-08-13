
uniform sampler2D texture;

varying lowp vec2 varUV1;
varying lowp vec2 varUV2;
varying lowp vec2 varUV3;
varying lowp vec2 varUV4;
varying lowp vec2 varUV5;

uniform mediump vec4 screen;
uniform mediump vec4 steps;
uniform mediump vec4 gauss;

void main()
{

    /*mediump float scalw = screen.y;
    
    mediump float size4 = 1.0/(screen.x*0.25 * scalw);
    mediump float size3 = 1.0/(screen.x*0.33333333333 * scalw);
    mediump float size2 = 1.0/(screen.x*0.5 * scalw);
    mediump float size1 = 1.0/(screen.x*1.0 * scalw);*/

    lowp vec4 sum = vec4(0.0);
    
    //sum += texture2D(texture, vec2(varUV.x - size4, varUV.y)) * 0.05;
    //sum += texture2D(texture, vec2(varUV.x - size3, varUV.y)) * 0.09;
    //sum += texture2D(texture, vec2(varUV.x - size2, varUV.y)) * gauss.z;
    //sum += texture2D(texture, vec2(varUV.x - size1, varUV.y)) * gauss.y;
    //sum += texture2D(texture, vec2(varUV.x, 	    varUV.y)) * gauss.x;
    //sum += texture2D(texture, vec2(varUV.x + size1, varUV.y)) * gauss.y;
    //sum += texture2D(texture, vec2(varUV.x + size2, varUV.y)) * gauss.z;
    //sum += texture2D(texture, vec2(varUV.x + size3, varUV.y)) * 0.09;
    //sum += texture2D(texture, vec2(varUV.x + size4, varUV.y)) * 0.05;

    sum.xyz += texture2D(texture, varUV1).xyz * gauss.z;
    sum.xyz += texture2D(texture, varUV2).xyz * gauss.y;
    sum.xyz += texture2D(texture, varUV3).xyz * gauss.x;
    sum.xyz += texture2D(texture, varUV4).xyz * gauss.y;
    sum.xyz += texture2D(texture, varUV5).xyz * gauss.z;

    gl_FragColor = sum; //texture2D(texture,varUV);
    
}
