ASSIGNMENT 1  -  "Abyssal Bloom", a deep-sea light story
Vivek Jayakrishnan Nair  |  Student ID A00341727
GameMaker project: Assignment1.yyp  (GML only, no Drag and Drop)

HOW TO RUN
1. Unzip to a folder that is NOT synced by OneDrive/iCloud/Dropbox,
   e.g.  C:\GameMakerProjects\Assignment1
2. Double-click Assignment1.yyp (or File > Open in GameMaker).
3. If GameMaker offers to upgrade the project, say yes.
4. Press F5 to run.

THE IDEA
The reef has gone dark. You are a small lantern fish with one light.
Catch glimmerfish to free pearls, gather five pearls, and the whole reef
blooms from cold black into full colour. Click the anemone lamps to light
your way. Every 20 seconds a whale sings and the glimmerfish scatter.

CONTROLS
WASD / Arrows ........ swim (glides with water drag)
Touch a glimmerfish .. catch it (a pearl drops out)
Touch a pearl ........ collect it (pearls also drift toward you)
Click a nearby lamp .. wake it and light the area
P / Esc .............. pause   (T on pause or win screen = title)
Enter (after win) .... dive again

RUBRIC CHECKLIST  (every spot is also tagged "RUBRIC #" in the code comments)
 1  GML project named Assignment1 ...... Assignment1.yyp, every event is GML (isDnD = false)
 2  Big room ........................... rm_reef is 3200 x 2000 (view is 1280 x 720)
 3  Background sprite assets ........... s_water background layer + kelp, coral, rock and
                                         seabed scenery (o_decor parent with 4 children)
 4  3+ distinct objects ................ o_angler, o_glimmer, o_pearl, o_lamp, o_reef, decor
 5  Meaningful interaction ............. o_angler + o_glimmer: the fish turns into a pearl,
                                         the pearl is pulled toward the player, and 5 pearls
                                         re-colour the entire room (the win)
 6  Keyboard player .................... o_angler  Step_0  (WASD / arrows)
 7  Viewport follows player ............ o_reef  Step_2 (End Step) moves view_camera[0]
 8  Automatic movement ................. o_glimmer Step_0 (sine-wave swim + dodge),
                                         o_pearl Step_0 (sinks / drifts to player)
 9a Step event ......................... o_angler, o_glimmer, o_reef Step_0
 9b Alarm .............................. o_reef Alarm_0: whale song every 20 s
 9c Collision .......................... o_angler with o_glimmer, o_angler with o_pearl
 9d Other event ........................ o_lamp Mouse Left Pressed (Mouse_4)
10  Comments ........................... every event has a /// @description line,
                                         // line comments and /* block */ comments

OBJECTS
o_splash, o_title, o_fade ........ screens and transitions
o_angler ......................... player
o_glimmer, o_pearl, o_lamp ....... gameplay
o_reef ........................... controller (darkness, camera, particles, alarm, HUD, win)
o_decor -> o_kelp, o_coral, o_rock, o_seabed   swaying scenery that blooms with the reef

OPTIONAL SOUNDS
extra_sounds has five .wav files. Drag them into the Sounds folder in GameMaker
and keep their names (snd_catch, snd_pearl, snd_lamp, snd_whale, snd_win).
The code plays them automatically once they exist; the game runs fine without them.

Fonts: Lora and Poppins (SIL Open Font License), baked into sprite fonts.
