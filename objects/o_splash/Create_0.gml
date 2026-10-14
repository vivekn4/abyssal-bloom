/// @description Splash screen setup
// Name: Vivek Jayakrishnan Nair | Student ID: A00341727
// Object: o_splash | Event: Create_0

// Build the two sprite fonts once for the whole game
if (!variable_global_exists("fnt_body")) {
    global.fnt_body  = font_add_sprite_ext(s_font_body,  " !#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[]^_`abcdefghijklmnopqrstuvwxyz{|}~", true, 1);
    global.fnt_title = font_add_sprite_ext(s_font_title, " !#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[]^_`abcdefghijklmnopqrstuvwxyz{|}~", true, 2);
}

// Splash timing and shared game settings
window_set_caption("Abyssal Bloom  |  Vivek Jayakrishnan Nair  |  A00341727");
global.bloom = 0;
global.paused = false;
// VN upgrade: shared defaults — difficulty (0 CALM, 1 DEEP, 2 ABYSS) and fresh-dive flag
if (!variable_global_exists("difficulty")) global.difficulty = 1;
if (!variable_global_exists("resume_dive")) global.resume_dive = false;
t = 0;
