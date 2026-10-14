/// @description Pause, bloom blend, win check, ambient effects
// Name: Vivek Jayakrishnan Nair | Student ID: A00341727
// Object: o_reef | Event: Step_0
/*
    RUBRIC #9a - STEP event.
*/

// Pause toggle (alarm is frozen while paused)
if (!won && (keyboard_check_pressed(ord("P")) || keyboard_check_pressed(vk_escape))) global.paused = !global.paused;
part_system_automatic_update(ps, !global.paused);
if (global.paused) {
    alarm[0] += 1;
    if (keyboard_check_pressed(ord("T"))) {
        if (!instance_exists(o_fade)) {
            with (instance_create_depth(0, 0, -9999, o_fade)) target = rm_title;
        }
    }
    exit;
}
elapsed += 1 / game_get_speed(gamespeed_fps);

// VN upgrade: restore a continued dive on the first frame (after every instance exists),
// then clear the flag so re-entering the room never re-applies it.
if (resume_pending) {
    resume_pending = false;
    global.resume_dive = false;
    if (instance_exists(o_angler)) { o_angler.pearls = resume_pearls; o_angler.caught = resume_caught; }
    for (var _i = 0; _i < resume_lamps && _i < instance_number(o_lamp); _i++) {
        var _l = instance_find(o_lamp, _i);
        _l.lit = true;
        _l.image_index = 1;
    }
    bloom = min(resume_pearls / pearls_needed, 0.9) * 0.6;
    bloom_target = bloom;
    toast("Welcome back to the deep...", 150);
}

// VN upgrade: Whale Call timers tick down (call_t = calm window, call_cd = cooldown)
if (call_t > 0) call_t -= 1;
if (call_cd > 0) call_cd -= 1;

// Blend the whole reef from cold dark to full colour once enough pearls are found
bloom = lerp(bloom, bloom_target, 0.012);
global.bloom = bloom;
layer_background_blend(layer_background_get_id(layer_get_id("Background")), merge_colour(make_colour_rgb(60, 80, 130), c_white, bloom));
if (bloom > 0.92 && !won) {
    won = true;
    var _snd = asset_get_index("snd_win");  // optional sound: plays only once it is added to the project
    if (_snd != -1) audio_play_sound(_snd, 1, false);
    save_dive();  // VN upgrade: a win saves the dive and records the best time
}

// Win celebration and replay
if (won) {
    win_t += 1;
    if (win_t < 200 && win_t mod 10 == 0) part_particles_create(ps, o_angler.x + random_range(-160, 160), o_angler.y + random_range(-100, 100), pt_spark, 24);
    if (win_t > 90 && keyboard_check_pressed(vk_enter)) {
        global.resume_dive = false;  // VN upgrade: a replay is a fresh dive, never a restore
        if (!instance_exists(o_fade)) {
            with (instance_create_depth(0, 0, -9999, o_fade)) target = rm_reef;
        }
    }
    if (win_t > 90 && keyboard_check_pressed(ord("T"))) {
        if (!instance_exists(o_fade)) {
            with (instance_create_depth(0, 0, -9999, o_fade)) target = rm_title;
        }
    }
}

// Keep the reef alive: new glimmerfish drift in when few are left
if (!won && instance_number(o_glimmer) < 6 && random(1) < 0.004) {
    instance_create_layer(random_range(200, room_width - 200), random_range(250, room_height - 400), "Instances", o_glimmer);
}

// Marine snow in view, bubbles from the kelp
var _cx = camera_get_view_x(view_camera[0]);
var _cy = camera_get_view_y(view_camera[0]);
if (random(1) < 0.6) part_particles_create(ps, _cx + random(1280), _cy + random(720), pt_snow, 1);
if (random(1) < 0.05) with (instance_find(o_kelp, irandom(instance_number(o_kelp) - 1))) part_particles_create(other.ps, x, y - random(180), other.pt_bubble, 1);

// Ripples grow and fade
for (var i = array_length(rings) - 1; i >= 0; i--) {
    rings[i].r += rings[i].spd;
    if (rings[i].r >= rings[i].rmax) array_delete(rings, i, 1);
}
// VN upgrade: floating texts rise and fade
for (var _f = array_length(floaters) - 1; _f >= 0; _f--) {
    floaters[_f].t += 1;
    if (floaters[_f].t > 75) array_delete(floaters, _f, 1);
}
if (toast_t > 0) toast_t -= 1;
song_flash = max(0, song_flash - 0.012);
