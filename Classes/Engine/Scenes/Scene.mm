//
//  SceneManager.mm
//  Particles_2
//
//  Created by Nicolas Goles on 11/16/09.
//  Copyright 2009 Nicolas Goles. All rights reserved.
//

#include "Scene.h"
#include "gecVisual.h"
#include "ICompCamera.h"
#include "GandoBox2D.h"
#include "FontManager.h"
#include <OpenGLES/ES1/gl.h>

Scene::Scene() : m_label("unnamed_scene"), m_zOrder(-1), m_position(CGPointZero)
{
	//Init some stuff here.
}

void Scene::update(float delta)
{		
	EntityVector::iterator e_it;
	SceneVector::iterator s_it;
	
	//Update our Entities
	/*for(e_it = m_entities.begin(); e_it < m_entities.end(); ++e_it)
	{
		if((*e_it) != NULL)
			if((*e_it)->isActive)
			{
				(*e_it)->update(delta);
			}
	}
	
	//update our Children Scenes
	for(s_it = m_scenes.begin(); s_it < m_scenes.end(); ++s_it)
	{
		(*s_it)->update(delta);
	}
     */
}

void Scene::render()
{	
	EntityVector::const_iterator e_it;
	SceneVector::const_iterator s_it;
    
	glPushMatrix();
	glLoadIdentity();
    
	//Apply Camera transformations
	for (e_it = m_entities.begin(); e_it < m_entities.end(); ++e_it)
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
	for (e_it = m_entities.begin(); e_it < m_entities.end(); ++e_it)
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
	//In debug mode we call GBOX_2D debug render only once if we even detect a collider in the scene.
	//This could be improved but it's simple and will hold for the moment.
	//@remarks: This will only allow correct debugging if only if ONE scene contains colliders.
	//ISSUE 159
	for(EntityVector::iterator entity = m_entities.begin(); entity != m_entities.end(); ++entity)
	{
		if((*entity)->getGEC("CompCollisionable") != NULL)
		{	
			GBOX_2D->debugRender();
			break;
		}		
	}
#endif
	
	//Render our Child Scenes
	for (s_it = m_scenes.begin(); s_it < m_scenes.end(); ++s_it)
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
	m_entities.push_back(inGameEntity);
	
	//return m_entities.back();	
	return inGameEntity;
}

void Scene::removeGameEntity(const GameEntity *inGameEntity)
{
	EntityVector::iterator it = m_entities.begin();

	while (it != m_entities.end())
	{
		if (*it == inGameEntity) {
			m_entities.erase(it);
		}		
		++it;
	}
}

void Scene::sortEntitiesX()
{
	std::sort(m_entities.begin(), m_entities.end(), GameEntity::compareByX());	

	if(m_scenes.size() == 0)
		return;
	
	SceneVector::iterator s_it;
	
	for(s_it = m_scenes.begin(); s_it < m_scenes.end(); ++s_it)
	{
		(*s_it)->sortEntitiesY();
	}
}

void Scene::sortEntitiesY()
{
	std::sort(m_entities.begin(), m_entities.end(), GameEntity::compareByY());
	
	if(m_scenes.size() == 0)
		return;
		
	SceneVector::iterator s_it;
	
	for(s_it = m_scenes.begin(); s_it < m_scenes.end(); ++s_it)
	{
		(*s_it)->sortEntitiesY();
	}		
}

void Scene::addChild(Scene *child)
{
	assert(child->getZOrder() != -1);
	
	m_scenes.push_back(child);
	std::sort(m_scenes.begin(), m_scenes.end(), compareByZOrder());
}

void Scene::removeChild(Scene *child)
{
	// we have to make a remove child function
}

#pragma mark debug
void Scene::debugPrintEntities()
{
	std::cout << "*** DEBUG Print Entity List [ Scene: " << m_label << " ] ***" << std::endl;
	
	if(m_entities.size() == 0)
		std::cout << "EMPTY" << std::endl;
	
	EntityVector::iterator it = m_entities.begin();
	
	int i = 0;
	
	while(it != m_entities.end())
	{
		if(*it)
		{
			std::cout << "\nEntity " << i << " [" << (*it) << "] - " <<"[" << (*it)->getPositionX() << "][" <<(*it)->getPositionY() <<  "]" << std::endl;
			(*it)->debugPrintComponents();
		}
		++it;
		++i;
	}
}

void Scene::debugPrintChildren()
{
	std::cout << "*** DEBUG Print Child List [ Scene: " << m_label << " ] ***" << std::endl;
	
	if(m_scenes.size() == 0)
		std::cout << "EMPTY" << std::endl;
	
	SceneVector::iterator s_it;
	
	for(s_it = m_scenes.begin(); s_it < m_scenes.end(); ++s_it)
	{
		std::cout << (*s_it)->getSceneLabel() << std::endl;
	}
}

#pragma mark destructor
Scene::~Scene()
{
	/*Erase the whole scene entity list on delete.*/
	EntityVector::iterator it = m_entities.begin();
	
	while (it != m_entities.end())
	{
		m_entities.erase(it);
	}
	
	m_entities.clear();
}