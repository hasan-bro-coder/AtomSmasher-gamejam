shader_type canvas_item;

// --- Uniforms --- //
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap; 
uniform float saturation;

void fragment() {
    vec4 tex_color = texture(SCREEN_TEXTURE, SCREEN_UV);

    COLOR.rgb = mix(vec3(dot(tex_color.rgb, vec3(0.299, 0.587, 0.114))), tex_color.rgb, saturation);
	COLOR.a = tex_color.a;
}
//shader_type canvas_item;
//
//uniform vec4 target_color : source_color;
//uniform vec4 replace_color : source_color; 
//uniform float tolerance : hint_range(0, 1); 
//
//void fragment() {
    //vec4 tex_color = texture(SCREEN_TEXTURE, SCREEN_UV);
 //
    //float dist = distance(tex_color.rgb, target_color.rgb);
 //
    //if (dist < tolerance) {
        //tex_color.rgb = replace_color.rgb;
    //}
 //
    //color = tex_color;
//}