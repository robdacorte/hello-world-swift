//
//  YoutubeTutorial.metal
//  Hello World
//
//  Created by Rob on 25/11/23.
//

#include <metal_stdlib>
using namespace metal;

// Palette function using half precision
half3 palette(half t) {
    half3 a = half3(0.5h, 0.5h, 0.5h);
    half3 b = half3(0.5h, 0.5h, 0.5h);
    half3 c = half3(1.0h, 1.0h, 1.0h);
    half3 d = half3(0.263h, 0.416h, 0.557h);
    return a + b * cos(6.28318h * (c * t + d));
}

// Main fragment shader function with [[stitchable]]
[[ stitchable ]] half4 youtubeTutorial(float2 position,
                            float2 size,
                            float time) {
    vector_half2 uv = half2((position * 2.0 - size) / size.y);
    vector_half2 uv0 = uv;
    // uv.y /= (size.y / size.x);

    vector_half3 finalColor = half3(0.0h);
    for (float i = 0.0; i < 4.0; i ++) {
        uv = fract(uv * 1.5h) - 0.5h;
        half d = length(uv) * exp(-length(uv0));
        half3 col = palette(length(uv) + half(i) * 0.4h + time * 0.4h);
        d = sin(d * 8.0h + time) / 8.0h;
        d = abs(d);
        d = pow(0.01h / d, 1.2h);
        finalColor += col * d;
    }

    return half4(finalColor, 1.0h);
}
