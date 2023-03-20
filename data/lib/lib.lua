-- Core API functions implemented in Lua
dofile('data/lib/core/core.lua')

-- Compatibility library for our old Lua API
dofile('data/lib/compat/compat.lua')

-- Location data constants.
dofile('data/lib/locationData/rookgaard.lua')
-- Server config data in lua - can be changed by using commands.
dofile('data/lib/gameConfig.lua') -- GameConfig
dofile('data/lib/spellConfig.lua') -- SpellConfig


dofile('data/lib/debug/functions.lua') -- DEBUG - functions