print("-- Executing Main.lua --")

-- Load a Sprite Sheet.
ss = SpriteSheet()
ss:initWithImageNamed("hitter1_1.png", 80, 80, 0.0, 1.0)

-- Manually define a standing animation vector ( horrible way to do it, but testing )
standingVector = makeIntVector(0,0,1,0,2,3,0)

-- Manually define a standing time vector
timeVector = makeFloatVector(1.0)

-- Create a sprite component
someAnimatedSprite = gecAnimatedSprite()
someAnimatedSprite:addAnimation("stand", standingVector, timeVector, ss)
someAnimatedSprite:setCurrentAnimation("stand")

-- Attach the sprite component to a game entity
coolDude = GameEntity()
coolDude:setPosition(160.0, 130.0)
coolDude:setGEC(someAnimatedSprite);
coolDude:setIsActive(true)

-- Create a Scene
aScene = Scene()
aScene.sceneId = "CoolScene"		
aScene:addEntity(coolDude)	-- Add a coolDude to the scene.

-- Push aScene to the Global SceneManager
pushScene(aScene)
activateScene("CoolScene")
