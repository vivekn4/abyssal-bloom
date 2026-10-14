/// @description HUD: pearls, whale timer, lamps, minimap, panels
// Name: Vivek Jayakrishnan Nair | Student ID: A00341727
// Object: o_reef | Event: Draw_64

// HUD: tint, vignette, pearls, whale-song meter, lamps, minimap, messages, pause and win panels
var _gw = display_get_gui_width();
var _gh = display_get_gui_height();
if (song_flash > 0) {
    draw_set_alpha(song_flash * 0.14);
    draw_set_colour(make_colour_rgb(167, 139, 255));
    draw_rectangle(0, 0, _gw, _gh, false);
}
draw_set_alpha(lerp(1, 0.55, bloom));
draw_sprite_stretched(s_vignette, 0, 0, 0, _gw, _gh);
draw_set_alpha(1);
draw_set_font(global.fnt_body);
draw_set_valign(fa_middle);

// glass panel helper colours
var _glass = make_colour_rgb(10, 24, 44);
var _line = make_colour_rgb(70, 110, 140);
var _muted = make_colour_rgb(138, 163, 191);
var _gold = make_colour_rgb(255, 217, 138);

// pearls (top-left)
draw_set_alpha(0.6); draw_set_colour(_glass); draw_roundrect_ext(18, 18, 300, 66, 18, 18, false);
draw_set_alpha(0.5); draw_set_colour(_line);  draw_roundrect_ext(18, 18, 300, 66, 18, 18, true);
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_colour(_muted);
draw_text(36, 42, "PEARLS");
for (var i = 0; i < pearls_needed; i++) {
    var _got = o_angler.pearls > i;
    draw_sprite_ext(s_pearl, 0, 138 + i * 32, 42, 1, 1, 0, _got ? c_white : make_colour_rgb(60, 70, 90), _got ? 1 : 0.6);
}

// VN upgrade: dash cooldown bar under the pearls panel
if (instance_exists(o_angler)) {
    var _dash_fill = 1 - clamp(o_angler.dash_cd / 100, 0, 1);
    draw_set_halign(fa_left);
    draw_set_colour(_muted);
    draw_text(36, 84, "DASH");
    draw_set_colour(make_colour_rgb(30, 45, 70));
    draw_rectangle(110, 80, 282, 88, false);
    draw_set_colour(o_angler.dash_cd <= 0 ? make_colour_rgb(94, 242, 224) : make_colour_rgb(120, 160, 200));
    draw_rectangle(110, 80, 110 + 172 * _dash_fill, 88, false);
}

// whale song meter (top-right)
var _secs = ceil(alarm[0] / game_get_speed(gamespeed_fps));
var _fill = 1 - alarm[0] / song_length;
draw_set_alpha(0.6); draw_set_colour(_glass); draw_roundrect_ext(_gw - 290, 18, _gw - 18, 78, 18, 18, false);
draw_set_alpha(0.5); draw_set_colour(_line);  draw_roundrect_ext(_gw - 290, 18, _gw - 18, 78, 18, 18, true);
draw_set_alpha(1);
draw_set_colour(_muted);
draw_text(_gw - 272, 40, "WHALE SONG");
draw_set_halign(fa_right);
draw_set_colour(c_white);
draw_text(_gw - 36, 40, string(_secs) + "s");
draw_set_colour(make_colour_rgb(30, 45, 70));
draw_rectangle(_gw - 272, 60, _gw - 36, 63, false);
draw_rectangle_colour(_gw - 272, 60, _gw - 272 + 236 * _fill, 63, make_colour_rgb(94, 242, 224), make_colour_rgb(167, 139, 255), make_colour_rgb(167, 139, 255), make_colour_rgb(94, 242, 224), false);

// VN upgrade: Whale Call status under the whale meter
draw_set_halign(fa_left);
if (call_unlocked) {
    draw_set_colour(call_cd <= 0 ? make_colour_rgb(167, 139, 255) : _muted);
    draw_text(_gw - 272, 92, call_cd <= 0 ? "WHALE CALL READY  —  C" : "WHALE CALL  " + string(ceil(call_cd / 60)) + "s");
} else {
    draw_set_colour(_muted);
    draw_text(_gw - 272, 92, "WHALE CALL  —  listen for the song");
}

// lamps lit (bottom-left)
draw_set_halign(fa_left);
draw_set_alpha(0.6); draw_set_colour(_glass); draw_roundrect_ext(18, _gh - 64, 290, _gh - 18, 18, 18, false);
draw_set_alpha(1);
draw_set_colour(_muted);
draw_text(36, _gh - 41, "LAMPS LIT");
draw_set_colour(c_white);
draw_text(150, _gh - 41, string(lamps_lit()) + " / " + string(instance_number(o_lamp)));

// minimap (bottom-right)
var _mw = 220, _mh = 138, _mx = _gw - _mw - 18, _my = _gh - _mh - 18;
var _sx = _mw / room_width, _sy = _mh / room_height;
draw_set_alpha(0.75); draw_set_colour(make_colour_rgb(4, 12, 26)); draw_roundrect_ext(_mx - 6, _my - 6, _mx + _mw + 6, _my + _mh + 6, 14, 14, false);
draw_set_alpha(0.5); draw_set_colour(make_colour_rgb(60, 90, 120)); draw_rectangle(_mx, _my + (room_height - 200) * _sy, _mx + _mw, _my + _mh, false);
draw_set_alpha(0.35); draw_set_colour(c_white);
draw_rectangle(_mx + camera_get_view_x(view_camera[0]) * _sx, _my + camera_get_view_y(view_camera[0]) * _sy,
               _mx + (camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0])) * _sx,
               _my + (camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0])) * _sy, true);
draw_set_alpha(1);
with (o_lamp)    { draw_set_colour(lit ? make_colour_rgb(255, 210, 122) : make_colour_rgb(120, 140, 170)); draw_circle(_mx + x * _sx, _my + (y - 40) * _sy, lit ? 3 : 2, false); }
with (o_glimmer) { draw_set_colour(image_blend); draw_rectangle(_mx + x * _sx - 1, _my + y * _sy - 1, _mx + x * _sx + 1, _my + y * _sy + 1, false); }
with (o_pearl)   { draw_set_colour(_gold); draw_circle(_mx + x * _sx, _my + y * _sy, 2.5, false); }
with (o_angler)  { draw_set_colour(c_white); draw_circle(_mx + x * _sx, _my + y * _sy, 3, false); }

// toast message
draw_set_halign(fa_center);
if (toast_t > 0) {
    draw_set_alpha(min(1, toast_t / 30));
    draw_set_colour(make_colour_rgb(3, 7, 19));
    draw_text(_gw / 2 + 2, 118, toast_msg);
    draw_set_colour(make_colour_rgb(220, 250, 255));
    draw_text(_gw / 2, 116, toast_msg);
    draw_set_alpha(1);
}

// controls hint
draw_set_alpha(0.5);
draw_set_colour(c_white);
draw_text(_gw / 2, _gh - 30, "WASD / Arrows  swim      touch glimmerfish  catch      click a nearby lamp  wake it      SHIFT  dash      C  whale call      P  pause");
draw_set_alpha(1);

// pause panel
if (global.paused) {
    draw_set_alpha(0.6); draw_set_colour(make_colour_rgb(3, 7, 19)); draw_rectangle(0, 0, _gw, _gh, false);
    draw_set_alpha(1);
    draw_set_font(global.fnt_title);
    draw_set_colour(c_white);
    draw_text(_gw / 2, _gh / 2 - 30, "Drifting...");
    draw_set_font(global.fnt_body);
    draw_set_colour(_muted);
    draw_text(_gw / 2, _gh / 2 + 40, "P to resume      T for the title screen");
}

// win panel
if (won) {
    var _a = clamp((win_t - 40) / 60, 0, 1);
    draw_set_alpha(_a * 0.55); draw_set_colour(make_colour_rgb(3, 7, 19)); draw_rectangle(0, 0, _gw, _gh, false);
    draw_set_alpha(_a);
    draw_set_font(global.fnt_title);
    draw_set_colour(make_colour_rgb(255, 225, 160));
    draw_text(_gw / 2, _gh / 2 - 110, "The reef remembers.");
    draw_set_font(global.fnt_body);
    draw_set_colour(_muted);
    draw_text(_gw / 2, _gh / 2 - 45, "Colour floods back into the abyss.");
    var _m = floor(elapsed / 60);
    var _s = floor(elapsed mod 60);
    var _labels = ["TIME", "LAMPS LIT", "FISH CAUGHT"];
    var _values = [string(_m) + ":" + (_s < 10 ? "0" : "") + string(_s), string(lamps_lit()) + "/" + string(instance_number(o_lamp)), string(o_angler.caught)];
    for (var j = 0; j < 3; j++) {
        var _bx = _gw / 2 + (j - 1) * 170;
        draw_set_alpha(_a * 0.6); draw_set_colour(_glass); draw_roundrect_ext(_bx - 75, _gh / 2 + 5, _bx + 75, _gh / 2 + 85, 16, 16, false);
        draw_set_alpha(_a);
        draw_set_colour(_gold); draw_text_transformed(_bx, _gh / 2 + 35, _values[j], 1.4, 1.4, 0);
        draw_set_colour(_muted); draw_text_transformed(_bx, _gh / 2 + 66, _labels[j], 0.7, 0.7, 0);
    }
    draw_set_colour(c_white);
    draw_text(_gw / 2, _gh / 2 + 130, "ENTER  dive again      T  title screen");
    if (new_best) {
        draw_set_colour(_gold);
        draw_text(_gw / 2, _gh / 2 + 108, "NEW BEST TIME!");
    }
    draw_set_colour(make_colour_rgb(110, 130, 160));
    draw_text(_gw / 2, _gh - 70, "Abyssal Bloom   -   Vivek Jayakrishnan Nair   -   A00341727");
}
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
