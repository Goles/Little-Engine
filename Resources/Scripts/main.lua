require "EntityBuilder"

-- Create a Scene
aScene = Scene()
entities = {}

-- Create entities
for i=1,7 do
	entities[i] = buildEntity("entity.lua") 
	entities[i]:setPosition(0.0 + 60 * i, 130.0)
	entities[i]:setIsActive(true)
	aScene:addEntity(entities[i])	-- Add a coolDude to the scene.	
end

-- Push aScene to the Global SceneManager
aScene.sceneId = "CoolScene"
pushScene(aScene)
activateScene("CoolScene")