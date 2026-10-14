/// @description Whale song: scatter every glimmerfish
// Name: Vivek Jayakrishnan Nair | Student ID: A00341727
// Object: o_reef | Event: Alarm_0
/*
    RUBRIC #9b - ALARM event. alarm[0] is set to 20 seconds in Create;
                 when it reaches 0 this code runs, then it resets itself so it
                 repeats forever. It also changes how o_glimmer behaves.
*/

// Every 20 seconds a whale sings in the deep and every glimmerfish scatters
with (o_glimmer) {
    target_x = random_range(150, room_width - 150);
    target_y = random_range(200, room_height - 380);
    spd = random_range(2.6, 3.6);
}
song_flash = 1;
shake = 7;
add_ring(o_angler.x, o_angler.y, 1400, 9, make_colour_rgb(167, 139, 255));
// VN upgrade: the first whale song TEACHES the Whale Call (C) — a learned song becomes a
// reusable player verb. Later songs are just the ambient scatter event.
if (!call_taught) {
    call_taught = true;
    call_unlocked = true;
    toast("The whale teaches you its Call... press C to calm the deep!", 220);
} else {
    toast("A whale sings in the deep... the glimmerfish scatter!", 180);
}
var _snd = asset_get_index("snd_whale");  // optional sound: plays only once it is added to the project
if (_snd != -1) audio_play_sound(_snd, 1, false);
alarm[0] = song_length;  // re-arm the alarm so the whale sings again in 20 s
