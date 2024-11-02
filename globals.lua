Classic = require "lib.ext.classic"
Serialize = require "lib.ext.ser"

require "lib.utils"

CONF = {
    debug = true,
}

DD = require "lib.dd"(CONF)
PD = require "lib.pd"(CONF)
