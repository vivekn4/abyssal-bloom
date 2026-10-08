/// @description Draw lamp, halo, and hover hint ring
// Name: Vivek Jayakrishnan Nair | Student ID: A00341727
// Object: o_lamp | Event: Draw_0

// The lamp, plus a warm halo when lit and a dashed hint ring when hovered
var _b = variable_global_exists("bloom") ? global.bloom : 0.5;
draw_sprite_ext(sprite_index, image_index, x, y, 1, 1, 0, lit ? c_white : merge_colour(make_colour_rgb(110, 120, 160), c_white, _b), 1);
if (lit) {
    gpu_set_blendmode(bm_add);
    draw_sprite_ext(s_light, 0, x, y - 50, 0.55 * flick, 0.55 * flick, 0, make_colour_rgb(255, 170, 80), 0.5);
    gpu_set_blendmode(bm_normal);
} else if (point_distance(mouse_x, mouse_y, x, y - 36) < 50) {
    var _near = instance_exists(o_angler) && point_distance(x, y - 50, o_angler.x, o_angler.y) < 240;
    draw_set_colour(_near ? make_colour_rgb(255, 220, 150) : make_colour_rgb(150, 170, 200));
    var _r = 34 + sin(current_time / 160) * 2;
    for (var i = 0; i < 16; i += 2) draw_line_width(x + lengthdir_x(_r, i * 22.5), y - 36 + lengthdir_y(_r, i * 22.5),
                                                    x + lengthdir_x(_r, (i + 1) * 22.5), y - 36 + lengthdir_y(_r, (i + 1) * 22.5), 2);
}
