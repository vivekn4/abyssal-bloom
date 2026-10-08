/// @description Level controller setup (fonts, alarm, particles)
// Name: Vivek Jayakrishnan Nair | Student ID: A00341727
// Object: o_reef | Event: Create_0
/*
    o_reef runs the level: darkness, camera/viewport, particles, the
    whale-song ALARM, the HUD, and the win state.
    Room rm_reef is 3200 x 2000 and the view is 1280 x 720 (RUBRIC #2),
    so the camera has plenty of room to travel.
*/

// Build the two sprite fonts once for the whole game
if (!variable_global_exists("fnt_body")) {
    global.fnt_body  = font_add_sprite_ext(s_font_body,  " !#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[]^_`abcdefghijklmnopqrstuvwxyz{|}~", true, 1);
    global.fnt_title = font_add_sprite_ext(s_font_title, " !#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[]^_`abcdefghijklmnopqrstuvwxyz{|}~", true, 2);
}

// Reef controller: darkness, camera, particles, whale-song alarm, HUD and win state
depth = -1000;
global.paused = false;
global.bloom = 0;
bloom = 0;
bloom_target = 0;
pearls_needed = 5;
won = false;
win_t = 0;
elapsed = 0;
shake = 0;
cam_x = -1;
cam_y = -1;
song_flash = 0;
dark_surf = -1;
rings = [];
toast_msg = "";
toast_t = 0;
// RUBRIC #9b: start the alarm. Alarms count down in frames, so
// 60 frames per second x 20 = 1200 frames = 20 seconds.
song_length = game_get_speed(gamespeed_fps) * 20;
alarm[0] = song_length;

// Helper functions other objects can call
toast = function(_msg, _frames) { toast_msg = _msg; toast_t = _frames; };
add_ring = function(_x, _y, _max, _spd, _col) { array_push(rings, { rx: _x, ry: _y, r: 6, rmax: _max, spd: _spd, col: _col }); };
lamps_lit = function() { var _n = 0; with (o_lamp) if (lit) _n += 1; return _n; };

// Particles drawn above the darkness
ps = part_system_create();
part_system_depth(ps, -1050);

pt_spark = part_type_create();
part_type_shape(pt_spark, pt_shape_flare);
part_type_size(pt_spark, 0.08, 0.18, -0.003, 0);
part_type_colour3(pt_spark, c_white, make_colour_rgb(255, 225, 150), make_colour_rgb(94, 242, 224));
part_type_alpha2(pt_spark, 1, 0);
part_type_speed(pt_spark, 1, 4, -0.07, 0);
part_type_direction(pt_spark, 0, 360, 0, 0);
part_type_blend(pt_spark, true);
part_type_life(pt_spark, 30, 60);

pt_bubble = part_type_create();
part_type_shape(pt_bubble, pt_shape_ring);
part_type_size(pt_bubble, 0.04, 0.09, 0, 0);
part_type_colour1(pt_bubble, make_colour_rgb(190, 240, 255));
part_type_alpha3(pt_bubble, 0.6, 0.45, 0);
part_type_speed(pt_bubble, 0.6, 1.3, 0, 0);
part_type_direction(pt_bubble, 85, 95, 0, 8);
part_type_life(pt_bubble, 90, 160);

pt_snow = part_type_create();
part_type_shape(pt_snow, pt_shape_disk);
part_type_size(pt_snow, 0.015, 0.035, 0, 0);
part_type_colour1(pt_snow, make_colour_rgb(210, 230, 255));
part_type_alpha3(pt_snow, 0, 0.45, 0);
part_type_speed(pt_snow, 0.1, 0.35, 0, 0);
part_type_direction(pt_snow, 250, 290, 0, 3);
part_type_life(pt_snow, 200, 400);
