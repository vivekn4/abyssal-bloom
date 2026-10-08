/// @description Draw the pearl with a glow
// Name: Vivek Jayakrishnan Nair | Student ID: A00341727
// Object: o_pearl | Event: Draw_0

// Warm glow and a gentle bob
var _bob = resting ? sin(t / 12) * 1.5 : 0;
gpu_set_blendmode(bm_add);
draw_sprite_ext(s_light, 0, x, y + _bob, 0.28, 0.28, 0, make_colour_rgb(255, 217, 138), 0.7);
gpu_set_blendmode(bm_normal);
draw_sprite(sprite_index, 0, x, y + _bob);
