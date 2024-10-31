local _ = require("lib.ext.classic"):extend()
local Serialize = require("lib.ext.ser")

function _:new()
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
  if type(digi) ~= "table" then
    local msg = "DD:addDigi `digi` must be a table."
    print(msg)
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
  
  self:save()
  return digi_id
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
