-- menu_state.lua
local State = {}
local ObjHandler = ObjectHandler()

function State:enter()
  local _btn = {}
  _btn.count = 2
  _btn.h = CONF.H/10
  _btn.pad = _btn.h/2
  _btn.w = CONF.W/2
  _btn.x = CONF.W/2 - _btn.w/2
  _btn.y = CONF.H/2 - (_btn.h*_btn.count + _btn.pad * _btn.count-1)/2
  _btn.text = "BOXES"
  _btn.action = {released = function (self) end}

  local btn_boxes = Gui.button.rect(_btn)

  _btn.y = _btn.y + _btn.h + _btn.pad
  _btn.text = "QUIT"

  _btn.action.released = function(self) love.event.quit() end
  local btn_quit = Gui.button.rect(_btn)

  ObjHandler:addObj(btn_boxes)
  ObjHandler:addObj(btn_quit)
end

function State:update(dt)
  ObjHandler:update(dt)
end

function State:draw()
  ObjHandler:draw()
end

function State:exit()

end

function State:touchmoved(...)
  ObjHandler:touchmoved(...)
end

function State:touchpressed(...)
  ObjHandler:touchpressed(...)
end

function State:touchreleased(...)
  ObjHandler:touchreleased(...)
end

function State:mousereleased(...)
  ObjHandler:mousereleased(...)
end

function State:mousemoved(...)
 ObjHandler:mousemoved(...)
end

function State:mousepressed(...)
  ObjHandler:mousepressed(...)
end
function State:textinput(t)
  ObjHandler:textinput(t)
end
function State:keypressed(key)
  ObjHandler:keypressed(key)
end
function State:wheelmoved(x,y)
  ObjHandler:wheelmoved(x,y)
end

return State
