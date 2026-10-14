/// @description Glimmerfish setup (random target, speed, colour)
// Name: Vivek Jayakrishnan Nair | Student ID: A00341727
// Object: o_glimmer | Event: Create_0
/*
    RUBRIC #8 - o_glimmer moves AUTOMATICALLY (no player input).
*/

// Glimmerfish glow above the darkness; each has its own target, speed and colour
depth = -1100;
target_x = random_range(150, room_width - 150);
target_y = random_range(200, room_height - 380);
wave_t = random(360);
face = 1;
image_speed = 0.5;

// VN upgrade: three glimmerfish variants in a depth-weighted table (deeper water holds
// rarer, faster fish) — the Kelvin-style species table, re-implemented in GML.
// Difficulty scales speed and wariness: CALM is gentler, ABYSS is faster and shier.
diff_spd = 1;
diff_dodge = 1;
if (variable_global_exists("difficulty")) {
    diff_spd = (global.difficulty == 0) ? 0.85 : (global.difficulty == 2 ? 1.25 : 1);
    diff_dodge = (global.difficulty == 0) ? 0.8 : (global.difficulty == 2 ? 1.25 : 1);
}
var _deep = clamp((y - 200) / max(1, room_height - 600), 0, 1);
var _roll = random(1);
variant = 0;            // 0 drifter (common), 1 dart (fast + shy), 2 lumen (slow + big + calm)
vscale = 1;
dodge_r = 170 * diff_dodge;
spd_min = 1.1;
spd_max = 1.8;
image_blend = choose(make_colour_rgb(94, 242, 224), make_colour_rgb(255, 120, 210));
if (_roll < 0.12 + _deep * 0.18) {
    variant = 2; vscale = 1.25; dodge_r = 110 * diff_dodge;
    spd_min = 0.8; spd_max = 1.2;
    image_blend = make_colour_rgb(200, 160, 255);
} else if (_roll < 0.45 + _deep * 0.15) {
    variant = 1; vscale = 0.85; dodge_r = 220 * diff_dodge;
    spd_min = 2.2; spd_max = 3.0;
    image_blend = make_colour_rgb(255, 210, 120);
}
spd = random_range(spd_min, spd_max) * diff_spd;
