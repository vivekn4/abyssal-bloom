/// @description Free surface and particles
// Name: Vivek Jayakrishnan Nair | Student ID: A00341727
// Object: o_reef | Event: CleanUp_0

// Free the light surface and particle system when leaving the room
if (surface_exists(dark_surf)) surface_free(dark_surf);
part_type_destroy(pt_spark);
part_type_destroy(pt_bubble);
part_type_destroy(pt_snow);
part_system_destroy(ps);
