/// @description Player setup (velocity-based swimming)
// Name: Vivek Jayakrishnan Nair | Student ID: A00341727
// Object: o_angler | Event: Create_0
/*
    RUBRIC #4 / #6 - o_angler is the PLAYER object, moved with the keyboard.
*/

// Lantern fish: underwater movement uses velocity, so it glides and drifts
vx = 0;
vy = 0;
acc = 0.45;
max_spd = 5;
face = 1;
bubble_t = 0;
pearls = 0;
caught = 0;
lure_x = x;
lure_y = y;
image_speed = 0.4;
// VN upgrade: dash state (Shift burst + cooldown)
dash_cd = 0;
dash_t = 0;
dash_dir = 0;
