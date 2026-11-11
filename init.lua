-- Onoha QoL. Onoha Mespos (character 62) gets +50 evasion, and a skill only
-- she can learn, Familiar Pace: in the turn order her familiar runs at its own
-- speed plus hers, and she runs at a fixed 30. In a fight the game reads speed
-- only to build the turn order (Ｔ順番生成), so the swap is made just before it
-- and undone after; her status screen keeps her own speed.

local ONOHA = rq.ids.chara.ONOHA_MESPOS
local FAMILIAR = 10        -- the familiar's character slot (PTC[1]) in a battle
local OWN_PACE = 30        -- Onoha's speed in the turn order while the skill is on
local PACE_LEVEL = 20      -- shop level gate
local PACE_POINTS = 7      -- skill points
local HEAD_START = rq.ids.skill.HEAD_START -- given by an earlier version of this mod, as an innate skill

rq.log("Onoha QoL: +50 evasion, Familiar Pace")

rq.chara.edit(ONOHA, {
  init = { eva = 50 },
})

local PACE = rq.skill.define({
  id = "onoha:familiar_pace",
  kind = "knowledge",
  name = "Familiar Pace",
  flavor = "",
  desc = "A gal master: Onoha gives her own pace to her$"
    .. "familiar, which acts sooner and more often.$$"
    .. "Target:\tHer familiar$"
    .. "Effect:\tThe familiar's speed + Onoha's speed$"
    .. "\t(no party speed cap)$"
    .. "\tOnoha herself acts at a fixed speed of " .. OWN_PACE .. "$"
    .. "\t(her status screen still shows her own)",
})

rq.chara.on_offer(function(ctx)
  if ctx.no ~= ONOHA or rq.chara.rank(ctx.iic, PACE) >= 1 then
    return nil
  end
  return { { skill = PACE, cost = PACE_POINTS, points = PACE_POINTS, level = PACE_LEVEL } }
end)

-- The familiar's own speed, read when the game makes it from its monster at the
-- start of a fight, before the game holds it to the party's top speed.
local familiar_base
rq.monster.on_create(function(ctx)
  if ctx.familiar then familiar_base = ctx.spd end
end)

-- Ｔ順番生成 runs at the start of a fight and again after a switch, and reads
-- each speed with Ｃ素早さ. Her real speed comes back as soon as it ends.
local saved
rq.ain.hook("Ｔ順番生成", {
  before = function()
    saved = nil
    local iic = rq.chara.find(ONOHA)
    if not iic or rq.chara.rank(iic, PACE) < 1 then return end
    if rq.ain.global("PTC", 1) ~= FAMILIAR or rq.ain.global("◆従魔オーナー番号") ~= iic then return end
    local spd = rq.chara.get(iic).spd
    local base = familiar_base or rq.chara.get(FAMILIAR).spd
    rq.chara.set(FAMILIAR, { spd = base + spd })
    rq.chara.set(iic, { spd = OWN_PACE })
    saved = { iic = iic, spd = spd }
  end,
  after = function()
    if saved then
      rq.chara.set(saved.iic, { spd = saved.spd })
      saved = nil
    end
  end,
})

-- The earlier version taught her Head Start, which the Remove button cannot take
-- off. Take it off once, on the hub, and remember that in the save's store so a
-- Head Start she gets later stays.
local next_check = 0
local stop
stop = rq.on_frame(function()
  if rq.store.get("head_start_removed", false) then
    stop()
    return
  end
  local now = rq.time_ms()
  if now < next_check then return end
  next_check = now + 1000
  if rq.ui.get().screen ~= "hub" then return end
  local iic = rq.chara.find(ONOHA)
  if not iic then return end
  if rq.chara.rank(iic, HEAD_START) >= 1 then
    rq.chara.forget(iic, HEAD_START)
    rq.chara.recalc(iic)
    rq.log("Onoha QoL: removed the Head Start an earlier version gave")
  end
  rq.store.set("head_start_removed", true)
end)
