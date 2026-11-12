# Changelog

Each section is a version of the mod, the `version` in `mod.json`. The release workflow copies the
section of a tagged version into the release notes.

## 1.0.3

- Familiar Pace sets the two speeds through the loader's `rq.battle.on_order` (the familiar's
  `own_spd` and `owner`) instead of a hook on the game's function and `rq.monster.on_create`.
  Needs loader 2.37.0. No change in the game.

## 1.0.2

- The familiar's own speed is read with the loader's `rq.monster.on_create` instead of a hook on the
  game's function, and the two `install` lines are gone. Needs loader 2.36.0. No change in the game.

## 1.0.1

- The code names the game's characters, skills, items and states with `rq.ids` instead of
  numbers. Needs loader 1.15.0. No change in the game.

## 1.0.0

First version.

- +50 evasion for Onoha Mespos.
- Familiar Pace, a shop skill only she learns: in the turn order her familiar runs at its own speed
  plus hers, and she runs at 30.
- Takes off, once, the Head Start an earlier test version gave her.
