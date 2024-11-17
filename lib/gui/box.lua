local path             = (...):match("(.-)[^%.]+$")

local col              = require(path .. "col")
local base             = require(path .. "base")
local Box = base.Rect:extend()

function Box:new(_t)
  local t = _t or {}
  Box.super.new(self, t)
  self.mode = "line"
  self.col_type = "rect"
  self.objs = t.objs or {}
  self.objs.w = self.w
  self.objs.h = self.objs.h or 30
  self.objs.count = 0
  self.objs.ref = {x=0,y=0}
  self.objs.objs = {}
  self.objs.padding = self.objs.padding or {}
  self.objs.padding.h = self.objs.padding.h or 10
  self.mousewheelsen = t.mousewheelsen or 4
  self._hasbeenpressed = false
end

function Box:draw()
  love.graphics.rectangle(self.mode, self.x, self.y, self.w, self.h)
  love.graphics.setScissor(self.x, self.y, self.w, self.h)
  for _, obj in pairs(self.objs.objs) do
    obj:draw()
  end
  love.graphics.setScissor()
end

function Box:addObj(obj)
  obj.x = self.x
  obj.w = self.objs.w
  obj.h = self.objs.h
  obj._base_y = (self.objs.h * self.objs.count)
  self.objs.objs[obj]=obj
  self.objs.count = self.objs.count + 1
  return true
end

function Box:update(dt)
  for _, obj in pairs(self.objs.objs) do
    obj.y = self.y+self.objs.ref.y + obj._base_y
    obj:update(dt)
  end
end

function Box:moveRef(dy)
  local new_refy = self.objs.ref.y + dy
  if new_refy > 0 then
    self.objs.ref.y = 0
    return
  elseif new_refy < -(self.objs.h * (self.objs.count - 1)) then
    return
  end
  self.objs.ref.y = new_refy
end

function Box:touchpressed(id, x, y, dx, dy, pressure)
  if col[self.col_type]({ x = x, y = y }, self) then
    self:moveRef(dy)
  end

  for _, obj in pairs(self.objs.objs) do
    obj:touchpressed(id, x, y, dx, dy, pressure)
  end
end

function Box:touchmoved(id, x, y, dx, dy, pressure)
  if col[self.col_type]({ x = x, y = y }, self) then
    self:moveRef(dy)
  end

  for _, obj in pairs(self.objs.objs) do
    obj:touchmoved(id, x, y, dx, dy, pressure)
  end
end

function Box:touchreleased(id, x, y, dx, dy, pressure)
  if col[self.col_type]({ x = x, y = y }, self) then
    for _, obj in pairs(self.objs.objs) do
      obj:touchreleased(id, x, y, dx, dy, pressure)
    end
  end
end

function Box:mousepressed(x, y, button, istouch, presses)
  if col[self.col_type]({ x = x, y = y }, self) then
    self._hasbeenpressed = true
  end
  for _, obj in pairs(self.objs.objs) do
    obj:mousepressed(x, y, button, istouch, presses)
  end
end

function Box:mousereleased(x, y, button, istouch, presses)
  self._hasbeenpressed = false
  if col[self.col_type]({ x = x, y = y }, self) then
    for _, obj in pairs(self.objs.objs) do
      obj:mousereleased(x, y, button, istouch, presses)
    end
  end
end

function Box:mousemoved(x, y, dx, dy, istouch)
  if self._hasbeenpressed then
    self:moveRef(dy)
  end
  for _, obj in pairs(self.objs.objs) do
    obj:mousemoved(x, y, dx, dy, istouch)
  end
end

function Box:wheelmoved(_,y)
  local mx, my = love.mouse.getPosition( )
  if col[self.col_type]({ x = mx, y = my }, self) then
    self:moveRef(y*self.mousewheelsen)
  end
end

return Box
