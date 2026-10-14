/// @description Draw the glow and the fish
// Name: Vivek Jayakrishnan Nair | Student ID: A00341727
// Object: o_glimmer | Event: Draw_0

// Soft coloured glow, then the fish itself (glow scales with the variant's size)
gpu_set_blendmode(bm_add);
draw_sprite_ext(s_light, 0, x, y, 0.3 * vscale, 0.3 * vscale, 0, image_blend, 0.55);
gpu_set_blendmode(bm_normal);
draw_self();
