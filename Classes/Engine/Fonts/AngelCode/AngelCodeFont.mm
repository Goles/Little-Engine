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
        m_fontDescription.push_back(aChar);
    }

    //Load Bitmap
    bitmap = new Image();
    bitmap->initWithUIImage([UIImage imageNamed:[NSString stringWithUTF8String:parser.bitMapFileName().c_str()]]);
    
    //Load Common
    commonHeight = parser.commonLine()[kAngelCommon_lineHeight];
    assert(parser.commonLine()[kAngelCommon_scaleW] <= 1024);
    assert(parser.commonLine()[kAngelCommon_scaleH] <= 1024);
    assert(parser.commonLine()[kAngelCommon_pages] == 1);
}


void AngelCodeFont::render(const std::string &in_text)
{
    
}
