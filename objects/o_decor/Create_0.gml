/// @description Shared setup for all scenery children
// Name: Vivek Jayakrishnan Nair | Student ID: A00341727
// Object: o_decor | Event: Create_0
/*
    RUBRIC #3 - background/decoration assets. o_decor is a PARENT object;
                o_kelp, o_coral, o_rock and o_seabed inherit this code.
*/

// Shared decor setup: random variant, size and sway timing
image_speed = 0;
image_index = irandom(image_number - 1);
phase = random(100);
sway = 0;
if (sprite_index == s_kelp)  { sway = 4;   var _s = random_range(0.8, 1.25); image_xscale = _s * choose(1, -1); image_yscale = _s; }
if (sprite_index == s_coral) { sway = 1.5; var _c = random_range(0.8, 1.2);  image_xscale = _c * choose(1, -1); image_yscale = _c; }
if (sprite_index == s_rock)  { image_xscale = random_range(0.9, 1.4) * choose(1, -1); image_yscale = random_range(0.8, 1.2); }
