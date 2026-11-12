# Onoha QoL

For **Onoha Mespos**: more evasion, and a skill that lets her familiar act sooner and more often.

## What it changes

- **+50 evasion.** It reaches old saves too, as soon as a save loads, and goes away with the mod.
- **Familiar Pace**, a knowledge skill only she can learn: 7 skill points, level 20, in her skill
  shop. While she has it and her familiar is in the fight:
  - the familiar's speed is its own speed **plus** Onoha's (the one on her status screen), with no
    party speed cap. A familiar at 20 with Onoha at 30 runs at 50;
  - Onoha herself acts at a fixed speed of 30. Her status screen still shows her own.

  Without the skill the game's rule stands: the familiar uses its own speed, capped at the party's top
  speed.

An earlier test version taught her **Head Start** as an innate skill. This version takes it off
once, on the hub, and remembers that it did.

## Keys and settings

None in the game. The numbers are at the top of `init.lua`: `OWN_PACE`, `PACE_LEVEL` and
`PACE_POINTS`.

## Saves

Familiar Pace, once learned, is in the save. The evasion is not: it is added at every recalculation
and is gone without the mod.

## Install

Needs [RQ MOD](https://github.com/RQ-Modding/RQ-Mod) with loader **2.37.0** or newer. Extract the
release zip into the game's `mods` folder, so that you have `mods/onoha-qol/mod.json`.

## How it works

In a fight the game reads speed only to build the turn order, at the start of a fight and after a
switch. The mod sets the two speeds for that build only (`rq.battle.on_order`), so Onoha's own comes
back right after. The familiar's own speed is its speed before the game holds it to the party's top
speed (the familiar unit's `own_spd`).

## License

MIT, see [LICENSE](LICENSE).
