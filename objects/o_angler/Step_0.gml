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

// VN upgrade: dash (Shift) — a short burst along the swim direction, then a cooldown.
// Costs nothing, feels like a flick of the tail: ring + bubble burst for juice.
if (dash_cd > 0) dash_cd -= 1;
if (dash_t > 0) {
    dash_t -= 1;
    vx += lengthdir_x(0.9, dash_dir);
    vy += lengthdir_y(0.9, dash_dir);
    if (dash_t mod 2 == 0) part_particles_create(o_reef.ps, x - face * 20, y, o_reef.pt_bubble, 1);
}
if (keyboard_check_pressed(vk_shift) && dash_cd <= 0) {
    dash_cd = 100;
    dash_t = 12;
    dash_dir = (_spd > 0.5) ? point_direction(0, 0, vx, vy) : (face == 1 ? 0 : 180);
    o_reef.add_ring(x, y, 60, 2.5, make_colour_rgb(94, 242, 224));
    part_particles_create(o_reef.ps, x, y, o_reef.pt_bubble, 6);
}

// VN upgrade: Whale Call (C) — learned from the first whale song. Calms the glimmerfish
// and pulls pearls toward you for 4 seconds; 25-second cooldown.
if (keyboard_check_pressed(ord("C")) && instance_exists(o_reef)) {
    if (o_reef.call_unlocked && o_reef.call_cd <= 0) {
        o_reef.call_t = 240;
        o_reef.call_cd = 1500;
        o_reef.add_ring(x, y, 900, 8, make_colour_rgb(167, 139, 255));
        o_reef.shake = 4;
        o_reef.add_float(x, y - 60, "THE DEEP ANSWERS", make_colour_rgb(167, 139, 255));
        o_reef.toast("Whale Call! The glimmerfish calm...", 150);
    } else if (!o_reef.call_unlocked) {
        o_reef.toast("The whale has not sung yet... listen for its song.", 120);
    }
}

// Trail of bubbles while swimming
bubble_t += _spd;
if (bubble_t > 30) {
    bubble_t = 0;
    part_particles_create(o_reef.ps, x - face * 26, y, o_reef.pt_bubble, 1);
}

// Where the glowing lure is (used for lighting)
lure_x = x + face * 30;
lure_y = y - 30 + sin(current_time / 300) * 2;
