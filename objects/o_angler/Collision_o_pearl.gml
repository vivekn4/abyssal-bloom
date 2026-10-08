/// @description Collect a pearl; 5 pearls bloom the reef
// Name: Vivek Jayakrishnan Nair | Student ID: A00341727
// Object: o_angler | Event: Collision_o_pearl
/*
    RUBRIC #5  - meaningful interaction: every pearl moves the player closer to
                 changing the colour of the WHOLE room (the bloom), which is the win.
    RUBRIC #9c - COLLISION event (o_angler with o_pearl).
*/

// Collecting a pearl; five of them make the whole reef bloom
pearls += 1;
part_particles_create(o_reef.ps, other.x, other.y, o_reef.pt_spark, 30);
var _snd = asset_get_index("snd_pearl");  // optional sound: plays only once it is added to the project
if (_snd != -1) audio_play_sound(_snd, 1, false);
instance_destroy(other);
if (pearls >= o_reef.pearls_needed) {
    o_reef.bloom_target = 1;
    o_reef.toast("The reef is waking up...", 200);
} else {
    var _left = o_reef.pearls_needed - pearls;
    o_reef.toast(string(_left) + (_left == 1 ? " more pearl" : " more pearls") + " to wake the reef", 130);
}
