/// @description Darkness surface with light holes, glows, ripples
// Name: Vivek Jayakrishnan Nair | Student ID: A00341727
// Object: o_reef | Event: Draw_0

// Darkness over the view, with soft holes of light, then glows and ripples on top
var _cam = view_camera[0];
var _cx = camera_get_view_x(_cam);
var _cy = camera_get_view_y(_cam);
var _vw = camera_get_view_width(_cam);
var _vh = camera_get_view_height(_cam);
if (!surface_exists(dark_surf)) dark_surf = surface_create(_vw, _vh);

surface_set_target(dark_surf);
draw_clear_alpha(merge_colour(make_colour_rgb(2, 4, 14), make_colour_rgb(8, 22, 36), bloom), lerp(0.93, 0.3, bloom));
gpu_set_blendmode(bm_subtract);
with (o_angler) draw_sprite_ext(s_light, 0, lure_x - _cx, lure_y - _cy, 2.1, 2.1, 0, c_white, 1);
with (o_lamp) if (lit) draw_sprite_ext(s_light, 0, x - _cx, y - 50 - _cy, 2.6 * flick, 2.6 * flick, 0, c_white, 1);
with (o_glimmer) draw_sprite_ext(s_light, 0, x - _cx, y - _cy, 0.55, 0.55, 0, c_white, 0.6);
with (o_pearl) draw_sprite_ext(s_light, 0, x - _cx, y - _cy, 0.6, 0.6, 0, c_white, 0.75);
gpu_set_blendmode(bm_normal);
surface_reset_target();
draw_surface(dark_surf, _cx, _cy);

// Glows that shine through the dark
gpu_set_blendmode(bm_add);
with (o_angler) {
    var _p = 1 + sin(current_time / 200) * 0.08;
    draw_sprite_ext(s_light, 0, lure_x, lure_y, 0.38 * _p, 0.38 * _p, 0, make_colour_rgb(94, 242, 224), 0.75);
    draw_sprite_ext(s_light, 0, lure_x, lure_y, 0.08, 0.08, 0, c_white, 1);
}
with (o_lamp) if (lit) draw_sprite_ext(s_light, 0, x, y - 50, 0.6 * flick, 0.6 * flick, 0, make_colour_rgb(255, 190, 110), 0.35);
for (var i = 0; i < array_length(rings); i++) {
    var _rg = rings[i];
    draw_set_alpha((1 - _rg.r / _rg.rmax) * 0.8);
    draw_set_colour(_rg.col);
    for (var k = 0; k < 3; k++) draw_circle(_rg.rx, _rg.ry, _rg.r + k, true);
}
draw_set_alpha(1);
gpu_set_blendmode(bm_normal);
