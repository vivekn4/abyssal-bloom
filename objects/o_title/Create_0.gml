/// @description Title screen setup
// Name: Vivek Jayakrishnan Nair | Student ID: A00341727
// Object: o_title | Event: Create_0

// Build the two sprite fonts once for the whole game
if (!variable_global_exists("fnt_body")) {
    global.fnt_body  = font_add_sprite_ext(s_font_body,  " !#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[]^_`abcdefghijklmnopqrstuvwxyz{|}~", true, 1);
    global.fnt_title = font_add_sprite_ext(s_font_title, " !#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[]^_`abcdefghijklmnopqrstuvwxyz{|}~", true, 2);
}

// Title scene shows the reef half-awake behind the logo
global.bloom = 0.55;
global.paused = false;
