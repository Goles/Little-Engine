//
//  AngelFont.h
//  GandoEngine
//
//  Created by Nicolas Goles on 6/28/11.
//  Copyright 2011 GandoGames. All rights reserved.
//

#ifndef __ANGEL_CODE_FONT_H__
#define __ANGEL_CODE_FONT_H__

#include "IFont.h"
#include "AngelCodeChar.h"
#include <vector>

class Image;
class Quad2;

class AngelCodeFont : public IFont
{
public:
    AngelCodeFont() : scale(1.0f), bitmap(NULL), coords(NULL), vertices(NULL), index(NULL) 
    {
        colourFilter[0] = 1.0f;
        colourFilter[1] = 1.0f;
        colourFilter[2] = 1.0f;
        colourFilter[3] = 1.0f;
    }
    
    virtual ~AngelCodeFont() {}
    virtual void openFont(const std::string &in_fontName, int in_fontSize);
	virtual void render(const std::string &in_text);

protected:
    std::vector<gg::font::AngelCodeChar *> m_fontDescription;
    
private:
	float colourFilter[4];
	unsigned int lineHeight;
	int commonHeight;
	float scale;
    Image *bitmap;
    Quad2 *coords;
    Quad2 *vertices;
    unsigned short *index;
};

#endif
