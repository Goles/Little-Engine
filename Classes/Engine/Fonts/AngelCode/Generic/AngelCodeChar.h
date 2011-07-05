//
//  AngelCodeChar.h
//  GandoEngine
//
//  Created by Nicolas Goles on 6/29/11.
//  Copyright 2011 GandoGames. All rights reserved.
//

#ifndef __GG_ANGEL_CODE_CHAR__
#define __GG_ANGEL_CODE_CHAR__

#include "AngelCodeParser.h"
#include "ConstantsAndMacros.h"

namespace gg { namespace font {
    
#define DEFAULT_FONT_SCALE 1.0f
    
    struct AngelCodeChar 
    {
        GGRect m_coords;
        int m_id;
        int m_xOffset;
        int m_yOffset;
        int m_xAdvance;
        float scale;
    };
        
    static void fillCharData(AngelCodeChar *angelChar, std::vector<int> &char_data) 
    {
        angelChar->m_id = char_data[kAngelChar_id];
        angelChar->m_coords.origin.x = char_data[kAngelChar_x];
        angelChar->m_coords.origin.y = char_data[kAngelChar_y];
        angelChar->m_coords.size.width = char_data[kAngelChar_width];
        angelChar->m_coords.size.height = char_data[kAngelChar_height];
        angelChar->m_xOffset = char_data[kAngelChar_xoffset];
        angelChar->m_yOffset = char_data[kAngelChar_yoffset];
        angelChar->m_xAdvance = char_data[kAngelChar_xadvance];
        angelChar->scale = DEFAULT_FONT_SCALE; 
    }

}} //END namespace gg::font

#endif
