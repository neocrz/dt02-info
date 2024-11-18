-- boxes.lua
local State = {}
local ObjHandler = ObjectHandler()


function State:enter()
  local box = {}
  box.w = CONF.W-(40*2)
  box.h = CONF.H/3
  box.x = (CONF.W/2) - (box.w/2)
  box.y = (CONF.H/2) - (box.h/2)
  ObjHandler:addObj(Gui.base.Rect{x=box.x,y=box.y,w=box.w,h=box.h})

  local lines = 6
  local cols = 10
  local btns = {}
  btns.w = box.w/(cols*2-1)
  btns.h = box.h/(cols*2-1)
  btns.pad_h = (box.h-(btns.h*lines))/(lines-1)

  btns._x = box.x
  btns._y = box.y
  for i = 1, cols, 1 do
    btns.x = btns._x + (btns.w*2) * (i-1)
    for j = 1, lines, 1 do
      btns.y = btns._y + (btns.h+btns.pad_h) *(j-1)
      local b = Gui.button.rect{x=btns.x, y=btns.y, w=btns.w, h=btns.h}
      ObjHandler:addObj(b)
    end
  end
  -- ObjHandler:addObj(btn)
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
