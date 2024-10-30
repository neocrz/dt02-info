local _ = require("lib.ext.classic"):extend()
local Serialize = require("lib.ext.ser")
function _:checkIndex(box, line, row, msg)
  local msg = msg or ""
  if (type(box) ~= "number" ) or
  (type(line) ~= "number" ) or
  (type(row) ~= "number" )
  then
    msg = msg.." box,line,row are not valid numbers"
    print(msg)
    return false, msg
  end
  if 
    ((box<1) or (box>self.sizes.box)) or
    ((line<1) or (line>self.sizes.line)) or
    ((row<1) or (row>self.sizes.row))
  then
    msg = msg.." box,line,row are not valid indexes"
    print(msg)
    return false, msg
  end
  return true, "Valid indexes"
end

function _:genBoxes()
  self.boxes = {}
  for i = 1, self.sizes.box do
    self.boxes[i]={}
    for j = 1, self.sizes.line do
      self.boxes[i][j]={}
      for k = 1, self.sizes.row do
        self.boxes[i][j][k]={
          digi_id=-01,
          level=0,
          hp=0,
          attack=0,
          defense=0,
          sp_attack=0,
          sp_defense=0,
        }
      end
    end
  end
  self.base_digi = copyt(self.boxes[1][1][1])
  self:save()
  return true
end
_.cleanBoxes = _.genBoxes

function _:new()
  self.savefile = "player_data.lua"
  self.sizes = {
    box=12,
    line=6,
    row=10,
  }
  local t = self:load()
  if t then
    t = t()
  else
    t = {}
  end
  self.boxes = t.boxes
  self.base_digi = t.base_digi
  if not self.boxes then self:genBoxes() end
  self:save()
end


function _:save()
  local t = {}
  t.boxes = self.boxes
  t.base_digi = self.base_digi
  t = Serialize(t)

  if love then
    return love.filesystem.write(self.savefile, t)
  end

  file = io.open(self.savefile, "w")
  file:write(t)
  file:close()
end

function _:load()
  if love then
    return love.filesystem.load(self.savefile)
  end

  local loadfile = loadfile or load -- for compatibility with different Lua versions
  local digi_data_loader = loadfile(self.savefile)

  if digi_data_loader then
    return digi_data_loader
  else
    return nil
  end
end

function _:addDigi(box, line, row, digi_table)
  local f_info = debug.getinfo(1, "n")
  local valid, msg = self:checkIndex(box,line,row,"PD:"..f_info.name)

  if not valid then
    return false, msg
  end

  if type(digi_table) ~= "table" then
    local msg = "PD:addDigi digi_table must be a table."
    return false, msg
  end

  local d = digi_table or {}

  for k,v in pairs(self.boxes[box][line][row]) do
    self.boxes[box][line][row][k] = d[k] or self.boxes[box][line][row][k]
  end
  self:save()
  return true
end

_.updDigi = _.addDigi

function _:rmDigi(box,line,row)
  local f_info = debug.getinfo(1, "n")
  local valid, msg = self:checkIndex(box,line,row,"PD:"..f_info.name)

  if not valid then
    return false, msg
  end

  self.boxes[box][line][row] = copyt(self.base_digi)
  self:save()
  return true
end

function _:getDigi(box,line,row)
  local f_info = debug.getinfo(1, "n")
  local valid, msg = self:checkIndex(box,line,row,"PD:"..f_info.name)

  if not valid then
    return false, msg
  end

  return self.boxes[box][line][row]
end

return _