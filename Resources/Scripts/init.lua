print("---Lua is available---")

-- Create some vectors
someIntVector = int_vector()
someFloatVector = float_vector()

someIntVector:push_back(44)
someIntVector:push_back(33)
someIntVector:push_back(21)
someIntVector:push_back(40)

someFloatVector:push_back(3.0)
someFloatVector:push_back(3.14)
someFloatVector:push_back(9999.0)

--- Construct a Scene ---

-- Create a GameEntity
someAnimatedSprite = gecAnimatedSprite()
coolDude = GameEntity()
coolDude:setPosition(160.0, 130.0)

-- Create a Scene
aScene = Scene()
aScene.sceneId = "CoolScene"		
aScene:addEntity(coolDude)	-- Add a coolDude to the scene.

-- Push aScene to the Global SceneManager
SceneManager.getInstance():addScene(aScene)

