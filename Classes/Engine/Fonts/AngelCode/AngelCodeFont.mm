//
//  AngelFont.cpp
//  GandoEngine
//
//  Created by Nicolas Goles on 6/28/11.
//  Copyright 2011 GandoGames. All rights reserved.
//

#include "AngelCodeFont.h"
#include "AngelCodeParser.h"
#include "SharedTextureManager.h"
#include "Quad2.h"
#include "Image.h"

#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#include <vector>

#define MAX_ASCII_CHARS 256

void AngelCodeFont::openFont(const std::string &in_fontFile, int in_fontSize)
{
    //Init Parser
    AngelCodeParser parser;
    parser.parseAngelFile(in_fontFile);
   
    //Set global Scale
    scale = in_fontSize;
    
    //Load Char Data
    std::vector<std::vector<int> > charLines = parser.charLines();
    std::vector<std::vector<int> >::iterator it = charLines.begin();
    
    for (; it != charLines.end(); ++it) {
        gg::font::AngelCodeChar *aChar = new gg::font::AngelCodeChar;
        gg::font::fillCharData(aChar, *it);
        aChar->scale = in_fontSize;
        
        //Insert Char into map
        CharMap::iterator lb = m_charDictionary.lower_bound(aChar->m_id);
        m_charDictionary.insert(lb, CharMap::value_type(aChar->m_id, aChar));
    }
    
    //Load Common
    commonHeight = parser.commonLine()[kAngelCommon_lineHeight];
    assert(parser.commonLine()[kAngelCommon_scaleW] <= 1024);
    assert(parser.commonLine()[kAngelCommon_scaleH] <= 1024);
    assert(parser.commonLine()[kAngelCommon_pages] == 1);
    
    //Init Bitmap
    bitmap = new Image();
    bitmap->initWithTextureFile(parser.bitMapFileName().c_str());
    bitmap->setScale(ggp(in_fontSize, in_fontSize));

    //Init Vertex Arrays for Rendering
    this->initVertexArrays();
}

void AngelCodeFont::render(const std::string &in_text)
{
    GGPoint a = CGPointMake(0.0f, 0.0f);
    drawString(in_text, a);
}

void AngelCodeFont::drawString(const std::string &text, GGPoint &point)
{
	int currentQuad = 0;
	glEnable(GL_TEXTURE_2D);
    glEnableClientState(GL_VERTEX_ARRAY);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	glEnable(GL_BLEND);
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    
    TEXTURE_MANAGER->bindTexture(bitmap->getTextureName());
	
    const char *c_text = text.c_str();
    
	for (int i = 0; i < strlen(c_text); i++) {
		// Grab the ASCII code of the current character
        CharMap::iterator lb = m_charDictionary.lower_bound(c_text[i]);
		
        assert(lb != m_charDictionary.end()); //Something went wrong.
        
        gg::font::AngelCodeChar *currentChar = lb->second;
        
		// Only render the current character if it is going to be visible otherwise move the variables such as currentQuad and point.x
		// as normal but don't render the character which should save some cycles
		if (point.x > 0 - (currentChar->m_coords.size.width * scale) 
           || point.x < [[UIScreen mainScreen] bounds].size.width 
           || point.y > 0 - (currentChar->m_coords.size.height * scale) 
           || point.y < [[UIScreen mainScreen] bounds].size.height) 
        {			
			//correct positioning of characters
			int y = point.y + (commonHeight * currentChar->scale) - (currentChar->m_coords.size.height + currentChar->m_yOffset) * currentChar->scale;
			int x = point.x + currentChar->m_xOffset;
			CGPoint newPoint = CGPointMake(x, y);
            
			// Create a point into the bitmap font spritesheet using the coords read from the control file for this character
			GGPoint pointOffset = CGPointMake(currentChar->m_coords.origin.x, currentChar->m_coords.origin.y);
			
			// Calculate the texture coordinates and quad vertices for the current character
            bitmap->calculateTexCoordsAtOffset(pointOffset, currentChar->m_coords.size.width, currentChar->m_coords.size.height);
            bitmap->calculateVertices(newPoint, currentChar->m_coords.size.width, currentChar->m_coords.size.height, NO);
			
			// Place the calculated texture coordinates and quad vertices into the arrays we will use when drawing out string  
			m_coords[currentQuad] = *(bitmap->getTexCoords());
			m_vertex[currentQuad] = *(bitmap->getVertex());
            
			// Increment quad count
			currentQuad++;
		}
        
		// Move the x location along by the amount defined for this character in the control file so the charaters are spaced correctly.
		point.x += currentChar->m_xAdvance * scale;
	}
	
	// Now that we have calculated all the quads and textures for the string we are drawing we can draw them all
	glVertexPointer(2, GL_FLOAT, 0, m_vertex);
	glTexCoordPointer(2, GL_FLOAT, 0, m_coords);
    glColor4f(colorFilter[0], colorFilter[1], colorFilter[2], colorFilter[3]);
	glDrawElements(GL_TRIANGLES, currentQuad * 6, GL_UNSIGNED_SHORT, m_index);
	glDisable(GL_TEXTURE_2D);
	glDisable(GL_BLEND);
    glDisable(GL_VERTEX_ARRAY);
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);
}

void AngelCodeFont::initVertexArrays()
{
    int totalQuads = m_charDictionary.size();
    
	m_coords = (Quad2 *) malloc(sizeof(m_coords[0]) * totalQuads);
	m_vertex = (Quad2 *) malloc(sizeof(m_vertex[0]) * totalQuads);
	m_index = (unsigned short *) malloc(sizeof(m_index[0]) * totalQuads * 6);	
	
    bzero(m_coords, sizeof(m_coords[0]) * totalQuads);
	bzero(m_vertex, sizeof(m_vertex[0]) * totalQuads);
	bzero(m_index, sizeof(m_index[0]) * totalQuads * 6);
	
	for (int i = 0; i < totalQuads; i++) {
		m_index[i * 6 + 0] = i * 4 + 0;
		m_index[i * 6 + 1] = i * 4 + 1;
		m_index[i * 6 + 2] = i * 4 + 2;
		m_index[i * 6 + 5] = i * 4 + 1;
		m_index[i * 6 + 4] = i * 4 + 2;
		m_index[i * 6 + 3] = i * 4 + 3;			
	}	
}

AngelCodeFont::~AngelCodeFont()
{
    free(m_coords);
    free(m_vertex);
    free(m_index);
    
    CharMap::iterator it = m_charDictionary.begin();
    for (; it != m_charDictionary.end(); ++it) {
        delete it->second;
        m_charDictionary.erase(it);
    }
}