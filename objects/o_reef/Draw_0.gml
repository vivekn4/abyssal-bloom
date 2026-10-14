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
// VN upgrade: darkness is depth-graded (Kelvin-style darkness-by-depth) — the deeper
// the lanternfish swims, the thicker the dark, before the bloom thins it again.
var _depth01 = 0.5;
if (instance_exists(o_angler)) _depth01 = clamp((o_angler.y - 80) / max(1, room_height - 315), 0, 1);
var _dark = clamp(lerp(0.93, 0.3, bloom) + (_depth01 - 0.5) * 0.14, 0.25, 0.97);
draw_clear_alpha(merge_colour(make_colour_rgb(2, 4, 14), make_colour_rgb(8, 22, 36), bloom), _dark);
gpu_set_blendmode(bm_subtract);
with (o_angler) draw_sprite_ext(s_light, 0, lure_x - _cx, lure_y - _cy, 2.1, 2.1, 0, c_white, 1);
// VN upgrade: a soft light beam stretches ahead of the lure in the swim direction
with (o_angler) draw_sprite_ext(s_light, 0, lure_x + face * 70 - _cx, lure_y - _cy, 3.0, 0.85, 0, c_white, 0.5);
// VN upgrade: every pearl you carry makes the lit lamps push the dark back further
var _pearl_boost = 1 + 0.12 * (instance_exists(o_angler) ? o_angler.pearls : 0);
with (o_lamp) if (lit) draw_sprite_ext(s_light, 0, x - _cx, y - 50 - _cy, 2.6 * flick * _pearl_boost, 2.6 * flick * _pearl_boost, 0, c_white, 1);
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
// VN upgrade: floating pickup texts rise out of the event that made them
draw_set_font(global.fnt_body);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
for (var _fi = 0; _fi < array_length(floaters); _fi++) {
    var _fl = floaters[_fi];
    var _fa = 1 - _fl.t / 75;
    draw_set_alpha(_fa);
    draw_set_colour(make_colour_rgb(2, 8, 18));
    draw_text(_fl.fx + 1, _fl.fy - _fl.t * 0.6 + 1, _fl.txt);
    draw_set_colour(_fl.col);
    draw_text(_fl.fx, _fl.fy - _fl.t * 0.6, _fl.txt);
}
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
gpu_set_blendmode(bm_normal);
