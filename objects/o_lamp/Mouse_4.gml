/// @description Mouse Left Pressed: wake the lamp
// Name: Vivek Jayakrishnan Nair | Student ID: A00341727
// Object: o_lamp | Event: Mouse_4
/*
    RUBRIC #9d - OTHER event of my choice: MOUSE (Left Pressed).
                 This is separate from the keyboard controls on the player.
                 It only works if the player is near the lamp, so the mouse
                 and the player object interact too.
*/

// Clicking a lamp wakes it, but only if the lantern fish is close enough
if (lit || global.paused || !instance_exists(o_angler)) exit;
if (point_distance(x, y - 50, o_angler.x, o_angler.y) < 240) {
    lit = true;
    image_index = 1;
    part_particles_create(o_reef.ps, x, y - 50, o_reef.pt_spark, 26);
    o_reef.add_ring(x, y - 50, 180, 3.5, make_colour_rgb(255, 210, 140));
    o_reef.add_float(x, y - 90, "LAMP AWOKE", make_colour_rgb(255, 210, 140));
    o_reef.shake = 3;
    var _snd = asset_get_index("snd_lamp");  // optional sound: plays only once it is added to the project
    if (_snd != -1) audio_play_sound(_snd, 1, false);
    if (instance_number(o_lamp) == o_reef.lamps_lit()) o_reef.toast("Every lamp in the reef is glowing.", 180);
    o_reef.save_dive();  // VN upgrade: every woken lamp persists the dive
} else {
    o_reef.toast("Swim closer to wake that lamp...", 110);
}
