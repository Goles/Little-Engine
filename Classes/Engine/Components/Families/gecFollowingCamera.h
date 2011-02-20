/*
 *  gecFollowingCamera.h
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 1/31/11.
 *  Copyright 2011 GandoGames. All rights reserved.
 *
 */

#ifndef __GEC_FOLLOWING_CAMERA__
#define __GEC_FOLLOWING_CAMERA__

#include "ICompCamera.h"
#include "LuaRegisterManager.h"
#include "SceneManager.h"

class gecFollowingCamera : public ICompCamera
{
public:	
	//Abstract ICompCamera Implementation
	virtual void update(float delta);
	virtual void restore();
	virtual void locate();			
	gecFollowingCamera() :	m_deathZoneX(SCENE_MANAGER->getWindow().width/2),
							m_deathZoneY(SCENE_MANAGER->getWindow().height/2),
							m_cameraView(CGRectMake(0, 0, SCENE_MANAGER->getWindow().width, SCENE_MANAGER->getWindow().height)), 
							m_active(true),
							m_follow_x(true),
							m_follow_y(true){}
		
	//GEComponent Implementation
	virtual const gec_id_type &componentID() const { return m_id; }
	
	//Setters & Getters
	bool getFollowX() const { return m_follow_x; }
	
	void setFollowX(bool doesFollow) { m_follow_x = doesFollow; }
	
	bool getFollowY() const { return m_follow_y; }
	
	void setFollowY(bool doesFollow) { m_follow_y = doesFollow; }
	
	int getDeathZoneX() const { return m_deathZoneX; }
	
	void setDeathZoneX(int x) {
		assert(x >= 0);
		m_deathZoneX = x;
	}
	
	int getDeathZoneY() const { return m_deathZoneY; }
	
	void setDeathZoneY(int y) {
		assert(y >= 0);
		m_deathZoneY = y;
	}
	
	bool getActive() { return m_active; }
	void setActive(bool active) { m_active = active; }
	
	//Lua binding code
	static void registrate()
	{
		luabind::module(LR_MANAGER_STATE) 
		[
		 luabind::class_<gecFollowingCamera, GEComponent>("gecFollowingCamera")
		 .def(luabind::constructor<>())		
		 .property("follow_x", &gecFollowingCamera::getFollowX, &gecFollowingCamera::setFollowX)
		 .property("follow_y", &gecFollowingCamera::getFollowY, &gecFollowingCamera::setFollowY)
		 .property("death_zone_x", &gecFollowingCamera::getDeathZoneX, &gecFollowingCamera::setDeathZoneX)
		 .property("death_zone_y", &gecFollowingCamera::getDeathZoneY, &gecFollowingCamera::setDeathZoneY)
		 .property("active", &gecFollowingCamera::getActive, &gecFollowingCamera::setActive)
		 ];
	}
	
protected:
	inline void setCameraX(int x) { m_cameraView.origin.x = x; }
	inline void setCameraY(int y){ m_cameraView.origin.y = y; }
	
private:
	static std::string m_id;
	CGRect m_cameraView;
	int	 m_deathZoneX;
	int  m_deathZoneY;
	bool m_active;
	bool m_follow_x;
	bool m_follow_y;
};

#endif