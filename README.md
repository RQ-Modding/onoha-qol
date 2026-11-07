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

Needs [RQ MOD](https://github.com/RQ-Modding/RQ-Mod) with loader **1.2.1** or newer. Extract the
release zip into the game's `mods` folder, so that you have `mods/onoha-qol/mod.json`.

## How it works

In a fight the game reads speed only to build the turn order (`Ｔ順番生成`, at the start of a fight
and after a switch). The mod swaps the two speeds just before it and puts Onoha's back right after.
The familiar's own speed is read when the game makes it from its monster (`Ｃ敵登録`), before the
party cap.

## License

MIT, see [LICENSE](LICENSE).
