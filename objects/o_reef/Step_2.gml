/// @description End Step: viewport camera follows the player
// Name: Vivek Jayakrishnan Nair | Student ID: A00341727
// Object: o_reef | Event: Step_2
/*
    RUBRIC #7 - VIEWPORT that follows the player.
    Views are enabled in rm_reef (view 0 = 1280x720). Every frame, after
    the player has moved, the camera eases toward the player, is clamped
    to the room edges, and leads a little in the swim direction.
*/

// Smooth camera that leads slightly in the swim direction, with screen shake
if (!instance_exists(o_angler)) exit;
var _cam = view_camera[0];
var _vw = camera_get_view_width(_cam);
var _vh = camera_get_view_height(_cam);
var _tx = clamp(o_angler.x - _vw / 2 + o_angler.vx * 18, 0, room_width - _vw);
var _ty = clamp(o_angler.y - _vh / 2 + o_angler.vy * 12, 0, room_height - _vh);
if (cam_x < 0) { cam_x = _tx; cam_y = _ty; }
cam_x = lerp(cam_x, _tx, 0.08);
cam_y = lerp(cam_y, _ty, 0.08);
if (!global.paused) shake = max(shake - 0.35, 0);
camera_set_view_pos(_cam, cam_x + random_range(-shake, shake), cam_y + random_range(-shake, shake));
