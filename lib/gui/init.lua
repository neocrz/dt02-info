local path = (...):match("(.-)[^%.]+$")
local cwd  = (...):gsub('%.init$', '') .. "."
local Gui    = {}



local mod = {"base","box","col","button"}

for _,v in pairs(mod) do
  Gui[v] = require(cwd..v)
end

return Gui
