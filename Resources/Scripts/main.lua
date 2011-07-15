require "SceneBuilder"
require "event_manager"

-- BUILD A SCENE
scene = buildScene("world1.lua")

-- PUSH SCENE TO SCENE MAP
pushScene(scene)

-- ACTIVATE A SCENE
activateScene(scene)

-- BROADCAST THAT THIS SCENE WAS BUILT
broadcast("E_SCENE_ACTIVE", scene.label)
