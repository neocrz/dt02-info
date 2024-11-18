
local Base = {}
Base.Point    = Classic:extend()

local _t = {}
_t.r, _t.g, _t.b, _t.a = love.graphics.getColor()

local dflt = {
  color = {1,1,1,1};
  ext_color = { _t.r, _t.g, _t.b, _t.a };
  font = love.graphics.getFont();
}


function Base.Point:new(_)
  local t = _ or {}
  self.x = t.x or 0
  self.y = t.y or 0
  self.mode = t.mode or "line"
end

Base.Rect = Base.Point:extend()

function Base.Rect:new(_)
  local t = _ or {}
  Base.Rect.super.new(self, t)
  self.w = t.w or 0
  self.h = t.h or 0
end

Base.Circ = Base.Point:extend()
function Base.Circ:new(_)
  local t = _ or {}
  Base.Circ.super.new(self, t)
  self.r = t.r or 0
end

function Base.Rect:draw()
  love.graphics.rectangle(self.mode, self.x, self.y, self.w, self.h)
end

Base.Text = Base.Rect:extend()
function Base.Text:new(_)
  local t = _ or {}
  Base.Text.super.new(self, t)
  self.text = t.text or ""
  self.color = t.color or dflt.color
  self.font = t.font or dflt.font
end

function Base.Text:draw()
  love.graphics.setColor(unpack(self.color)) ---@diagnostic disable-line
  love.graphics.rectangle(
    self.mode,
    self.x, self.y,
    self.w, self.h
  )
  love.graphics.print(
    self.text,
    self.x + (self.w / 2) - (self.font:getWidth(self.text) / 2),
    self.y + (self.h / 2) - (self.font:getHeight(self.text) / 2)
  )
  love.graphics.setColor(unpack(dflt.ext_color)) ---@diagnostic disable-line

end

return Base
