/*
 *  IFont.h
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 2/19/11.
 *  Copyright 2011 GandoGames. All rights reserved.
 *
 */

#ifndef __I_TEXT_RENDERER_H__
#define __I_TEXT_RENDERER_H__

#include "IFont.h"

class ITextRenderer
{
public:
	virtual ~ITextRenderer() {};
	virtual void render() = 0;
	virtual bool isActive() = 0;
	virtual void setText(const char *text) = 0;
	virtual void setFont(IFont *font) = 0;
	virtual void setPosition(int x, int y) = 0;
};

#endif