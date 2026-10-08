/// @description Splash timer / skip
// Name: Vivek Jayakrishnan Nair | Student ID: A00341727
// Object: o_splash | Event: Step_0

// Show the credits for about 4.5 seconds, or skip with any key / click
t += 1;
if (t > 270 || (t > 20 && (keyboard_check_pressed(vk_anykey) || mouse_check_button_pressed(mb_left)))) {
    if (!instance_exists(o_fade)) {
        with (instance_create_depth(0, 0, -9999, o_fade)) target = rm_title;
    }
}
