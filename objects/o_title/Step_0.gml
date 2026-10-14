/// @description Start the game from the title
// Name: Vivek Jayakrishnan Nair | Student ID: A00341727
// Object: o_title | Event: Step_0

// VN upgrade: depth (difficulty) pick — 1 CALM, 2 DEEP, 3 ABYSS
if (keyboard_check_pressed(ord("1"))) global.difficulty = 0;
if (keyboard_check_pressed(ord("2"))) global.difficulty = 1;
if (keyboard_check_pressed(ord("3"))) global.difficulty = 2;

// VN upgrade: Continue a saved dive (C) — restores pearls, lamps and its difficulty
if (keyboard_check_pressed(ord("C")) && save_exists) {
    global.resume_dive = true;
    global.difficulty = save_difficulty;
    if (!instance_exists(o_fade)) {
        with (instance_create_depth(0, 0, -9999, o_fade)) target = rm_reef;
    }
}

// Dive in with Enter, Space or a click (fresh dive)
if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space) || mouse_check_button_pressed(mb_left)) {
    global.resume_dive = false;
    if (!instance_exists(o_fade)) {
        with (instance_create_depth(0, 0, -9999, o_fade)) target = rm_reef;
    }
}
if (keyboard_check_pressed(vk_escape)) game_end();
