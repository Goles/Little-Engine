/*
 *  gecFollowingCamera.cpp
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 1/31/11.
 *  Copyright 2011 GandoGames. All rights reserved.
 *
 */

#include "gecFollowingCamera.h"
#include <OpenGLES/ES1/gl.h>
#include <iostream>
#include "OpenGLCommon.h"

std::string gecFollowingCamera::m_id = "gecFollowingCamera";

void gecFollowingCamera::update(float delta)
{
	GameEntity *ownerge_p = this->getOwnerGE();
	
	if(m_follow_x)
	{
		int owner_x = ownerge_p->x;
		
		//Check if we scroll to the right
		if((owner_x - m_cameraView.origin.x) >  (m_cameraView.size.width - m_deathZoneX))
			this->setCameraX(m_cameraView.origin.x + (owner_x - m_cameraView.origin.x) - (m_cameraView.size.width - m_deathZoneX));
		
		//Check if we scroll to the left
		if((owner_x - m_cameraView.origin.x) < m_deathZoneX)
			this->setCameraX(m_cameraView.origin.x + (owner_x - m_cameraView.origin.x) - m_deathZoneX);		
	}
	
	if(m_follow_y)
	{
		int owner_y = ownerge_p->y;		
		
		//Check if we scroll up
		if((owner_y - m_cameraView.origin.y) > (m_cameraView.size.height - m_deathZoneY))
			this->setCameraY(m_cameraView.origin.y + (owner_y - m_cameraView.origin.y) - (m_cameraView.size.height - m_deathZoneY));
		
		//Check if we scroll down
		if((owner_y - m_cameraView.origin.y) < m_deathZoneY)
			this->setCameraY(m_cameraView.origin.y + (owner_y - m_cameraView.origin.y) - m_deathZoneY);		
	}
}

void gecFollowingCamera::restore()
{
//	m_eye_x = 0.0f;
//	m_eye_y = 0.0f;
//	m_eye_z = 1.0f;
//	m_center_x = 0.0f;
//	m_center_y = 0.0f;
//	m_center_z = 0.0f;
//	m_up_x = 0.0f;
//	m_up_y = 1.0f;
//	m_up_z = 0.0f;
//	m_dirty = true;
}

void gecFollowingCamera::locate()
{
	if(m_active)
	{
		glMatrixMode(GL_MODELVIEW);
		glLoadIdentity();
		
		gluLookAt(m_cameraView.origin.x, m_cameraView.origin.y, 1.0f,
				  m_cameraView.origin.x, m_cameraView.origin.y, 0.0f,
				  0.0f, 1.0f, 0.0f
				  );
	}
}
