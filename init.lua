-- Onoha QoL. Onoha Mespos (character 62) gets +50 evasion, and a skill only
-- she can learn, Familiar Pace: in the turn order her familiar runs at its own
-- speed plus hers, and she runs at a fixed 30. In a fight the game reads speed
-- only to build the turn order; rq.battle.on_order sets both speeds for that
-- build only, so her status screen keeps her own.

local ONOHA = rq.ids.chara.ONOHA_MESPOS
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

-- The turn list is built at the start of a fight and again after a switch. The familiar's
-- own_spd is its speed before the game holds it to the party's top speed.
rq.battle.on_order(function(ctx)
  local iic = rq.chara.find(ONOHA)
  if not iic or rq.chara.rank(iic, PACE) < 1 then return end
  local familiar, onoha
  for _, u in ipairs(ctx.units) do
    if u.side == "familiar" then familiar = u elseif u.iic == iic then onoha = u end
  end
  if not familiar or not onoha or familiar.owner ~= iic then return end
  ctx:speed(familiar.iic, math.min(9999, familiar.own_spd + onoha.spd))
  ctx:speed(iic, OWN_PACE)
end)

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
