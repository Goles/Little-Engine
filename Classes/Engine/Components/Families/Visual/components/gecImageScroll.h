/*
 *  gecImageScroll.h
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 1/31/11.
 *  Copyright 2011 GandoGames. All rights reserved.
 *
 */

#ifndef __GEC_IMAGE_SCROLL_H__
#define __GEC_IMAGE_SCROLL_H__

#include "gecVisual.h"
#include "LuaRegisterManager.h"
#include "Texture2D.h"

class gecImageScroll : public gecVisual 
{
public:
	//GEComponent interface
	virtual void update(float delta);
	virtual const gec_id_type &componentID() const { return mGECTypeID; }
	
	//gecVisual interface
	virtual void render () const;

	//gecImageScroll interface
public:
	void initWithFile(const std::string &filename);
	
	static void registrate(void)
	{
		luabind::module(LR_MANAGER_STATE) 
		[
		 luabind::class_<gecImageScroll, GEComponent>("gecImageScroll")
		 .def(luabind::constructor<>())
		 .def("initWithFile", &gecImageScroll::initWithFile)
		 ];
	}
	
private:
	Texture2D *m_texture;
	static gec_id_type mGECTypeID;

};

#endif