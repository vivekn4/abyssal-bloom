/// @description Catch a glimmerfish -> it turns into a pearl
// Name: Vivek Jayakrishnan Nair | Student ID: A00341727
// Object: o_angler | Event: Collision_o_glimmer
/*
    RUBRIC #5  - meaningful interaction: catching a fish does NOT just delete it.
                 It spawns a new object (o_pearl), a light ripple, particles and
                 screen shake. The pearl then drifts toward the player on its own.
    RUBRIC #9c - COLLISION event (o_angler with o_glimmer).
*/

// Catching a glimmerfish: burst of light, a ripple, a little shake, and a pearl drops out
// "other" is the glimmerfish we touched
caught += 1;
part_particles_create(o_reef.ps, other.x, other.y, o_reef.pt_spark, 22);
o_reef.add_ring(other.x, other.y, 90, 3, other.image_blend);
o_reef.shake = 5;
instance_create_layer(other.x, other.y, "Instances", o_pearl);  // the fish becomes a pearl
var _snd = asset_get_index("snd_catch");  // optional sound: plays only once it is added to the project
if (_snd != -1) audio_play_sound(_snd, 1, false);
instance_destroy(other);
