/// @description Draw the fish facing and tilting with its motion
// Name: Vivek Jayakrishnan Nair | Student ID: A00341727
// Object: o_angler | Event: Draw_0

// Draw facing the swim direction, tilting with vertical speed, bobbing gently
var _bob = sin(current_time / 300) * 2;
draw_sprite_ext(sprite_index, image_index, x, y + _bob, face, 1, clamp(-vy * 3, -12, 12) * face, c_white, 1);
