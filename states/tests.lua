-- menu_state.lua
local State = {}
local ObjHandler = ObjectHandler()

function State:enter()
  local test = Gui.base.Rect{
    x=10, y=10, w=20, h=20
  }

  local txt = Gui.base.Text{
    x=10, y=40, w=20, h=20,
    text="txt"
  }

  local btn = Gui.button.Rect{
    x=10, y=70, w=20, h=20,
    text="btn"
  }
  local a = ObjHandler:addObj(test)
  local b = ObjHandler:addObj(txt)
  local c = ObjHandler:addObj(btn)
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

function State:mousepressed(x, y, button, istouch, presses)
  ObjHandler:mousepressed(x, y, button, istouch, presses)
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
