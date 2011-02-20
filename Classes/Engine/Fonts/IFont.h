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

#include <string>

class IFont
{
public:
	virtual ~IFont() {};
	virtual void render() = 0;
	virtual bool open(const std::string &fontFileName, int size) = 0;
	virtual void setText(const std::string &text) = 0;
};

#endif