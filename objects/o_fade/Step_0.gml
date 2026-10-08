/// @description Fade out, change room, fade in
// Name: Vivek Jayakrishnan Nair | Student ID: A00341727
// Object: o_fade | Event: Step_0

// Fade to black, change room, fade back in, then remove itself
if (fading_out) {
    alpha += 0.045;
    if (alpha >= 1) { alpha = 1; fading_out = false; global.paused = false; room_goto(target); }
} else {
    alpha -= 0.035;
    if (alpha <= 0) instance_destroy();
}
