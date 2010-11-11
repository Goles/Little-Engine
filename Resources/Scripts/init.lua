-- Set the package path to the App Directory.
package.path = fileRelativePath("init.lua") .. "/?.lua;"

-- Execute the main.
dofile(filePath("main.lua"))
