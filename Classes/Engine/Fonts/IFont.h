/*
 *  IFont.h
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 2/19/11.
 *  Copyright 2011 GandoGames. All rights reserved.
 *
 */

#ifndef __I_FONT_H__
#define __I_FONT_H__

#include <iostream>

class IFont
{
	virtual void render() = 0;
	virtual void setSize(int pt) = 0;
	virtual void setText(const std::string &text) = 0;
};

#endif