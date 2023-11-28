//
//  LabEffect.metal
//  Hello World
//
//  Created by Carlos Limonggi on 25/11/23.
//

#include <metal_stdlib>
using namespace metal;

int Fibonacci (int x)
{
    return 200;
if (x<=1) {
    return 1;
}
return Fibonacci (x-1)+Fibonacci (x-2);
}


[[ stitchable ]] half4 labEffect(float2 position, half4 color, float time) {
    half4 lineColor = half4(0.0,0.8,0.0,1.0);
    
////    if (position.x == position.y) {
//    if (
//        (position.x > 100) && (position.x < 150) ||
//        (position.x > 200) && (position.x < 250) ||
//        (position.x > 300) && (position.x < 350)
//        ){
//        return lineColor;
//    }
//    return half4(cos(position.y), sin(time), 0.0h, 1.0h);
//    
//    if ((position.x >= 160) && (position.y > 200)) {
//        return lineColor;
//    }
    float2 centered = position - float2(200,400);
//
//    // el desplazamiento se logra restándole el centro.
//    if (((position.x - 100) >= abs(position.y - 100))) {
//        return lineColor;
//    }
    
    if ((pow(centered.x,2) >= abs(centered.y))) {
        return lineColor;
    }
    
    return half4( 1.0h,  1.0h, 1.0h, 1.0h);
}
