Classic = require "lib.ext.classic"
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