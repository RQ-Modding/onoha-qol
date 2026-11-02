# Onoha QoL

For **Onoha Mespos** (character 62). Needs loader **1.2.1**.

- **+50 evasion**, applied at every recalculation, so it also reaches old saves, and it goes away with the mod. Loader 1.2.1 applies it as soon as a save loads.
- **Familiar Pace**, a knowledge skill only she can learn: 7 skill points, level 20, in her skill shop. It makes her a gal master whose familiar acts sooner and more often. While she has it and her familiar is in the fight:
  - the familiar's speed is its monster's own speed **plus** Onoha's speed (the one on her status screen), with no party speed cap. A familiar at 20 with Onoha at 30 runs at 50;
  - Onoha herself acts at a fixed speed of 30. Her status screen still shows her own.

  In a fight the game reads speed only to build the turn order (`Ｔ順番生成`, at the start of a fight and after a switch), so the swap is made just before it and undone right after. Without the skill, the game's rule stands: the familiar uses its monster's own speed, capped at the party's top speed (see `rqmod/docs/familiar-turns.md`).

Speed and Head Start were tried and taken out (Moru, 2026-11-02). An earlier version taught her Head Start as an innate skill; this one takes it off once, on the hub, and remembers that in the save's store.

Local-only git. No remote.
