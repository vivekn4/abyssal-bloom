/// @description Draw the black fade overlay
// Name: Vivek Jayakrishnan Nair | Student ID: A00341727
// Object: o_fade | Event: Draw_64

// Black overlay
draw_set_alpha(alpha);
draw_set_colour(make_colour_rgb(2, 5, 14));
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
draw_set_alpha(1);
