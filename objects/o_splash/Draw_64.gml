/// @description Draw name and student ID
// Name: Vivek Jayakrishnan Nair | Student ID: A00341727
// Object: o_splash | Event: Draw_64

// Credits: glowing orb, then name and student ID fading in one after another
var _gw = display_get_gui_width();
var _gh = display_get_gui_height();
var _out = clamp((270 - t) / 40, 0, 1);
var _a1 = clamp((t - 10) / 40, 0, 1) * _out;
var _a2 = clamp((t - 35) / 40, 0, 1) * _out;
var _a3 = clamp((t - 60) / 40, 0, 1) * _out;
var _a4 = clamp((t - 90) / 40, 0, 1) * _out;
var _br = 1 + sin(current_time / 500) * 0.08;

// deep-sea backdrop glow
gpu_set_blendmode(bm_add);
draw_sprite_ext(s_light, 0, _gw / 2, _gh / 2 - 20, 6, 4, 0, make_colour_rgb(20, 60, 110), 0.7 * _out);
draw_sprite_ext(s_light, 0, _gw / 2, _gh / 2 - 120, 1.4 * _br, 1.4 * _br, 0, make_colour_rgb(94, 242, 224), 0.55 * _a1);
draw_sprite_ext(s_light, 0, _gw / 2, _gh / 2 - 120, 0.35 * _br, 0.35 * _br, 0, c_white, 0.9 * _a1);
gpu_set_blendmode(bm_normal);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_set_font(global.fnt_body);
draw_set_alpha(_a2);
draw_set_colour(make_colour_rgb(138, 163, 191));
draw_text(_gw / 2, _gh / 2 - 10, "A     G A M E     B Y");

draw_set_font(global.fnt_title);
draw_set_alpha(_a3);
draw_set_colour(c_white);
draw_text(_gw / 2, _gh / 2 + 55, "Vivek Jayakrishnan Nair");

// student ID inside a pill outline
draw_set_font(global.fnt_body);
draw_set_alpha(_a4 * 0.5);
draw_set_colour(make_colour_rgb(255, 217, 138));
draw_roundrect_ext(_gw / 2 - 150, _gh / 2 + 115, _gw / 2 + 150, _gh / 2 + 155, 40, 40, true);
draw_set_alpha(_a4);
draw_text(_gw / 2, _gh / 2 + 135, "STUDENT ID  -  A00341727");

draw_set_alpha(_a4 * 0.45);
draw_set_colour(make_colour_rgb(138, 163, 191));
draw_text(_gw / 2, _gh - 36, "press any key");
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
