--[[
	init.lua
	Copyright 2010 Nicolas Goles. All Rights Reserved. 
]]--

-- Set the package path to the App Directory.
package.path = fileRelativePath("init.lua") .. "/?.lua;"

-- Execute the configuration
dofile(filePath("config.lua"))

-- Execute the main.
dofile(filePath("main.lua"))
