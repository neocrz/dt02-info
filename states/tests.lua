-- menu_state.lua
local State = {}
local ObjHandler = ObjectHandler()

function State:enter()
  local btn = Gui.button.Rect{
    text="btn"
  }
  local btn2 = Gui.button.Rect{
    text="btn2"
  }

  local box = Gui.box{
    x = 30, y=100, w=300, h=500
  }

  box:addObj(btn)
  box:addObj(btn2)
  ObjHandler:addObj(box)
end

function State:update(dt)
  ObjHandler:update(dt)
end

function State:draw()
  ObjHandler:draw()
end

function State:exit()

end

function State:touchmoved(id, x, y, dx, dy, pressure)
  ObjHandler:touchmoved(id, x, y, dx, dy, pressure)
end

function State:touchpressed(id, x, y, dx, dy, pressure)
  ObjHandler:touchpressed(id, x, y, dx, dy, pressure)
end

function State:touchreleased(id, x, y, dx, dy, pressure)
  ObjHandler:touchreleased(id, x, y, dx, dy, pressure)
end

function State:mousereleased(x, y, button, istouch, presses)
  ObjHandler:mousereleased(x, y, button, istouch, presses)
end

function State:mousemoved(x, y, dx, dy, istouch)
  ObjHandler:mousemoved(x, y, dx, dy, istouch)
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

function State:wheelmoved(x, y)
  ObjHandler:wheelmoved(x, y)
end

return State
