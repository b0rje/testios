
uniform sampler2D texture;
varying lowp vec2 varUV;

uniform mediump vec4 screen;
uniform mediump vec4 steps;
uniform mediump vec4 gauss;

void main()
{

    mediump float scalw = screen.w;
    
    mediump float size4 = 1.0/(screen.z*0.25* scalw) ;
    mediump float size3 = 1.0/(screen.z*0.33333333333* scalw) ;
    mediump float size2 = 1.0/(screen.z*0.5 * scalw);
    mediump float size1 = 1.0/(screen.z*1.0* scalw) ;
    mediump vec4 sum = vec4(0.0);
    
    //sum += texture2D(texture, vec2(varUV.x, varUV.y - size4)) * 0.05;
    //sum += texture2D(texture, vec2(varUV.x, varUV.y - size3)) * 0.09;
    sum += texture2D(texture, vec2(varUV.x, varUV.y - size2)) * gauss.z;
    sum += texture2D(texture, vec2(varUV.x, varUV.y - size1)) * gauss.y;
    sum += texture2D(texture, vec2(varUV.x, 	    varUV.y)) * gauss.x;
    sum += texture2D(texture, vec2(varUV.x, varUV.y + size1)) * gauss.y;
    sum += texture2D(texture, vec2(varUV.x, varUV.y + size2)) * gauss.z;
    //sum += texture2D(texture, vec2(varUV.x, varUV.y + size3)) * 0.09;
    //sum += texture2D(texture, vec2(varUV.x, varUV.y + size4)) * 0.05;

    gl_FragColor = sum; //texture2D(texture,varUV);
    
}
