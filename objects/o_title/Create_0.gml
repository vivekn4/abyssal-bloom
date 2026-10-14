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

// VN upgrade: read the saved dive + best times (ini) for Continue / best-time display
save_exists = false;
save_pearls = 0;
save_lamps = 0;
save_caught = 0;
save_difficulty = 1;
save_won = 0;
best_0 = -1;
best_1 = -1;
best_2 = -1;
if (!variable_global_exists("difficulty")) global.difficulty = 1;
if (!variable_global_exists("resume_dive")) global.resume_dive = false;
ini_open("abyssal_save.ini");
best_0 = ini_read_real("best", "best_0", -1);
best_1 = ini_read_real("best", "best_1", -1);
best_2 = ini_read_real("best", "best_2", -1);
save_won = ini_read_real("dive", "won", 0);
save_pearls = ini_read_real("dive", "pearls", 0);
save_lamps = ini_read_real("dive", "lamps", 0);
save_caught = ini_read_real("dive", "caught", 0);
save_difficulty = ini_read_real("dive", "difficulty", 1);
if (save_won == 0 && (save_pearls > 0 || save_lamps > 0 || save_caught > 0)) save_exists = true;
ini_close();

// VN upgrade: seconds -> "M:SS" for the best-time line ("--:--" = no win yet)
fmt_time = function(_sec) {
    if (_sec < 0) return "--:--";
    var _m = floor(_sec / 60);
    var _s = floor(_sec mod 60);
    return string(_m) + ":" + (_s < 10 ? "0" : "") + string(_s);
};
