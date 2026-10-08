/// @description Keyboard swimming, bubbles, lure position
// Name: Vivek Jayakrishnan Nair | Student ID: A00341727
// Object: o_angler | Event: Step_0
/*
    RUBRIC #6  - player moves with keyboard (WASD / arrow keys).
    RUBRIC #9a - STEP event: runs every frame (60 times per second).
*/

// Swim with WASD / arrow keys (acceleration + water drag)
if (global.paused) exit;
var _h = (keyboard_check(ord("D")) || keyboard_check(vk_right)) - (keyboard_check(ord("A")) || keyboard_check(vk_left));
var _v = (keyboard_check(ord("S")) || keyboard_check(vk_down))  - (keyboard_check(ord("W")) || keyboard_check(vk_up));
if (_h != 0 || _v != 0) {
    var _dir = point_direction(0, 0, _h, _v);
    vx += lengthdir_x(acc, _dir);
    vy += lengthdir_y(acc, _dir);
}
vx *= 0.92;
vy *= 0.92;
var _spd = point_distance(0, 0, vx, vy);
if (_spd > max_spd) { vx = vx / _spd * max_spd; vy = vy / _spd * max_spd; }
x = clamp(x + vx, 40, room_width - 40);
y = clamp(y + vy, 80, room_height - 235);
if (abs(vx) > 0.3) face = sign(vx);
image_speed = 0.3 + _spd * 0.12;

// Trail of bubbles while swimming
bubble_t += _spd;
if (bubble_t > 30) {
    bubble_t = 0;
    part_particles_create(o_reef.ps, x - face * 26, y, o_reef.pt_bubble, 1);
}

// Where the glowing lure is (used for lighting)
lure_x = x + face * 30;
lure_y = y - 30 + sin(current_time / 300) * 2;
