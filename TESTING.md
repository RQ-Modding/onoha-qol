# Testing Onoha QoL

For people and agents who test the mod in the game. Check `logs\rqmod.log` for `Loading onoha-qol`
first.

## What it adds

No buttons and no `rq.agent.control` ids. Do not invent controls for it. It adds one shop skill,
**Familiar Pace**, for Onoha Mespos (character 62).

## How to check it

1. **Evasion:** her status page shows 50 more evasion than without the mod.
2. **Shop:** hub, `party`, Onoha's status, `skills`. On the `skill-shop` screen an `offer-N` row reads
   `Familiar Pace` once she is level 20. After she learns it, the row is gone.
3. **Turn order:** with Familiar Pace learned and her familiar in the fight, the familiar's `spd`
   (`rq.chara.get(10).spd`) during the turn order is its own plus Onoha's, and Onoha acts at 30.
   Outside `Ｔ順番生成` her `spd` is her own.
4. **Head Start:** on the first hub visit with an old save that had it, the log says
   `Onoha QoL: removed the Head Start an earlier version gave`, once.

## Forcing it for a test

A throwaway test mod can call `rq.chara.grant(iic, skill, 1)` with her slot (`rq.chara.find(62)`)
and the number of the text id `onoha:familiar_pace` (as Kaoru Quincy QoL's TESTING.md does for its
skills). Work on a copy of the save.
