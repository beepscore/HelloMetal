//
//  Shaders.metal
//  HelloMetal
//
//  Created by Steve Baker on 1/11/15.
//  Copyright (c) 2015 Beepscore LLC. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

// vertex shader
// float4 is a vector of 4 floats
// first parameter vertex_array is a pointer to a packed vector of 3 floats
// [[ ]] syntax can declare attributes such as resource locations, shader inputs.
// [[ buffer(0) ]] will be populated by the first buffer of data that
//  Metal code sends to vertex shader.
vertex float4 basic_vertex(const device packed_float3* vertex_array [[ buffer(0) ]],
                           unsigned int vid [[ vertex_id ]]) {
    // convert the vector to a float 4
    return float4(vertex_array[vid], 1.0);
}

// fragment shader
fragment half4 basic_fragment() {
    // return color white (1, 1, 1, 1)
    return half4(1.0);
}