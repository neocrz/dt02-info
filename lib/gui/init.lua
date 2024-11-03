local path = (...):match("(.-)[^%.]+$")
local cwd  = (...):gsub('%.init$', '') .. "."
local _    = {}



local mod = {"base","col", "button"}

for k,v in pairs(mod) do
  _[v] = require(cwd..v)
end

return _