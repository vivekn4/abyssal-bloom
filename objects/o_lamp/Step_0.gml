/// @description Lit lamps flicker
// Name: Vivek Jayakrishnan Nair | Student ID: A00341727
// Object: o_lamp | Event: Step_0

// Lit bulbs flicker softly
if (lit) flick = 1 + sin(current_time / 90 + phase) * 0.04 + random(0.04);
