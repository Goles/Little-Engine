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
	
	gecFollowingCamera::kDirection leaveDirection =  this->leftDeathZoneFromDirection(CGPointMake(ownerge_p->x, ownerge_p->y));
	
	switch (leaveDirection) {
		case kDirection_East:
			updateCameraX(ownerge_p);
			break;
			
		case kDirection_West:
			updateCameraX(ownerge_p); 
			break;
			
		case kDirection_North:
			updateCameraY(ownerge_p);
			break;
			
		case kDirection_South:
			updateCameraY(ownerge_p);
			break;
			
		default:
			break;
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
		int offset = this->calculateCameraOffset(CGPointMake(this->getOwnerGE()->x, this->getOwnerGE()->y));
		
		if(offset != 0)
			m_cameraOffset = offset;
		
		glMatrixMode(GL_MODELVIEW);
		glLoadIdentity();
		//X AXIS
//		gluLookAt(m_eye_x - cameraOffset, m_eye_y, m_eye_z,
//				  m_center_x - cameraOffset, m_center_y , m_center_z,
//				  m_up_x, m_up_y, m_up_z
//				  );
		
		gluLookAt(m_eye_x, m_eye_y - m_cameraOffset, m_eye_z,
				  m_center_x, m_center_y - m_cameraOffset, m_center_z,
				  m_up_x, m_up_y, m_up_z
				  );
		
		m_dirty = false;
	}
}

void gecFollowingCamera::updateCameraX(const GameEntity *ownerge_p)
{
	if (m_follow_x)
	{
		if (m_eye_x != ownerge_p->x || m_center_x != ownerge_p->x)
		{
			m_eye_x = ownerge_p->x;
			m_center_x = ownerge_p->x;
		}
	}
	
	m_dirty = true;
}

void gecFollowingCamera::updateCameraY(const GameEntity *ownerge_p)
{
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

gecFollowingCamera::kDirection gecFollowingCamera::leftDeathZoneFromDirection(const CGPoint &in_point)
{
	if(!this->deathZoneContainsPoint(in_point))
	{
		kDirection direction = getPointDirection(in_point, CGPointMake(240, 160));
		
		if(direction != kDirection_Null)
			return direction;
	}
	
	return kDirection_Invalid;
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
			if (m_follow_x)
				cameraOffset = SCENE_MANAGER->getWindow().width - m_deathZone.origin.x;

			break;
			
		case kDirection_West:
			if (m_follow_x)
				cameraOffset = m_deathZone.origin.x;

			break;
			
		case kDirection_North:
			if (m_follow_y)
				cameraOffset = SCENE_MANAGER->getWindow().height - m_deathZone.origin.y;

			break;
			
		case kDirection_South:
			if (m_follow_y)
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
	
	//Apply modulus to the offsets in order to calculate correctly (work with positive values) and avoid modf()
	int positive_offset_x = (offset_x < 0) ? (-1 * offset_x) : offset_x;
	int positive_offset_y = (offset_y < 0) ? (-1 * offset_y) : offset_y;	
	
	//Priorize only one direction (N || S || W || E)
	(positive_offset_x > positive_offset_y) ? (offset_y = 0.0) : (offset_x = 0.0);
	
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
