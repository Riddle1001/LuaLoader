-- Scraped by chicken
-- Author: Chicken4676
-- Title [Release] GLUA timers for CSGO
-- Forum link https://aimware.net/forum/thread/128192

local timer = timer or {}
local timers = {}

function timer.Exists(name)
  for k,v in pairs(timers) do
    if name == v.name then
      return true
    end
  end
  return false
end

function timer.Create(name, delay, repetitions, func)
  if not timer.Exists(name) then
    table.insert(timers, {type = "Create", name = name, delay = delay, repetitions = repetitions, func = func, lastTime = globals.CurTime() + delay, repStartTime = globals.CurTime()})
  end
end

function timer.Simple(name, delay, func)
  if not timer.Exists(name) then
    table.insert(timers, {type = "Simple", name = name, func = func, lastTime = globals.CurTime() + delay, delay = delay})
  end
end


function timer.Spam(name, duration, func)
  if not timer.Exists(name) then
    table.insert(timers, {type = "Spam", name = name, duration = duration, func = func, lastTime = globals.CurTime()})
  end
end

function timer.Remove(name)
  for k,v in pairs(timers or {}) do
    if name == v.name then
      table.remove(timers, k)
      return true
    end
  end
  return false
end



function timer.Pause(name)
  for k, v in pairs(timers) do
    if name == v.name then
      v.pause = true
      return true
    end
  end
  return false
end

function timer.UnPause(name)
  for k, v in pairs(timers) do
    if name == v.name and v.pause then
      v.pause = false
      return true
    end
  end
end

function timer.RepsLeft(name)
  for k,v in pairs(timers) do
    if name == v.name and v.type == "Create" then
      return v.repetitions
    end
  end
  return false
end

function timer.Restart(name)
  for i=1, #timers do
    if name == timers[i].name then
      if timers[i].type == "Simple" then
        timers[i].lastTime = globals.CurTime() + timers[i].delay
      end
    end
  end
end


function timer.Toggle(name)
  for k, v in pairs(timers) do
    if name == v.name then
      if v.pause then
        v.pause = false
      elseif v.pause == false then
        v.pause = true
      end
    end
  end
end

function timer.TimeLeft(name)
  for k, v in pairs(timers) do
    if name == v.name then
      if v.type == "Create" then
        return v.delay * timer.RepsLeft(name) - (globals.CurTime() - v.repStartTime)
      elseif v.type == "Simple" or v.type == "Spam" then
        return globals.CurTime() - v.lastTime
      end
    end
  end
end


function timer.Adjust(name, delay, repetitions, func)
  for i=1, #timers do
    if name == timers[i].name then
      if timers[i].type == "Create" then
        timers[i] = {type = "Create", name = name, delay = delay, repetitions = repetitions, func = func, lastTime = globals.CurTime() + delay, repStartTime = globals.CurTime()}
      end
    end
  end
end

function timer.Tick()
  for k, v in pairs(timers or {}) do
    if not v.pause then
      -- timer.Create
      if v.type == "Create" then
        if v.repetitions <= 0 then
          table.remove(timers, k)
        end
        if globals.CurTime() >= v.lastTime then
          v.lastTime = globals.CurTime() + v.delay
          v.repStartTime = globals.CurTime()
          v.func()
          v.repetitions = v.repetitions - 1
        end
      -- timer.Simple
      elseif v.type == "Simple" then
        if globals.CurTime() >= v.lastTime then
          v.func()
          table.remove(timers, k)
        end
      -- timer.Spam
      elseif v.type == "Spam" then
        v.func()
        if globals.CurTime() >= v.lastTime + v.duration then
          table.remove(timers, k)
        end
      end
    end
  end
end


callbacks.Register( "Draw", "timerTick", timer.Tick)



