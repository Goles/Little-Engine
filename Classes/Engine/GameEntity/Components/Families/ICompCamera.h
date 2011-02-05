/*
 *  ICompCamera.h
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 1/31/11.
 *  Copyright 2011 GandoGames. All rights reserved.
 *
 */

#ifndef __ICompCamera_H__
#define __ICompCamera_H__

#include "GEComponent.h"

class ICompCamera : public GEComponent
{
public:
	//Abstract interface
	virtual void restore() = 0;
	virtual void locate() = 0;
	virtual ~ICompCamera(){}
	
	//Common implementation
	const std::string &familyID() const { return m_id; }
	
private:
	static std::string m_id;
};

#endif