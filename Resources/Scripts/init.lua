    GameEntity = 
{
 -- Entity Name
 "ZombieFighter",

 -- All the components that make the entity.
 Components = 
 {
  -- Component to define the health of the entity
  health = 
  {
   "compHealth",  -- Component In-Engine Name
   100,    -- total health
   0.1,    -- regeneration rate
  },

  -- Component to define the Animations of the entity
  compAnimation =
  {
   "compAnimatedSprite",

   spritesheet = 
   {
    "spritesheet.gif", -- Spritesheet file name.
    80,     -- Spritesheet frame width.
    80,     -- Spritesheet frame height.
   },

   animations =
   {
    -- Animation name, Animation spritesheet coords, Animation frame duration.
    {"stand", {0,0,1,0,2,0,3,0}, 0.10},
    {"walk", {4,0,5,0,6,0,7,0}, 0.10},
    {"attack",{8,0,9,0,10,0}, 0.08},
   },
  },
 },
}
-- Set the package path to the App Directory.
package.path = fileRelativePath("init.lua") .. "/?.lua;"

-- require "base_functions"
require "base_functions"

-- Execute the main.
dofile(filePath("main.lua"))
