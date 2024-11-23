-- boxes.lua
local State = {}
local ObjHandler = ObjectHandler()

local digi_selection = {}


local function selected()
  -- digi load logic
  Tprint(digi_selection)
end

local function check_selection()
  if (digi_selection.line and
  digi_selection.row and
  digi_selection.box) then
    selected()
  end
end

local function digi_cliqued(line,row)
  digi_selection.line = line
  digi_selection.row = row
  check_selection()
end

local function box_cliqued(box)
  digi_selection.box = box
end

function State:enter()
  -- Margins
  local cell_box = {}
  cell_box.w = CONF.W-(40*2)
  cell_box.h = cell_box.w * (6/10)
  cell_box.x = (CONF.W/2) - (cell_box.w/2)
  cell_box.y = (CONF.H/2) - (cell_box.h/2)
  ObjHandler:addObj(Gui.base.Rect(cell_box))

  local cell_lines = 6
  local cell_cols = 10
  local cell = {}
  cell.w = cell_box.w/(cell_cols)
  cell.h = cell_box.h/(cell_lines)
  cell._x = cell_box.x
  cell._y = cell_box.y

  for i = 1, cell_lines, 1 do
    cell.y = cell._y + cell.h * (i-1)
    for j = 1, cell_cols, 1 do
      cell.x = cell._x + cell.w * (j-1)
      local digi_cel = Gui.button.rect(Tmerge(cell, {
        action={released = function(self)
          digi_cliqued(i,j)
        end,},
      }))
      digi_cel.text = i..","..j
      ObjHandler:addObj(digi_cel)
    end
  end
  -- boxes
  local box = {}
  box.w = cell.w
  box.h = cell.h
  box._x = cell_box.x
  box.pad = 10
  box.y = cell_box.y-(cell.h*2)-box.pad
  box.cols = 6
  box.lines = 2
  local k = 0
  for i = 1, box.lines, 1 do
    box.y = box.y + box.h*(i-1)
    for j = 1, box.cols, 1 do
      k = k + 1
      box.x = box._x + box.w * (j-1)
      local b = Gui.button.rect(Tmerge(box, {
        action={
          released = function (self) box_cliqued(self.text) end
        }
      }))
      b.text = k
      ObjHandler:addObj(b)
    end
  end

  local txt = {}
  txt.margins = {x=cell_box.x, w=cell_box.w}
  txt.margins.h = 30
  txt.margins.y = 80
  txt.objs = {margins=Gui.base.Rect(txt.margins)}
  ObjHandler:addObj(txt.objs.margins)

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
