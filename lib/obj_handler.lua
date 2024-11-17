-- obj_handler.lua

local OH = Classic:extend()
function OH:new()
  self.layers = {}
  self.default_layer = 2
  self.layers[1] = { count = 0, objs = {} }
  self.layers[self.default_layer] = { count = 0, objs = {} }
end

function OH:addLayer(n)
  local name = n or nil
  if name then
    self.layers[name] = { count = 0, objs = {} }
  end
end

function OH:rmLayer(n)
  local name = n or nil
  if name and self.layers[name] then
    self.layers[name] = nil
  end
end

function OH:clearLayer(n)
  local name = n or self.default_layer
  if name and self.layers[name] then
    self.layers[name] = nil
    self.layers[name] = { count = 0, objs = {} }
  end
end

function OH:addObj(obj, _layer)
  local layer = _layer or self.default_layer
  if not self.layers[layer] then
    self:addLayer(layer)
  end
  self.layers[layer]["objs"][obj] = obj
  self.layers[layer].count = self.layers[layer].count + 1
  obj._OH_layer = layer
end

function OH:rmObj(obj)
  local layer = obj._OH_layer or self.default_layer
  if self.layers[layer] then
    self.layers[layer]["objs"][obj] = nil
    self.layers[layer].count = self.layers[layer].count - 1
  end
  obj._OH_layer = nil
  return true
end

function OH:mvObj(obj, _newLayer)
  if not self:objExist(obj) then
    return false
  end
  local newLayer = _newLayer or self.default_layer
  self:rmObj(obj)
  self:addObj(obj,newLayer)
end

function OH:objExist(obj)
  local layer = obj._OH_layer or self.default_layer
  if self.layers[layer]["objs"][obj] then
    return true
  end
  return false
end

function OH:update(dt)
  for _, layer in pairs(self.layers) do
    for _, obj in pairs(layer.objs) do
      if obj.update then obj:update(dt) end
    end
  end
end

function OH:draw()
  for _, layer in pairs(self.layers) do
    for _, obj in pairs(layer.objs) do
      if obj.draw then obj:draw() end
    end
  end
end

function OH:touchmoved(...)
  for _, layer in pairs(self.layers) do
    for _, obj in pairs(layer.objs) do
      obj:touchmoved(...)
    end
  end
end

function OH:touchpressed(...)
  for _, layer in pairs(self.layers) do
    for _, obj in pairs(layer.objs) do
      obj:touchpressed(...)
    end
  end
end

function OH:touchreleased(...)
  for _, layer in pairs(self.layers) do
    for _, obj in pairs(layer.objs) do
      obj:touchreleased(...)
    end
  end
end

function OH:mousereleased(...)
  for _, layer in pairs(self.layers) do
    for _, obj in pairs(layer.objs) do
      obj:mousereleased(...)
    end
  end
end

function OH:mousemoved(...)
  for _, layer in pairs(self.layers) do
    for _, obj in pairs(layer.objs) do
      obj:mousemoved(...)
    end
  end
end

function OH:mousepressed(...)
  for _, layer in pairs(self.layers) do
    for _, obj in pairs(layer.objs) do
      obj:mousepressed(...)
    end
  end
end
function OH:textinput(...)
  for _, layer in pairs(self.layers) do
    for _, obj in pairs(layer.objs) do
      obj:textinput(...)
    end
  end
end

function OH:keypressed(...)
  for _, layer in pairs(self.layers) do
    for _, obj in pairs(layer.objs) do
      obj:keypressed(...)
    end
  end
end
function OH:wheelmoved(...)
  for _, layer in pairs(self.layers) do
    for _, obj in pairs(layer.objs) do
      obj:wheelmoved(...)
    end
  end
end


return OH
