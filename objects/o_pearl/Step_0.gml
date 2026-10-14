/// @description Pearl sinks, or drifts toward the player
// Name: Vivek Jayakrishnan Nair | Student ID: A00341727
// Object: o_pearl | Event: Step_0
/*
    RUBRIC #8 - another automatic mover: the pearl is pulled toward the player.
*/

// Drift to the lantern fish when close, otherwise sink and rest on the sand
if (global.paused) exit;
if (!instance_exists(o_angler)) exit;  // safety: never read the player if it is gone
t += 1;
var _d = point_distance(x, y, o_angler.x, o_angler.y);
// VN upgrade: the Whale Call widens the pearl magnet so pearls stream home
var _magnet = 140 + ((instance_exists(o_reef) && o_reef.call_t > 0) ? 260 : 0);
if (_d < _magnet) {
    var _a = point_direction(x, y, o_angler.x, o_angler.y);
    vx += lengthdir_x(0.5, _a);
    vy += lengthdir_y(0.5, _a);
    resting = false;
} else if (!resting) {
    vy += 0.03;
}
vx *= 0.94;
vy *= 0.94;
x += vx;
y += vy;
var _floor = room_height - 200;
if (y > _floor) { y = _floor; vy = 0; resting = true; }
