/*
 *  FontManager.mm
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 2/19/11.
 *  Copyright 2011 GandoGames. All rights reserved.
 *
 */

#include "FontManager.h"
#include "AngelCodeFont.h"
#include "AngelCodeTextRenderer.h"
#include "FileUtils.h"

FontManager *FontManager::instance = NULL;

FontManager* FontManager::getInstance()
{
    if(!instance)
        instance = new FontManager();
	
    return instance;
}

ITextRenderer* FontManager::textRenderer(const std::string &fontFile, int fontSize)
{
    ITextRenderer *tr = new AngelCodeTextRenderer();	
	IFont *font = NULL;
    FontMap::iterator fontValue = m_fonts.find(fontFile);
    
    if (fontValue == m_fonts.end()) {        
        font = new AngelCodeFont();
        font->openFont(gg::util::fullCPathFromRelativePath(fontFile.c_str()), fontSize);
        m_fonts[fontFile] = font;
    } else {        
        font = fontValue->second;
    }

	tr->setFont(font);
	m_renderers.push_back(tr);	
	return tr;
}

void FontManager::render()
{
	TextRendererVector::iterator renderer = m_renderers.begin();
    
	for (; renderer != m_renderers.end(); ++renderer) {
		if((*renderer)->isActive())            
            (*renderer)->render();
	}
}

FontManager::~FontManager()
{
	TextRendererVector::iterator renderer = m_renderers.begin();
	FontMap::iterator font = m_fonts.begin();
	
	for (; font != m_fonts.end(); ++font) {
		delete (*font).second;
	}
	
	for (; renderer != m_renderers.end(); ++renderer) {
		delete (*renderer);
	}
	
	delete instance;
}