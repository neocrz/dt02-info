local path = (...):match("(.-)[^%.]+$")
local _ = {}

local col = require(path .. "col")
local base = require(path .. "base")

local _t = {}
_t.r, _t.g, _t.b, _t.a = love.graphics.getColor()

local dflt = {
  color = { 1, 1, 1, 1 },
  ext_color = { _t.r, _t.g, _t.b, _t.a },
  font = love.graphics.getFont(),
}


_.Button = base.Point:extend()

function _.Button:new(t)
  local t = t or {}
  _.Button.super.new(self, t)
  self.text = t.text or ""
  self.font = t.font or dflt.font
  self.color = t.color or { text = {} }
  self.color = {
    inactive = self.color.inactive or dflt.color,
    active = self.color.active or dflt.color,
    text = {
      inactive = self.color.text.inactive or dflt.color,
      active = self.color.text.active or dflt.color,
    }
  }

  self.mode = t.mode or {}
  self.mode = {
    inactive = self.mode.inactive or "line",
    active = self.mode.active or "fill",
  }
  self.action = t.action or {}
  self.action = {
    pressed = self.action.pressed or nil,
    released = self.action.released or nil,
    hover = self.action.hover or nil,
    out = self.action.out or nil,
  }
  self.col_type = nil
end

function _.Button:draw()
  if self._draw then self:_draw() end
end

_.rect = _.Button:extend()
function _.rect:new(t)
  local t = t or {}
  _.rect.super.new(self, t)
  self.w = t.w or 0
  self.h = t.h or 0
  self.draws = t.draws or {}
  self.draws.inactive = self.draws.inactive or function(self)
    -- box
    love.graphics.setColor(unpack(self.color.inactive))
    love.graphics.rectangle(
      self.mode.inactive,
      self.x, self.y,
      self.w, self.h
    )
    -- text
    love.graphics.setColor(unpack(self.color.text.inactive))
    love.graphics.print(
      self.text,
      self.x + (self.w / 2) - (self.font:getWidth(self.text) / 2),
      self.y + (self.h / 2) - (self.font:getHeight(self.text) / 2)
    )
    love.graphics.setColor(unpack(dflt.ext_color))
  end
  self.draws.active = self.draws.active or function(self)
    -- box
    love.graphics.setColor(unpack(self.color.active))
    love.graphics.rectangle(
      self.mode.active,
      self.x, self.y,
      self.w, self.h
    )
    -- text
    love.graphics.setColor(unpack(self.color.text.active))
    love.graphics.print(
      self.text,
      self.x + (self.w / 2) - (self.font:getWidth(self.text) / 2),
      self.y + (self.h / 2) - (self.font:getHeight(self.text) / 2)
    )
    love.graphics.setColor(unpack(dflt.ext_color))
  end

  self._draw = self.draws.inactive
  self.col_type = "rect"
end

function _.Button:update(dt)
  local touches = love.touch.getTouches()
  local mouseX, mouseY = love.mouse.getPosition()
  if touches[1] then
    local tch = function()
      for i, id in ipairs(touches) do
        local tx, ty = love.touch.getPosition(id)
        if col[self.col_type]({ x = tx, y = ty },self) then
          self._draw = self.draws.active
          if self.action.hover then self.action.hover(self) end
          return
        end

      end
      self._draw = self.draws.inactive
      if self.action.out then self.action.out(self) end
    end
    tch()
  else
    if col[self.col_type]({ x = mouseX, y = mouseY }, self) then
    else
      self._draw = self.draws.inactive
      if self.action.out then self.action.out(self) end
    end
  end
end

function _.Button:mousereleased(x, y, button, istouch, presses)
  if istouch then return end
  if col[self.col_type]({ x = x, y = y }, self) then
    if self.action.released then self.action.released(self) end
  end
end

function _.Button:mousemoved(x, y, dx, dy, istouch)
  if istouch then return end

  if col[self.col_type]({ x = x, y = y }, self) then
    self._draw = self.draws.active
    if self.action.hover then self.action.hover(self) end
    return
  else
    self._draw = self.draws.inactive
    if self.action.out then self.action.out(self) end
  end
end

function _.Button:touchpressed(id, x, y, dx, dy, pressure)
  if col[self.col_type]({ x = x, y = y }, self) then
    if self.action.pressed then self.action.pressed(self) end
  end
end
function _.Button:touchreleased(id, x, y, dx, dy, pressure)
  if col[self.col_type]({ x = x, y = y }, self) then
    if self.action.released then self.action.released(self) end
    self._draw = self.draws.inactive
  end
end

return _
