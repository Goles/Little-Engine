//
//  SceneManager.mm
//  Particles_2
//
//  Created by Nicolas Goles on 11/16/09.
//  Copyright 2009 Nicolas Goles. All rights reserved.
//

#include "Scene.h"
#include "SharedParticleSystemManager.h"
#include "gecVisual.h"
#include "ICompCamera.h"
#include "GandoBox2D.h"

#include <OpenGLES/ES1/gl.h>


Scene::Scene() : m_label("unnamed_scene"), m_zOrder(-1), m_position(CGPointZero)
{
	//Init some stuff here.
}

void Scene::update(float delta)
{		
	ENTITY_VECTOR::iterator e_it;
	SCENE_VECTOR::iterator s_it;
	
	//Update our Entities
	for(e_it = entityList.begin(); e_it < entityList.end(); ++e_it)
	{
		if((*e_it) != NULL)
			if((*e_it)->isActive)
			{
				(*e_it)->update(delta);
			}
	}
	
	//update our Children Scenes
	for(s_it = m_children.begin(); s_it < m_children.end(); ++s_it)
	{
		(*s_it)->update(delta);
	}
}

void Scene::render()
{	
	ENTITY_VECTOR::const_iterator e_it;
	SCENE_VECTOR::const_iterator s_it;
	
	glPushMatrix();
	
	//Apply Camera transformations
	for (e_it = entityList.begin(); e_it < entityList.end(); ++e_it)
	{
		if((*e_it)->isActive)
		{	
			ICompCamera *camera_p = static_cast<ICompCamera *> ((*e_it)->getGEC(std::string("ICompCamera")));
			
			if(camera_p != NULL)
			{
				camera_p->locate();
			}
		}
	}
	
	//Render our Visual Components
	for (e_it = entityList.begin(); e_it < entityList.end(); ++e_it)
	{
		if((*e_it)->isActive)
		{
			gecVisual *visual_p	 = static_cast<gecVisual *> ((*e_it)->getGEC(std::string("CompVisual")));
			
			if(visual_p != NULL)
			{
				visual_p->render();
			}
		}
	}
	
#ifdef DEBUG
	GBOX_2D->debugRender();
#endif
	
	//Render our Child Scenes
	for (s_it = m_children.begin(); s_it < m_children.end(); ++s_it)
	{
		(*s_it)->render();
	}
	
	glPopMatrix();
}

void Scene::transform()
{
	if(m_position.x != 0 || m_position.y != 0)
	{
		glTranslatef(m_position.x, m_position.y, 0);
	}
}

GameEntity *Scene::addGameEntity(GameEntity *inGameEntity)
{	
	entityList.push_back(inGameEntity);
	
	//return entityList.back();	
	return inGameEntity;
}

void Scene::removeGameEntity(GameEntity *inGameEntity)
{
	ENTITY_VECTOR::iterator it = entityList.begin();

	while (it != entityList.end())
	{
		if (*it == inGameEntity) {
			entityList.erase(it);
		}		
		++it;
	}
}

void Scene::sortEntitiesX()
{
	std::sort(entityList.begin(), entityList.end(), GameEntity::compareByX());	

	if(m_children.size() == 0)
		return;
	
	SCENE_VECTOR::iterator s_it;
	
	for(s_it = m_children.begin(); s_it < m_children.end(); ++s_it)
	{
		(*s_it)->sortEntitiesY();
	}
}

void Scene::sortEntitiesY()
{
	std::sort(entityList.begin(), entityList.end(), GameEntity::compareByY());
	
	if(m_children.size() == 0)
		return;
		
	SCENE_VECTOR::iterator s_it;
	
	for(s_it = m_children.begin(); s_it < m_children.end(); ++s_it)
	{
		(*s_it)->sortEntitiesY();
	}		
}

void Scene::addChild(Scene *child)
{
	assert(child->getZOrder() != -1);
	
	m_children.push_back(child);
	std::sort(m_children.begin(), m_children.end(), compareByZOrder());
}

void Scene::removeChild(Scene *child)
{
	// we have to make a remove child function
}

#pragma mark debug
void Scene::debugPrintEntityList()
{
	std::cout << "*** DEBUG Print Entity List [ Scene: " << m_label << " ] ***" << std::endl;
	
	if(entityList.size() == 0)
		std::cout << "EMPTY" << std::endl;
	
	ENTITY_VECTOR::iterator it = entityList.begin();
	
	int i = 0;
	
	while(it != entityList.end())
	{
		if(*it)
		{
			std::cout << "\nEntity " << i << " [" << (*it) << "] - " <<"[" << (*it)->x << "][" <<(*it)->y <<  "]" << std::endl;
			(*it)->debugPrintComponents();
		}
		++it;
		++i;
	}
}

void Scene::debugPrintChildren()
{
	std::cout << "*** DEBUG Print Child List [ Scene: " << m_label << " ] ***" << std::endl;
	
	if(m_children.size() == 0)
		std::cout << "EMPTY" << std::endl;
	
	SCENE_VECTOR::iterator s_it;
	
	for(s_it = m_children.begin(); s_it < m_children.end(); ++s_it)
	{
		std::cout << (*s_it)->getSceneLabel() << std::endl;
	}
}

#pragma mark destructor
Scene::~Scene()
{
	/*Erase the whole scene entity list on delete.*/
	ENTITY_VECTOR::iterator it = entityList.begin();
	
	while (it != entityList.end())
	{
		entityList.erase(it);
	}
	
	entityList.clear();
}