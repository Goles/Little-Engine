//
//  AngelFont.cpp
//  GandoEngine
//
//  Created by Nicolas Goles on 6/28/11.
//  Copyright 2011 GandoGames. All rights reserved.
//

#include "AngelCodeFont.h"
#include "AngelCodeParser.h"
#include "Quad2.h"
#include "Image.h"
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

#define MAX_ASCII_CHARS 256


void AngelCodeFont::openFont(const std::string &in_fontFile, int in_fontSize)
{
    //Init Parser
    AngelCodeParser parser;
    parser.parseAngelFile(in_fontFile);
    
    //Load Char Data
    std::vector<std::vector<int> > charLines = parser.charLines();
    std::vector<std::vector<int> >::iterator it = charLines.begin();
    
    for (; it != charLines.end(); ++it) 
    {
        gg::font::AngelCodeChar *aChar = new gg::font::AngelCodeChar;      
        gg::font::fillCharData(aChar, *it);
        
        //Insert into map
        CharMap::iterator lb = m_charDictionary.lower_bound(aChar->m_id);
        m_charDictionary.insert(lb, CharMap::value_type(aChar->m_id, aChar));
    }
    
    //Load Bitmap
    bitmap = new Image();
    bitmap->initWithUIImage([UIImage imageNamed:[NSString stringWithUTF8String:parser.bitMapFileName().c_str()]]);
    
    //Load Common
    commonHeight = parser.commonLine()[kAngelCommon_lineHeight];
    assert(parser.commonLine()[kAngelCommon_scaleW] <= 1024);
    assert(parser.commonLine()[kAngelCommon_scaleH] <= 1024);
    assert(parser.commonLine()[kAngelCommon_pages] == 1);
    
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
	// Reset the number of quads which are going to be drawn
	int currentQuad = 0;
	
	// Enable those states necessary to draw with textures and allow blending
	glEnable(GL_TEXTURE_2D);
    glEnableClientState(GL_VERTEX_ARRAY);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	glEnable(GL_BLEND);
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    
	// Bind to the texture which was generated for the spritesheet image used for this font.  We only
	// need to bind once before the drawing as all characters are on the same texture.
	//glBindTexture(GL_TEXTURE_2D, [[image texture] name]);
    bitmap->bind();
	
	// Loop through all the characters in the text
    
    const char *c_text = text.c_str();
    
	for(int i = 0; i < strlen(c_text); i++) {
		
		// Grab the unicode value of the current character
		
        
        CharMap::iterator lb = m_charDictionary.lower_bound(c_text[i]);
		
        assert(lb != m_charDictionary.end()); //Something went wrong.
        
        gg::font::AngelCodeChar *currentChar = lb->second;
        
        
		// Only render the current character if it is going to be visible otherwise move the variables such as currentQuad and point.x
		// as normal but don't render the character which should save some cycles
		if(point.x > 0 - (currentChar->m_coords.size.width * scale) || 
           point.x < [[UIScreen mainScreen] bounds].size.width || 
           point.y > 0 - (currentChar->m_coords.size.height * scale) || 
           point.y < [[UIScreen mainScreen] bounds].size.height) 
        {

			// Using the current x and y, calculate the correct position of the character using the x and y offsets for each character.
			// This will cause the characters to all sit on the line correctly with tails below the line etc.
			
			/////// NEW CODE ADDED 05/02/10 to correct positioning of characters
			int y = point.y + (commonHeight * currentChar->scale) - (currentChar->m_coords.size.height + currentChar->m_yOffset) * currentChar->scale;
			int x = point.x + currentChar->m_xOffset;
			CGPoint newPoint = CGPointMake(x, y);
            
			/////// OLD CODE 		
			//CGPoint newPoint = CGPointMake(point.x + ([charsArray[charID] xOffset] * [charsArray[charID] scale]), 
			//point.y - ([charsArray[charID] yOffset] + [charsArray[charID] height])* [charsArray[charID] scale]);
			
			// Create a point into the bitmap font spritesheet using the coords read from the control file for this character
			GGPoint pointOffset = CGPointMake(currentChar->m_coords.origin.x, currentChar->m_coords.origin.y);
			
			// Calculate the texture coordinates and quad vertices for the current character
            bitmap->calculateTexCoordsAtOffset(pointOffset, currentChar->m_coords.size.width, currentChar->m_coords.size.height);
            bitmap->calculateVertices(newPoint, currentChar->m_coords.size.width, currentChar->m_coords.size.height, NO);
			
			// Place the calculated texture coordinates and quad vertices into the arrays we will use when drawing out string
            Quad2 *q = new Quad2();
            *q = *(bitmap->getTexCoords());
            
            Quad2 *v = new Quad2();
            *v = *(bitmap->getVertex());
            
            
			m_coords[currentQuad] = *q;
			m_vertex[currentQuad] = *v;
            
			// Increment quad count
			currentQuad++;
		}
        
		// Move the x location along by the amount defined for this character in the control file so the charaters are spaced
		// correctly
		point.x += currentChar->m_xAdvance * scale;
	}
	
	// Now that we have calculated all the quads and textures for the string we are drawing we can draw them all
	glVertexPointer(2, GL_FLOAT, 0, m_vertex);
	glTexCoordPointer(2, GL_FLOAT, 0, m_coords);
    //	glColor4f(colourFilter[0], colourFilter[1], colourFilter[2], colourFilter[3]);
	glDrawElements(GL_TRIANGLES, currentQuad*6, GL_UNSIGNED_SHORT, m_index);
	glColor4f(1.0f, 1.0f, 1.0f, 1.0f);
	glDisable(GL_TEXTURE_2D);
	glDisable(GL_BLEND);
    glDisable(GL_VERTEX_ARRAY);
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);
}


void AngelCodeFont::initVertexArrays()
{
    int totalQuads = m_charDictionary.size();
    
	m_coords = (Quad2 *)malloc( sizeof(m_coords[0]) * totalQuads);
	m_vertex = (Quad2 *)malloc( sizeof(m_vertex[0]) * totalQuads);
	m_index = (unsigned short *) malloc(sizeof(m_index[0]) * totalQuads * 6);
	
	bzero( m_coords, sizeof(m_coords[0]) * totalQuads);
	bzero( m_vertex, sizeof(m_vertex[0]) * totalQuads);
	bzero( m_index, sizeof(m_index[0]) * totalQuads * 6);
	
	for(int i = 0; i < totalQuads; i++) 
    {
		m_index[i * 6 + 0] = i * 4 + 0;
		m_index[i * 6 + 1] = i * 4 + 1;
		m_index[i * 6 + 2] = i * 4 + 2;
		m_index[i * 6 + 5] = i * 4 + 1;
		m_index[i * 6 + 4] = i * 4 + 2;
		m_index[i * 6 + 3] = i * 4 + 3;			
	}	
}