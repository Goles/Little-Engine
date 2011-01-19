/*
 *  EntityMap.h
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 1/19/11.
 *  Copyright 2011 GandoGames. All rights reserved.
 *
 */

#ifndef __ENTITY_MAP_H__
#define __ENTITY_MAP_H__

#include "LuaRegisterManager.h"

namespace gg 
{
	/** The entity_map is a hash table Stored in the Lua side, entity_map[ uid ] = GameEntity 
		This is used when we want to obtain a reference to a specific GameEntity
	 */
	
	namespace entity_map 
	{
		static inline void addEntity(GameEntity *in_GameEntity)
		{
			luabind::call_function<void>(LR_MANAGER_STATE, "addMapEntity", in_GameEntity);
		}
		
		static inline GameEntity* fetchEntity(const int in_uid)
		{			
			luabind::call_function<void>(LR_MANAGER_STATE, "fetchMapEntity", in_uid);	
		}
		
		static inline void deleteEntity(const int in_uid)
		{			
			luabind::call_function<void>(LR_MANAGER_STATE, "deleteMapEntity", in_uid);	
		}
	}
}

#endif