/// @description Scenery sways and tints with the bloom
// Name: Vivek Jayakrishnan Nair | Student ID: A00341727
// Object: o_decor | Event: Step_0

// Sway in the current, and tint from cold grey-blue to full colour as the reef blooms
if (sway != 0) image_angle = sin(current_time / 900 + phase) * sway;
var _b = variable_global_exists("bloom") ? global.bloom : 0.5;
image_blend = merge_colour(make_colour_rgb(55, 75, 115), c_white, _b);
