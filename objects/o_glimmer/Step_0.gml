/// @description Automatic sine-wave swimming and dodging
// Name: Vivek Jayakrishnan Nair | Student ID: A00341727
// Object: o_glimmer | Event: Step_0
/*
    RUBRIC #8  - automatic movement: swims to a random target in a wave.
    RUBRIC #9a - STEP event.
*/

// Swim toward the target in a sine-wave weave
if (variable_global_exists("paused") && global.paused) exit;
var _dir = point_direction(x, y, target_x, target_y);
wave_t += 0.09;
var _wob = sin(wave_t) * 1.4;
x += lengthdir_x(spd, _dir) + lengthdir_x(_wob, _dir + 90);
y += lengthdir_y(spd, _dir) + lengthdir_y(_wob, _dir + 90);
if (abs(lengthdir_x(1, _dir)) > 0.2) face = sign(lengthdir_x(1, _dir));
image_xscale = face;

// Dart away when the lantern fish gets close
if (instance_exists(o_angler) && point_distance(x, y, o_angler.x, o_angler.y) < 170) {
    var _away = point_direction(o_angler.x, o_angler.y, x, y);
    x += lengthdir_x(1.45, _away);
    y += lengthdir_y(1.45, _away);
}
x = clamp(x, 40, room_width - 40);
y = clamp(y, 90, room_height - 240);

// New target on arrival (and calm down after the whale song)
if (point_distance(x, y, target_x, target_y) < 14) {
    target_x = random_range(150, room_width - 150);
    target_y = random_range(200, room_height - 380);
    spd = random_range(1.1, 2);
}
