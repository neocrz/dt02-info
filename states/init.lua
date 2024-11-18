local path = (...):match("(.-)[^%.]+$")
local cwd  = (...):gsub('%.init$', '') .. "."

local states = {
    "menu", "tests", "boxes"
}

for k,state in pairs(states) do
    StateManager:addState(state, require(cwd .. state))
end
