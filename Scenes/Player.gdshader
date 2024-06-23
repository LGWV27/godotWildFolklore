shader_type canvas_item;

uniform bool damaged;
uniform vec4 damage_color = vec4(1.0, 0.0, 0.0, 1.0); // Full red color

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    if (damaged) {
        // Mix the original texture color with the damage color, but respect the original alpha
        COLOR = mix(tex_color, damage_color, 0.3) * tex_color.a;
    } else {
        COLOR = tex_color;
    }
}
