/// @description Draw the title screen
// Name: Vivek Jayakrishnan Nair | Student ID: A00341727
// Object: o_title | Event: Draw_64

// Logo, story line, controls and credit
var _gw = display_get_gui_width();
var _gh = display_get_gui_height();
draw_sprite_stretched(s_vignette, 0, 0, 0, _gw, _gh);
draw_set_alpha(0.45);
draw_set_colour(make_colour_rgb(3, 7, 19));
draw_rectangle(0, 0, _gw, _gh, false);
draw_set_alpha(1);

gpu_set_blendmode(bm_add);
draw_sprite_ext(s_light, 0, _gw / 2, _gh / 2 - 110, 4.5, 1.6, 0, make_colour_rgb(30, 110, 130), 0.6);
gpu_set_blendmode(bm_normal);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(global.fnt_body);
draw_set_colour(make_colour_rgb(94, 242, 224));
draw_text(_gw / 2, _gh / 2 - 185, "A   D E E P - S E A   L I G H T   S T O R Y");

draw_set_font(global.fnt_title);
draw_set_colour(make_colour_rgb(8, 30, 40));
draw_text_transformed(_gw / 2 + 4, _gh / 2 - 106, "Abyssal Bloom", 1.6, 1.6, 0);
draw_set_colour(make_colour_rgb(225, 252, 255));
draw_text_transformed(_gw / 2, _gh / 2 - 110, "Abyssal Bloom", 1.6, 1.6, 0);

draw_set_font(global.fnt_body);
draw_set_colour(make_colour_rgb(190, 210, 230));
draw_text(_gw / 2, _gh / 2 - 20, "The reef has gone dark. You are a small lantern fish with one light.");
draw_text(_gw / 2, _gh / 2 + 8, "Catch the glimmerfish, gather five pearls, and wake the deep back into colour.");

// pulsing call to action inside a pill (wider when a saved dive can continue)
var _p = 0.6 + 0.4 * sin(current_time / 300);
draw_set_alpha(0.9);
draw_set_colour(make_colour_rgb(79, 217, 201));
var _half_w = save_exists ? 250 : 130;
draw_roundrect_ext(_gw / 2 - _half_w, _gh / 2 + 62, _gw / 2 + _half_w, _gh / 2 + 112, 50, 50, false);
draw_set_alpha(_p);
draw_set_colour(make_colour_rgb(3, 30, 34));
draw_text(_gw / 2, _gh / 2 + 87, save_exists ? "ENTER — NEW DIVE      C — CONTINUE" : "PRESS ENTER TO DIVE");
draw_set_alpha(1);

draw_set_colour(make_colour_rgb(138, 163, 191));
draw_text(_gw / 2, _gh / 2 + 160, "WASD / Arrows  swim      Click  wake a nearby lamp      SHIFT  dash      C  whale call      P  pause      Esc  quit");

// VN upgrade: depth (difficulty) picker, best times, and the saved-dive line
var _diff_names = ["CALM", "DEEP", "ABYSS"];
var _diff_line = "DEPTH:  ";
for (var i = 0; i < 3; i++) {
    _diff_line += "[" + string(i + 1) + "] " + _diff_names[i] + (global.difficulty == i ? " *" : "") + "    ";
}
draw_set_colour(make_colour_rgb(255, 217, 138));
draw_text(_gw / 2, _gh / 2 + 185, _diff_line);
draw_set_colour(make_colour_rgb(138, 163, 191));
draw_text(_gw / 2, _gh / 2 + 210, "BEST TIMES  —  CALM " + fmt_time(best_0) + "    DEEP " + fmt_time(best_1) + "    ABYSS " + fmt_time(best_2));
if (save_exists) {
    draw_set_colour(make_colour_rgb(94, 242, 224));
    draw_text(_gw / 2, _gh / 2 + 235, "Saved dive: " + string(save_pearls) + " pearls, " + string(save_lamps) + " lamps (" + _diff_names[save_difficulty] + ") — press C to continue");
}

draw_set_colour(make_colour_rgb(110, 130, 160));
draw_text(_gw / 2, _gh - 32, "Vivek Jayakrishnan Nair   -   Student ID A00341727");
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
