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
	gecFollowingCamera() :	m_dirty(false), 
							m_eye(Vector3DMake(0.0f, 0.0f, FLT_EPSILON)), 
							m_center(Vector3DMake(0.0f, 0.0f, 0.0f)),
							m_up(Vector3DMake(0.0f, 1.0f, 0.0f)){}
	
	//GEComponent Implementation
	virtual const gec_id_type &componentID() const { return m_id; }
	
	//Setters & Getters
	void setEye(const Vector3D &in_eye) { m_eye = in_eye; m_dirty = true; }
	void setCenter(const Vector3D &in_center){ m_center = in_center; m_dirty = true; }
	void setUp(const Vector3D &in_up){ m_up = in_up; m_dirty = true; }
	bool getDirty() { return m_dirty; }	
	float getZEye(){ return FLT_EPSILON; }
	void setX(int in_x) {
		x = in_x;
	}
	
	void setY(int in_y) {
		y = in_y;
	}
	
	int getY() {
		return y;
	}
	
	int getX(){
		return x;
	}
	
	static void registrate()
	{
		luabind::module(LR_MANAGER_STATE) 
		[
		 luabind::class_<gecFollowingCamera, GEComponent>("gecFollowingCamera")
		 .def(luabind::constructor<>())
		 .property("x", &gecFollowingCamera::getX, &gecFollowingCamera::setX)
		 .property("y", &gecFollowingCamera::getY, &gecFollowingCamera::setY)
		 .def("setEye", &gecFollowingCamera::setEye)
		 .def("setCenter", &gecFollowingCamera::setCenter)
		 .def("setUp", &gecFollowingCamera::setEye)
		 ];
	}
	
private:
	static std::string m_id;		
	bool m_dirty;	
	Vector3D m_eye;
	Vector3D m_center;
	Vector3D m_up;
	int x; 
	int y;
};

#endif