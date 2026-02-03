shader_type spatial;
render_mode specular_schlick_ggx;


uniform sampler2D SplatMapTexture : source_color;


void fragment() 
{
	float splat_value = texture(SplatMapTexture, UV).r;
	splat_value = clamp(splat_value, 0.0, 1.0);
	splat_value = step(0.05f, splat_value);
	ALBEDO = vec3(splat_value, splat_value, splat_value);
	EMISSION = vec3(splat_value, splat_value, splat_value);
	
}
