GameEntity = 
{
 -- All the components that make the entity.
 Components = 
 {
  -- Component to define the health of the entity
  health = {"compHealthUndead",100,0.1,},

  -- Component to define the Animations of the entity
  compAnimation = 
  {
    "compAnimatedSprite",
    spritesheet = {"spritesheet.gif", 80, 80},
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
