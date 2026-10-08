/// @description Start the game from the title
// Name: Vivek Jayakrishnan Nair | Student ID: A00341727
// Object: o_title | Event: Step_0

// Dive in with Enter, Space or a click
if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space) || mouse_check_button_pressed(mb_left)) {
    if (!instance_exists(o_fade)) {
        with (instance_create_depth(0, 0, -9999, o_fade)) target = rm_reef;
    }
}
if (keyboard_check_pressed(vk_escape)) game_end();
