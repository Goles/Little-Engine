-- Set the package path to the App Directory.
package.path = fileRelativePath("init.lua") .. "/?.lua;"

-- require "base_functions"
require "base_functions"

-- Execute the main.
dofile(filePath("main.lua"))
