# Abyssal Bloom — PLAN.md

**Crafted by Vivek Nair · VN** · GameMaker (100% GML, no drag-and-drop) · MIT

A living plan for the game: what it is, how the new systems work, what could break,
and what comes next. Updated 2026-10-14 with the teardown + upgrade pass
(save/continue, Whale Call, dash, fish variants, depth-graded darkness, difficulty).

## 1. The game in one paragraph

The reef has gone dark. You are a small lanternfish with one light — catch
glimmerfish to free their pearls, gather **five pearls**, and watch the whole reef
bloom from cold black into full colour. A cozy 2D exploration game: no fail state,
no enemies that hurt you, just light, motion, and a whale that sings every ~20 s.

## 2. Architecture (where things live)

| System | Owner | Notes |
|---|---|---|
| Player swim / dash / Whale Call | `o_angler` (Create, Step, Draw, 2 collisions) | Velocity + drag; dash adds burst accel; `C` triggers the Call |
| Reef controller | `o_reef` (Create, Step, End Step, Draw, Draw GUI, Alarm 0, CleanUp) | Darkness surface, camera, particles, rings, floaters, HUD, win, save/load |
| Glimmerfish | `o_glimmer` (Create, Step, Draw) | Sine-wave seek + dodge; 3 variants; calmed by the Call |
| Pearls | `o_pearl` (Create, Step, Draw) | Sink / magnet drift toward player; magnet widens during the Call |
| Lamps | `o_lamp` (Create, Step, Draw, Mouse Left) | Click-to-wake; light radius grows with pearls carried |
| Scenery | `o_decor` parent + `o_kelp` / `o_coral` / `o_rock` / `o_seabed` | Sway + bloom tint |
| Screens | `o_splash`, `o_title`, `o_fade` | Splash → title → reef; fade transitions; title owns difficulty + Continue |
| Save | `abyssal_save.ini` (written by `o_reef.save_dive()`, read by `o_title` + `o_reef`) | Sections: `[dive]` (pearls/caught/lamps/difficulty/won), `[best]` (best_0/1/2) |

Key globals: `global.paused`, `global.bloom`, `global.difficulty` (0 CALM / 1 DEEP / 2 ABYSS),
`global.resume_dive`, `global.fnt_body`, `global.fnt_title`.

### Upgrade systems (2026-10-14)

1. **Save / Continue + best times** — `o_reef.save_dive()` writes the ini on every
   catch, pearl, woken lamp, and win (win also records best time per difficulty).
   Title reads it: `C` continues (restores pearls/caught/lamps + difficulty;
   `o_reef` applies the restore on its first Step, after all instances exist).
   A completed dive (`won = 1`) hides Continue.
2. **Whale Call** — the first whale song sets `call_unlocked` and teaches the move.
   `C` spends it: 4 s calm (glimmerfish stop dodging, half speed) + pearl magnet
   radius 140 → 400; 25 s cooldown; HUD shows READY / countdown.
3. **Dash** — `Shift`: 12-frame burst along the swim direction (or facing), bubble
   trail + ring, 100-frame cooldown, HUD bar under the pearl counter.
4. **Glimmerfish variants** — depth-weighted table in `o_glimmer` Create:
   drifter (common, mid speed), dart (fast, small, shy, gold), lumen (slow, big,
   calm, violet). Deeper spawns skew rarer/faster. Difficulty multiplies speed
   (0.85 / 1.0 / 1.25) and dodge radius (0.8 / 1.0 / 1.25).
5. **Depth-graded darkness + lure beam + pearl-scaled lamps** — the darkness
   surface alpha now ramps with the player's depth (±0.07 around the bloom blend);
   a stretched `s_light` ellipse beams ahead of the lure; lit-lamp holes scale
   `1 + 0.12 × pearls carried`.
6. **Difficulty** — title keys `1/2/3` set `global.difficulty`; whale interval
   24 s / 20 s / 16 s; fish speed/dodge scale; best times tracked per difficulty.

## 3. Likely bugs / problems + mitigations

| Risk | Mitigation in place |
|---|---|
| Restore runs before lamps exist | Restore happens in `o_reef` Step (first frame), not Create — all room instances exist by then |
| Stale save resurrects a finished dive | `save_dive()` writes `won`; title hides Continue when `won == 1`; replay sets `resume_dive = false` |
| Player presses `C` on title with no save | `C` is gated on `save_exists`; no-op otherwise |
| `global.difficulty` missing (direct room run in IDE) | Every reader guards with `variable_global_exists("difficulty")` and defaults to 1 (DEEP) |
| Dash + Call key spam | Dash has a 100-frame cooldown; Call has a 25 s cooldown; Call-before-unlock shows one teaching toast |
| ini write fails (read-only folder) | GameMaker `ini_*` calls fail silently; the game still runs, just without persistence — no crash path |
| Floaters pile up | Capped at 12 (oldest dropped); each lives 75 frames |
| `o_reef.save_dive()` called when player is gone | Guards with `instance_exists(o_angler)` |
| New code breaks the assignment rubric mapping | No rubric behaviour removed: same objects, same events, same win condition (5 pearls → bloom) |

## 4. UI / UX thinking

- **Teach, don't tutorialize.** The Whale Call is taught at the moment it is earned
  (first whale song + toast + HUD line), not in a front-loaded help screen.
- **Every new mechanic gets a HUD home.** Dash = bar under pearls. Call = line under
  the whale meter. Difficulty + best times + saved dive = title screen, where the
  player is already deciding.
- **Juice stays maximalist-VN but purposeful.** Floaters (`CAUGHT!`, `+1 PEARL`,
  `LAMP AWOKE`, `THE DEEP ANSWERS`) mirror the event that made them; the dash ring
  and bubble burst sell the burst; the beam sells the light. No juice without a cause.
- **Cozy first.** Nothing added can kill the player or soft-lock the dive: no oxygen,
  no lives, no hazards. Difficulty only changes fish speed/wariness and song timing.
- **Title-screen layout budget.** At 1280×720 the new lines sit at +185 / +210 /
  +235 below centre, clear of the pill (+62…+112), the controls line (+160), and
  the credit at the bottom. If the GUI scale ever changes, re-check these offsets.

## 5. What was deliberately NOT added (teardown findings)

- **Oxygen / fail state** (seen in Kelvin the Diver) — would change the cozy genre.
  Only its floating-text feedback pattern was adopted.
- **Shop / upgrade economy with escalating costs** (Kelvin) — needs a currency
  system; pearls are the win condition and must not double as currency.
- **Lives / damage + invulnerability** (Underwater Explorer) — no hazards exist,
  so lives would be decoration. Skipped.
- **Song-combination input** (Aquaria: sing note sequences for verbs) — the Whale
  Call keeps the *mechanism* (learned song = reusable verb) with a single key,
  which fits this game's one-button verbs.
- **Procedural terrain / day-night cycle** (Kelvin) — out of scope for a fixed
  3200×2000 hand-placed reef; the depth-graded darkness covers the "deeper =
  darker" feel without regenerating the room.

## 6. QA status (2026-10-14)

- GameMaker is **not installed** in this environment, so the game was **not**
  compiled or playtested here. GML was validated by static checks only (see §7).
- First real playtest must be in GameMaker: fresh dive, Continue flow, Call timing,
  dash feel, variant behaviour on all three depths, and a full win → best-time save.
- Do not claim a build works until that playtest passes.

## 7. QA checklist for the next human playtest

- [ ] Fresh dive on CALM / DEEP / ABYSS: fish speeds feel distinct; whale interval differs
- [ ] First whale song → Call toast + HUD line; `C` calms fish + pulls pearls; 25 s cooldown
- [ ] `Shift` dash: burst, bubbles, ring, cooldown bar refills
- [ ] Catch → `CAUGHT!`; pearl → `+1 PEARL`; lamp → `LAMP AWOKE`; all saved
- [ ] Quit mid-dive → title shows saved dive → `C` restores pearls/lamps/difficulty
- [ ] Win → `NEW BEST TIME!` on first win per depth; title best-times line updates
- [ ] Win → title hides Continue; `Enter` starts a genuinely fresh dive
- [ ] Darkness visibly deeper at the reef floor than near the surface; lure beam visible
