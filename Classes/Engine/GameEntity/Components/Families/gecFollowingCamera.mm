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
#include <iostream>

std::string gecFollowingCamera::m_id = "gecFollowingCamera";

void gecFollowingCamera::update(float delta)
{
//	glMatrixMode(GL_PROJECTION); 
//	glLoadIdentity();
//	glRotatef(-90.0, 0.0, 0.0, 1.0);
//	std::cout << x << " " << y << std::endl;
//	glOrthof(this->getOwnerGE()->x - 240, 480+this->getOwnerGE()->x - 240, 0, 320, -1, 1);
//	glMatrixMode(GL_MODELVIEW);
	
	glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    gluLookAt(this->getOwnerGE()->x - 240,0,1,
			  this->getOwnerGE()->x-240,0,0,
			  0,1,0);
}

void gecFollowingCamera::restore()
{
	m_eye = Vector3DMake(0.0f, 0.0f, FLT_EPSILON);
	m_center = Vector3DMake(0.0f, 0.0f, 0.0f);
	m_up = Vector3DMake(0.0f, 1.0f, 0.0f);	
	m_dirty = false;
}

void gecFollowingCamera::locate()
{
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
	if( m_dirty )
		gluLookAt(m_eye.x, m_eye.y, m_eye.z,
				  m_center.x, m_center.y, m_center.z,
				  m_up.x, m_up.y, m_up.z
				  );
}
