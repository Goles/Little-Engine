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
#include "OpenGLCommon.h"
#include "GameEntity.h"
#include "SceneManager.h"
#include <iostream>
#include "CompTouchable.h"

std::string gecFollowingCamera::m_id = "gecFollowingCamera";

void gecFollowingCamera::update(float delta)
{
	GameEntity *ownerge_p = this->getOwnerGE();
	
	if(!this->deathZoneContainsPoint(CGPointMake(ownerge_p->x, ownerge_p->y)))
	{		
		if (m_follow_x)
		{
			if (m_eye_x != ownerge_p->x || m_center_x != ownerge_p->x)
			{
				m_eye_x = ownerge_p->x;
				m_center_x = ownerge_p->x;
			}
		}
		
		if (m_follow_y)
		{
			if (m_eye_y != ownerge_p->y || m_center_y != ownerge_p->x)
			{
				m_eye_y = ownerge_p->y;
				m_center_y = ownerge_p->y;
			}
		}
		
		m_dirty = true;	
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
	if (m_dirty)
	{	
		int cameraOffset = this->calculateCameraOffset(CGPointMake(this->getOwnerGE()->x, this->getOwnerGE()->y));
		glMatrixMode(GL_MODELVIEW);
		glLoadIdentity();
		gluLookAt(m_eye_x - cameraOffset, m_eye_y, m_eye_z,
				  m_center_x - cameraOffset, m_center_y , m_center_z,
				  m_up_x, m_up_y, m_up_z
				  );
		
		m_dirty = false;
	}
}

bool gecFollowingCamera::deathZoneContainsPoint(const CGPoint &in_point)
{
	if (CGRectContainsPoint(m_deathZone, in_point)) {
		return true;
	}
	
	return false;
}

int gecFollowingCamera::calculateCameraOffset(CGPoint in_EntityPosition)
{
	gecFollowingCamera::kDirection direction;
	int cameraOffset = 0;
	
	direction = getPointDirection(in_EntityPosition, CGPointMake(SCENE_MANAGER->getWindow().width * 0.5, SCENE_MANAGER->getWindow().height * 0.5));
	
	switch (direction) {
		case kDirection_East:
			cameraOffset = SCENE_MANAGER->getWindow().width - m_deathZone.origin.x;
			break;
			
		case kDirection_West:
			cameraOffset = m_deathZone.origin.x;
			break;
			
		case kDirection_North:
			cameraOffset = SCENE_MANAGER->getWindow().height - m_deathZone.origin.y;			
			break;
			
		case kDirection_South:
			cameraOffset = m_deathZone.origin.y;
			break;
			
		case kDirection_Null:
			cameraOffset = 0;
			break;
			
		default:
			assert(false); // this shouldn't happen
	}
	
	return cameraOffset;
}

gecFollowingCamera::kDirection gecFollowingCamera::getPointDirection(CGPoint point, CGPoint origin)
{
	int offset_x = point.x - origin.x;
	int offset_y = point.y - origin.y;
	
	if(offset_x < 0)
		return kDirection_West;

	else if(offset_x > 0)
		return kDirection_East;
	
	else if(offset_y < 0)
		return kDirection_South;
	
	else if(offset_y > 0)
		return kDirection_North;
	
	return kDirection_Null;
}