/*
 *  id_generator.h
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 12/18/10.
 *  Copyright 2010 GandoGames. All rights reserved.
 *
 */

#ifndef __ID_GENERATOR_H__
#define __ID_GENERATOR_H__

#include <iostream>

namespace gg
{

	#define ID_GENERATOR IdGenerator::getInstance()
	
	class IdGenerator
	{
	public:
		unsigned generateId()
		{
			++incremental_id;
			
			return incremental_id;
		}
		
		static IdGenerator* getInstance()
		{
			if(instance == NULL)
				instance = new IdGenerator();
			
			return instance;
		}
		
	private:
		unsigned incremental_id;
		static IdGenerator *instance;
	
	protected:
		IdGenerator():incremental_id(0) {}		
	};
}

#endif