/*
 *  gecFollowingCamera.cpp
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 1/31/11.
 *  Copyright 2011 GandoGames. All rights reserved.
 *
 */

#include "gecFollowingCamera.h"
#include "GameEntity.h"
#include <OpenGLES/ES1/gl.h>
#include <iostream>

std::string gecFollowingCamera::m_id = "gecFollowingCamera";

void gecFollowingCamera::update(float delta)
{
	GameEntity *ownerge_p = this->getOwnerGE();
	
	if(m_follow_x)
	{
		if(m_eye_x != ownerge_p->x || m_center_x != ownerge_p->x)
		{
			m_eye_x = ownerge_p->x;
			m_center_x = ownerge_p->x;
			m_dirty = true;
		}
	}
	
	if(m_follow_y)
	{
		if(m_eye_y != ownerge_p->y || m_center_y != ownerge_p->x)
		{
			m_eye_y = ownerge_p->y;
			m_center_y = ownerge_p->y;
			m_dirty = true;
		}
	}
}

void gecFollowingCamera::restore()
{
	m_eye_x = 0.0f;
	m_eye_y = 0.0f;
	m_eye_z = 1.0f;
	m_center_x = 0.0f;
	m_center_y = 0.0f;
	m_center_z = 0.0f;
	m_up_x = 0.0f;
	m_up_y = 1.0f;
	m_up_z = 0.0f;
	m_dirty = true;
}

void gecFollowingCamera::locate()
{
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
	
	if (m_dirty)
	{
		gluLookAt(m_eye_x - 240, m_eye_y - 160, m_eye_z,
				  m_center_x - 240, m_center_y - 160, m_center_z,
				  m_up_x, m_up_y, m_up_z
				  );
		
		m_dirty = false;
	}	
}
