local _ = require("lib.ext.classic"):extend()
local Serialize = require("lib.ext.ser")

function _:new(_t)
  local _t = _t or {}
  if _t.debug then
    self.debug = true
  end
  self.savefile = "digi_data.lua"

  local t = self:load()
  if t then
    t = t()
  else
    t = {}
  end

  self.digis = t.digis or {}
  self.dv = t.dv or {
    from_to = {},
    to_from = {},
    condition = {}
  }
  self.last = t.last or {
    digi = 0,
    condition = 0,
    ability = 0,
  }
  self.base = {}
  self.base.digi = {
    name = "",
    game_id = -1,
    attribute = 0,
    ability = 0,
    element = 0,
    species = 0,
    stage = 0,
    
    hp = 0,
    attack = 0,
    defense = 0,
    sp_attack = 0,
    sp_defese = 0,
    spirit = 0,
    is_jogress=false,
  }

  self.base.stage = {
    "Baby I", "Baby II", "Rookie",
    "Champion", "Ultimate", "Mega",
    "Ultra", "No Level",
  }

  self.base.species = {
    "Aquatic", "Beast", "Bird",
    "Dark", "Dragon", "Holy",
    "Insect", "Machine", "None",
    "Plant"
  }
  self.base.element = {
    "Earth", "Fire", "Ice",
    "Light", "Neutral", "Pitch Black",
    "Steel", "Thunder", "Water",
    "Wind", "Wood",
  }
  self.base.attribute = {
    "Data", "None", "Unknown",
    "Vaccine", "Virus",
  }

  self:save()
end

function _:addDigi(digi)
  local f_info = debug.getinfo(1, "n")
  if type(digi) ~= "table" then
    local msg = "DD:"..f_info.name.." `digi` must be a table."
    if self.debug then print(msg) end
    return false, msg
  end

  -- gen index
  self.last.digi = self.last.digi + 1
  local digi_id = self.last.digi

  -- init digi
  self.digis[digi_id] = {}
  for k, v in pairs(self.base.digi) do
    self.digis[digi_id][k] = digi[k] or self.base.digi[k]
  end
  
  self.dv.from_to[digi_id] = {}
  self.dv.to_from[digi_id] = {}

  self:save()
  return digi_id
end

function _:updDigi(digi_id, digi)
  local f_info = debug.getinfo(1, "n")
  if type(digi) ~= "table" then
    local msg = "DD:"..f_info.name.." `digi` must be a table."
    if self.debug then print(msg) end
    return false, msg
  end
  if type(digi_id) ~= "number" then
    local msg = "DD:"..f_info.name.." `digi_id` must be a number."
    if self.debug then print(msg) end
    return false, msg
  end

  if not self.digis[digi_id] then
    local msg = "DD:"..f_info.name.." no digi in digi_id: "..tostring(digi_id)
    if self.debug then print(msg) end
    return false, msg
  end
  for k, v in pairs(self.base.digi) do
    self.digis[digi_id][k] = digi[k] or self.digis[digi_id][k] or self.base.digi[k]
  end
  self:save()
  return digi_id
end

function _:rmDigi(digi_id)
  local f_info = debug.getinfo(1, "n")
  if type(digi_id) ~= "number" then
    local msg = "DD:"..f_info.name.." `digi_id` must be a number."
    return false, msg
  end

  if not self.digis[digi_id] then
    local msg = "DD:"..f_info.name.." no digi in digi_id: "..tostring(digi_id)
    if self.debug then print(msg) end
    return false, msg
  end

  for k,v in pairs(self.dv.from_to[digi_id])do
    self.dv.to_from[k][digi_id] = nil
  end
  
  for k,v in pairs(self.dv.to_from[digi_id])do
    self.dv.from_to[k][digi_id] = nil
  end

  self.dv.from_to[digi_id] = nil
  self.dv.to_from[digi_id] = nil
  self.digis[digi_id] = nil
  self:save()
  return true
end

function _:addDv(from_id, to_id, condition)
  local f_info = debug.getinfo(1, "n")
  if type(condition) ~= "table" then
    local msg = "DD:"..f_info.name.." `condition` must be a table of condition strings."
    if self.debug then print(msg) end
    return false, msg
  end

  if (type(from_id) ~= "number") or (type(to_id) ~= "number") then
    local msg = "DD:"..f_info.name.." `from_id` and `to_id` must be numbers."
    return false, msg
  end

  if not self.dv.from_to[from_id] then
    local msg = "DD:"..f_info.name.." no digi with id: "..tostring(from_id).." in dv.from_to[id]"
    if self.debug then print(msg) end
    return false, msg
  end
  if not self.dv.to_from[to_id] then
    local msg = "DD:"..f_info.name.." no digi with id: "..tostring(to_id).." in dv.to_id[id]"
    if self.debug then print(msg) end
    return false, msg
  end


  self.last.condition = self.last.condition + 1
  local condition_id = self.last.condition
  self.dv.condition[condition_id] = condition
  self.dv.from_to[from_id][to_id] = condition_id
  self.dv.to_from[to_id][from_id] = condition_id
  self:save()
  return true
end

function _:rmDv(from_id, to_id)
  local f_info = debug.getinfo(1, "n")

  if (type(from_id) ~= "number") or (type(to_id) ~= "number") then
    local msg = "DD:"..f_info.name.." `from_id` and `to_id` must be numbers."
    return false, msg
  end

  if not self.dv.from_to[from_id] then
    local msg = "DD:"..f_info.name.." no digi with id: "..tostring(from_id).." in dv.from_to[id]"
    if self.debug then print(msg) end
    return false, msg
  end
  if not self.dv.to_from[to_id] then
    local msg = "DD:"..f_info.name.." no digi with id: "..tostring(to_id).." in dv.to_id[id]"
    if self.debug then print(msg) end
    return false, msg
  end

  if (type(from_id) ~= "number") or (type(to_id) ~= "number") then
    local msg = "DD:"..f_info.name.." `from_id` and `to_id` must be numbers."
    return false, msg
  end

  if not self.dv.from_to[from_id] then
    local msg = "DD:"..f_info.name.." no digi with id: "..tostring(from_id).." in dv.from_to[id]"
    if self.debug then print(msg) end
    return false, msg
  end
  if not self.dv.to_from[to_id] then
    local msg = "DD:"..f_info.name.." no digi with id: "..tostring(to_id).." in dv.to_id[id]"
    if self.debug then print(msg) end
    return false, msg
  end


  local condition_id = self.dv.from_to[from_id][to_id]
  self.dv.condition[condition_id] = nil
  self.dv.from_to[from_id][to_id] = nil
  self.dv.to_from[to_id][from_id] = nil
  self:save()
  return true
end

function _:updDv(from_id, to_id, condition)
  local f_info = debug.getinfo(1, "n")
  if type(condition) ~= "table" then
    local msg = "DD:"..f_info.name.." `condition` must be a table of condition strings."
    if self.debug then print(msg) end
    return false, msg
  end
  if (type(from_id) ~= "number") or (type(to_id) ~= "number") then
    local msg = "DD:"..f_info.name.." `from_id` and `to_id` must be numbers."
    return false, msg
  end

  if not self.dv.from_to[from_id] then
    local msg = "DD:"..f_info.name.." no digi with id: "..tostring(from_id).." in dv.from_to[id]"
    if self.debug then print(msg) end
    return false, msg
  end
  if not self.dv.to_from[to_id] then
    local msg = "DD:"..f_info.name.." no digi with id: "..tostring(to_id).." in dv.to_id[id]"
    if self.debug then print(msg) end
    return false, msg
  end

  local condition_id = self.dv.from_to[from_id][to_id]
  self.dv.condition[condition_id] = condition
  self:save()
  return true
end

function _:getDv(from_id, to_id)
  local f_info = debug.getinfo(1, "n")

  if (type(from_id) ~= "number") or (type(to_id) ~= "number") then
    local msg = "DD:"..f_info.name.." `from_id` and `to_id` must be numbers."
    return false, msg
  end

  if not self.dv.from_to[from_id] then
    local msg = "DD:"..f_info.name.." no digi with id: "..tostring(from_id).." in dv.from_to[id]"
    if self.debug then print(msg) end
    return false, msg
  end
  if not self.dv.to_from[to_id] then
    local msg = "DD:"..f_info.name.." no digi with id: "..tostring(to_id).." in dv.to_id[id]"
    if self.debug then print(msg) end
    return false, msg
  end

  return self.dv.from_to[from_id][to_id]
end

function _:getDvs(digi_id)
  local f_info = debug.getinfo(1, "n")
  if not self.dv.from_to[digi_id] then
    local msg = "DD:"..f_info.name.." no digi with id: "..tostring(from_id).." in dv.from_to[id]"
    if self.debug then print(msg) end
    return false, msg
  end
  if not self.dv.to_from[digi_id] then
    local msg = "DD:"..f_info.name.." no digi with id: "..tostring(to_id).." in dv.to_id[id]"
    if self.debug then print(msg) end
    return false, msg
  end
  return {
    from= self.dv.to_from[digi_id], -- digis that this come from,
    to = self.dv.from_to[digi_id], -- digis that this goes to.
  }
end


function _:save()
  local t = {}
  t.digis = self.digis
  t.dv = self.dv
  t.last = self.last

  t = Serialize(t)

  if love then
    return love.filesystem.write(self.savefile, t)
  end

  file = io.open("save/"..self.savefile, "w")
  file:write(t)
  file:close()
end

function _:load()
  if love then
    return love.filesystem.load(self.savefile)
  end

  local loadfile = loadfile or load   -- for compatibility with different Lua versions
  local loaded = loadfile("save/"..self.savefile)

  if loaded then
    return loaded
  else
    return nil
  end
end



return _
