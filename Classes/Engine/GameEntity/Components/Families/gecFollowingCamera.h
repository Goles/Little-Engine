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
#include "OpenGLCommon.h"
#include "LuaRegisterManager.h"

class gecFollowingCamera : public ICompCamera
{
public:
	//Abstract ICompCamera Implementation
	virtual void update(float delta);
	virtual void restore();
	virtual void locate();			
	gecFollowingCamera() :	m_eye_x(0.0f),
							m_eye_y(0.0f),
							m_eye_z(1.0f),
							m_center_x(0.0f),
							m_center_y(0.0f),
							m_center_z(0.0f),
							m_up_x(0.0f),
							m_up_y(1.0f),
							m_up_z(0.0f),
							m_dirty(true),
							m_follow_x(true),
							m_follow_y(true){}
		
	//GEComponent Implementation
	virtual const gec_id_type &componentID() const { return m_id; }
	
	//Setters & Getters
	bool getDirty() { return m_dirty; }	
	float getZEye(){ return FLT_EPSILON; }
	bool getFollowX() { return m_follow_x; }
	void setFollowX(bool doesFollow) { m_follow_x = doesFollow; }
	bool getFollowY() { return m_follow_y; }
	void setFollowY(bool doesFollow) { m_follow_y = doesFollow; }
	
	static void registrate()
	{
		luabind::module(LR_MANAGER_STATE) 
		[
		 luabind::class_<gecFollowingCamera, GEComponent>("gecFollowingCamera")
		 .def(luabind::constructor<>())
		 .property("follow_x", &gecFollowingCamera::getFollowX, &gecFollowingCamera::setFollowX)
		 .property("follow_y", &gecFollowingCamera::getFollowY, &gecFollowingCamera::setFollowY)
		 ];
	}
	
private:
	static std::string m_id;
	int	 m_eye_x, m_eye_y, m_eye_z;
	int	 m_center_x, m_center_y, m_center_z;
	int	 m_up_x, m_up_y, m_up_z;
	bool m_dirty;
	bool m_follow_x;
	bool m_follow_y;
};

#endif