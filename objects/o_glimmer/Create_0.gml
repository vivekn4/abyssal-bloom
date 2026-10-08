/// @description Glimmerfish setup (random target, speed, colour)
// Name: Vivek Jayakrishnan Nair | Student ID: A00341727
// Object: o_glimmer | Event: Create_0
/*
    RUBRIC #8 - o_glimmer moves AUTOMATICALLY (no player input).
*/

// Glimmerfish glow above the darkness; each has its own target, speed and colour
depth = -1100;
target_x = random_range(150, room_width - 150);
target_y = random_range(200, room_height - 380);
spd = random_range(1.1, 2);
wave_t = random(360);
face = 1;
image_speed = 0.5;
image_blend = choose(make_colour_rgb(94, 242, 224), make_colour_rgb(255, 120, 210));
