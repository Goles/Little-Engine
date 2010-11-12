require "base_functions"
require "ComponentBuilder"

function buildEntity(fileName)
	entityTable = dofile(filePath(fileName))
	entity = GameEntity()
	
	for key,value in pairs(entityTable.components)	do
		
		if component_function_table[ key ] ~= nil then
			component = component_function_table[ key ]( value )
			entity:setGEC(component)
		end
		
	end
	
	return entity
end