
local _classic = require "lib.ext.classic"

Classic = _classic:extend()

-- I have this with the purpose that if some callback is not being
-- used by a object it ref. to this table that in reality
-- is a empty function
local _empty_function = setmetatable({}, {
  __call = function(_, ...) end,
})

local _callbacks = {
  "new", "draw", "update",
  "touchreleased", "touchmoved", "touchpressed",
  "mousefocus", "mousemoved", "mousepressed", "mousereleased",
  "keypressed", "keyreleased", "textinput", "wheelmoved",
}

for _, cb in pairs(_callbacks) do
  Classic[cb] = _empty_function
end

Serialize = require "lib.ext.ser"

require "lib.utils"


CONF = {
    debug = true,
}
if CONF.OS == "Android" or CONF.OS == "iOS" then CONF.mobile=true end




StateManager = require "lib.state_manager"
ObjectHandler = require "lib.obj_handler"
DD = require "lib.dd"(CONF)
PD = require "lib.pd"(CONF)
Gui = require "lib.gui"
