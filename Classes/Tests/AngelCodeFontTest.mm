//
//  AngelCodeFontTest.mm
//  GandoEngine
//
//  Created by Nicolas Goles on 6/30/11.
//  Copyright 2011 GandoGames. All rights reserved.
//

#include "unittestpp.h"
#include "AngelCodeParser.h"
#include "AngelCodeChar.h"
#include "AngelCodeFont.h"
#include <iostream>

struct AngelCodeParserMock : public AngelCodeParser
{
public:
    
    virtual ~AngelCodeParserMock() {};
    
    void parseAngelFileContainerMock(const std::string &fileContainer)
    {
        AngelCodeParser::parseAngelFileContainer(fileContainer);
    }
};

struct AngelCodeFontMock : public AngelCodeFont
{
public:
    virtual ~AngelCodeFontMock() {}
    CharMap &charDictionary() { return m_charDictionary; }
};

struct AngelCodeFontFixture {
    
    AngelCodeFontFixture() {        
        parser = new AngelCodeParserMock();
        font = new AngelCodeFontMock();
        
        fileContainer =     "info face=\"Arcade\" size=40 bold=0 italic=0 charset="" unicode=0 stretchH=100 smooth=1 aa=1 padding=0,0,0,0 spacing=1,1 \n \
                            common lineHeight=40 base=26 scaleW=256 scaleH=512 pages=1 packed=0 \n \
                            page id=0 file=\"test1.png\" \n \
                            chars count=94 \n \
                            char id=32   x=0     y=0     width=0     height=0     xoffset=0     yoffset=32    xadvance=20     page=0  chnl=0 \n \
                            char id=124   x=0     y=0     width=5     height=38     xoffset=6     yoffset=1    xadvance=14     page=0  chnl=0 \n \
                            char id=125   x=5     y=0     width=13     height=38     xoffset=2     yoffset=1    xadvance=13     page=0  chnl=0 \n \
                            char id=123   x=18     y=0     width=13     height=38     xoffset=0     yoffset=1    xadvance=13     page=0  chnl=0 \n \
                            char id=106   x=31     y=0     width=13     height=25     xoffset=0     yoffset=5    xadvance=12     page=0  chnl=0 \n \
                            char id=94   x=44     y=0     width=24     height=23     xoffset=2     yoffset=3    xadvance=25     page=0  chnl=0 \n \
                            char id=38   x=68     y=0     width=15     height=20     xoffset=0     yoffset=5    xadvance=16     page=0  chnl=0 \n \
                            char id=35   x=83     y=0     width=21     height=20     xoffset=0     yoffset=5    xadvance=20     page=0  chnl=0 \n \
                            char id=36   x=104     y=0     width=13     height=20     xoffset=0     yoffset=5    xadvance=20     page=0  chnl=0 \n \
                            char id=92   x=117     y=0     width=21     height=20     xoffset=0     yoffset=5    xadvance=20     page=0  chnl=0 \n \
                            char id=64   x=138     y=0     width=21     height=20     xoffset=0     yoffset=5    xadvance=20     page=0  chnl=0 \n \
                            char id=47   x=159     y=0     width=18     height=20     xoffset=0     yoffset=5    xadvance=20     page=0  chnl=0 \n \
                            char id=93   x=177     y=0     width=10     height=20     xoffset=0     yoffset=5    xadvance=12     page=0  chnl=0 \n \
                            char id=91   x=187     y=0     width=10     height=20     xoffset=0     yoffset=5    xadvance=12     page=0  chnl=0 \n \
                            char id=41   x=197     y=0     width=13     height=20     xoffset=0     yoffset=5    xadvance=20     page=0  chnl=0 \n \
                            char id=40   x=210     y=0     width=13     height=20     xoffset=0     yoffset=5    xadvance=20     page=0  chnl=0 \n \
                            char id=63   x=223     y=0     width=18     height=20     xoffset=0     yoffset=5    xadvance=20     page=0  chnl=0 \n \
                            char id=33   x=0     y=38     width=21     height=20     xoffset=0     yoffset=5    xadvance=20     page=0  chnl=0 \n \
                            char id=48   x=21     y=38     width=18     height=20     xoffset=0     yoffset=5    xadvance=18     page=0  chnl=0 \n \
                            char id=57   x=39     y=38     width=21     height=20     xoffset=0     yoffset=5    xadvance=20     page=0  chnl=0 \n \
                            char id=56   x=60     y=38     width=21     height=20     xoffset=0     yoffset=5    xadvance=20     page=0  chnl=0 \n \
                            char id=55   x=81     y=38     width=21     height=20     xoffset=0     yoffset=5    xadvance=20     page=0  chnl=0 \n \
                            char id=54   x=102     y=38     width=21     height=20     xoffset=0     yoffset=5    xadvance=20     page=0  chnl=0 \n \
                            char id=53   x=123     y=38     width=21     height=20     xoffset=0     yoffset=5    xadvance=20     page=0  chnl=0 \n \
                            char id=52   x=144     y=38     width=21     height=20     xoffset=0     yoffset=5    xadvance=20     page=0  chnl=0 \n \
                            char id=51   x=165     y=38     width=21     height=20     xoffset=0     yoffset=5    xadvance=20     page=0  chnl=0 \n \
                            char id=50   x=186     y=38     width=21     height=20     xoffset=0     yoffset=5    xadvance=20     page=0  chnl=0 \n \
                            char id=49   x=207     y=38     width=18     height=20     xoffset=0     yoffset=5    xadvance=18     page=0  chnl=0 \n \
                            char id=121   x=225     y=38     width=21     height=20     xoffset=0     yoffset=10    xadvance=20     page=0  chnl=0 \n \
                            char id=116   x=0     y=58     width=15     height=20     xoffset=0     yoffset=5    xadvance=15     page=0  chnl=0 \n \
                            char id=113   x=15     y=58     width=21     height=20     xoffset=0     yoffset=10    xadvance=20     page=0  chnl=0 \n \
                            char id=112   x=36     y=58     width=21     height=20     xoffset=0     yoffset=10    xadvance=20     page=0  chnl=0 \n \
                            char id=108   x=57     y=58     width=7     height=20     xoffset=0     yoffset=5    xadvance=7     page=0  chnl=0 \n \
                            char id=107   x=64     y=58     width=18     height=20     xoffset=0     yoffset=5    xadvance=20     page=0  chnl=0 \n \
                            char id=105   x=82     y=58     width=7     height=20     xoffset=0     yoffset=5    xadvance=7     page=0  chnl=0 \n \
                            char id=104   x=89     y=58     width=21     height=20     xoffset=0     yoffset=5    xadvance=20     page=0  chnl=0 \n \
                            char id=103   x=110     y=58     width=21     height=20     xoffset=0     yoffset=10    xadvance=20     page=0  chnl=0 \n \
                            char id=102   x=131     y=58     width=15     height=20     xoffset=0     yoffset=5    xadvance=15     page=0  chnl=0 \n \
                            char id=100   x=146     y=58     width=21     height=20     xoffset=0     yoffset=5    xadvance=20     page=0  chnl=0 \n \
                            char id=98   x=167     y=58     width=21     height=20     xoffset=0     yoffset=5    xadvance=20     page=0  chnl=0 \n \
                            char id=90   x=188     y=58     width=21     height=20     xoffset=0     yoffset=5    xadvance=20     page=0  chnl=0 \n \
                            char id=89   x=209     y=58     width=18     height=20     xoffset=0     yoffset=5    xadvance=20     page=0  chnl=0 \n \
                            char id=88   x=227     y=58     width=21     height=20     xoffset=0     yoffset=5    xadvance=20     page=0  chnl=0 \n \
                            char id=87   x=0     y=78     width=21     height=20     xoffset=0     yoffset=5    xadvance=20     page=0  chnl=0 \n \
                            char id=86   x=21     y=78     width=21     height=20     xoffset=0     yoffset=5    xadvance=20     page=0  chnl=0 \n \
                            char id=85   x=42     y=78     width=21     height=20     xoffset=0     yoffset=5    xadvance=20     page=0  chnl=0 \n \
                            char id=84   x=63     y=78     width=18     height=20     xoffset=0     yoffset=5    xadvance=20     page=0  chnl=0 \n \
                            char id=83   x=81     y=78     width=21     height=20     xoffset=0     yoffset=5    xadvance=20     page=0  chnl=0 \n \
                            char id=82   x=102     y=78     width=21     height=20     xoffset=0     yoffset=5    xadvance=20     page=0  chnl=0 \n \
                            char id=81   x=123     y=78     width=21     height=20     xoffset=0     yoffset=5    xadvance=20     page=0  chnl=0 \n \
                            char id=80   x=144     y=78     width=21     height=20     xoffset=0     yoffset=5    xadvance=20     page=0  chnl=0 \n \
                            char id=79   x=165     y=78     width=21     height=20     xoffset=0     yoffset=5    xadvance=20     page=0  chnl=0 \n \
                            char id=78   x=186     y=78     width=21     height=20     xoffset=0     yoffset=5    xadvance=20     page=0  chnl=0 \n \
                            char id=77   x=207     y=78     width=21     height=20     xoffset=0     yoffset=5    xadvance=20     page=0  chnl=0 \n \
                            char id=76   x=228     y=78     width=21     height=20     xoffset=0     yoffset=5    xadvance=20     page=0  chnl=0 \n \
                            char id=75   x=0     y=98     width=21     height=20     xoffset=0     yoffset=5    xadvance=20     page=0  chnl=0 \n \
                            char id=74   x=21     y=98     width=21     height=20     xoffset=0     yoffset=5    xadvance=20     page=0  chnl=0 \n \
                            char id=73   x=42     y=98     width=18     height=20     xoffset=0     yoffset=5    xadvance=20     page=0  chnl=0 \n \
                            char id=72   x=60     y=98     width=21     height=20     xoffset=0     yoffset=5    xadvance=20     page=0  chnl=0 \n \
                            char id=71   x=81     y=98     width=21     height=20     xoffset=0     yoffset=5    xadvance=20     page=0  chnl=0 \n \
                            char id=70   x=102     y=98     width=21     height=20     xoffset=0     yoffset=5    xadvance=20     page=0  chnl=0 \n \
                            char id=69   x=123     y=98     width=21     height=20     xoffset=0     yoffset=5    xadvance=20     page=0  chnl=0 \n \
                            char id=68   x=144     y=98     width=21     height=20     xoffset=0     yoffset=5    xadvance=20     page=0  chnl=0 \n \
                            char id=67   x=165     y=98     width=21     height=20     xoffset=0     yoffset=5    xadvance=20     page=0  chnl=0 \n \
                            char id=66   x=186     y=98     width=21     height=20     xoffset=0     yoffset=5    xadvance=20     page=0  chnl=0 \n \
                            char id=65   x=207     y=98     width=20     height=20     xoffset=0     yoffset=5    xadvance=20     page=0  chnl=0 \n \
                            char id=59   x=227     y=98     width=7     height=18     xoffset=0     yoffset=7    xadvance=7     page=0  chnl=0 \n \
                            char id=43   x=234     y=98     width=18     height=15     xoffset=0     yoffset=7    xadvance=18     page=0  chnl=0 \n \
                            char id=37   x=0     y=118     width=18     height=15     xoffset=0     yoffset=7    xadvance=20     page=0  chnl=0 \n \
                            char id=62   x=18     y=118     width=13     height=15     xoffset=0     yoffset=7    xadvance=20     page=0  chnl=0 \n \
                            char id=60   x=31     y=118     width=13     height=15     xoffset=0     yoffset=7    xadvance=20     page=0  chnl=0 \n \
                            char id=58   x=44     y=118     width=7     height=15     xoffset=0     yoffset=7    xadvance=7     page=0  chnl=0 \n \
                            char id=122   x=51     y=118     width=21     height=15     xoffset=0     yoffset=10    xadvance=20     page=0  chnl=0 \n \
                            char id=120   x=72     y=118     width=21     height=15     xoffset=0     yoffset=10    xadvance=20     page=0  chnl=0 \n \
                            char id=119   x=93     y=118     width=21     height=15     xoffset=0     yoffset=10    xadvance=20     page=0  chnl=0 \n \
                            char id=118   x=114     y=118     width=21     height=15     xoffset=0     yoffset=10    xadvance=20     page=0  chnl=0 \n \
                            char id=117   x=135     y=118     width=21     height=15     xoffset=0     yoffset=10    xadvance=20     page=0  chnl=0 \n \
                            char id=115   x=156     y=118     width=21     height=15     xoffset=0     yoffset=10    xadvance=20     page=0  chnl=0 \n \
                            char id=114   x=177     y=118     width=15     height=15     xoffset=0     yoffset=10    xadvance=15     page=0  chnl=0 \n \
                            char id=111   x=192     y=118     width=21     height=15     xoffset=0     yoffset=10    xadvance=20     page=0  chnl=0 \n \
                            char id=110   x=213     y=118     width=18     height=15     xoffset=0     yoffset=10    xadvance=18     page=0  chnl=0 \n \
                            char id=109   x=231     y=118     width=21     height=15     xoffset=0     yoffset=10    xadvance=20     page=0  chnl=0 \n \
                            char id=101   x=0     y=133     width=21     height=15     xoffset=0     yoffset=10    xadvance=20     page=0  chnl=0 \n \
                            char id=99   x=21     y=133     width=21     height=15     xoffset=0     yoffset=10    xadvance=20     page=0  chnl=0 \n \
                            char id=97   x=42     y=133     width=21     height=15     xoffset=0     yoffset=10    xadvance=20     page=0  chnl=0 \n \
                            char id=42   x=63     y=133     width=11     height=9     xoffset=2     yoffset=10    xadvance=20     page=0  chnl=0 \n \
                            char id=61   x=74     y=133     width=15     height=9     xoffset=0     yoffset=10    xadvance=15     page=0  chnl=0 \n \
                            char id=44   x=89     y=133     width=11     height=9     xoffset=2     yoffset=21    xadvance=12     page=0  chnl=0 \n \
                            char id=39   x=100     y=133     width=7     height=9     xoffset=0     yoffset=5    xadvance=13     page=0  chnl=0 \n \
                            char id=34   x=107     y=133     width=15     height=9     xoffset=0     yoffset=5    xadvance=20     page=0  chnl=0 \n \
                            char id=126   x=122     y=133     width=24     height=8     xoffset=2     yoffset=17    xadvance=25     page=0  chnl=0 \n \
                            char id=96   x=146     y=133     width=12     height=8     xoffset=7     yoffset=0    xadvance=24     page=0  chnl=0 \n \
                            char id=46   x=158     y=133     width=8     height=6     xoffset=5     yoffset=21    xadvance=12     page=0  chnl=0 \n \
                            char id=95   x=166     y=133     width=22     height=5     xoffset=0     yoffset=35    xadvance=20     page=0  chnl=0 \n \
                            char id=45   x=188     y=133     width=15     height=4     xoffset=0     yoffset=13    xadvance=15     page=0  chnl=0 \n";

    }
    
    ~AngelCodeFontFixture() {
        delete parser;
        delete font;
    }
    
    typedef std::map<int, gg::font::AngelCodeChar *> CharMap;
    
    AngelCodeParserMock *parser;
    AngelCodeFontMock *font;
    const char * fileContainer;
};



TEST_FIXTURE(AngelCodeFontFixture, NumberOfCharLoaded)
{
    const int MAP_SIZE = 95;
    const int KEY_TO_FETCH = 122;
    
    //Init Parser
    AngelCodeParserMock parser;
    parser.parseAngelFileContainerMock(fileContainer);
    
    //Load Char Data
    std::vector<std::vector<int> > charLines = parser.charLines();
    std::vector<std::vector<int> >::iterator it = charLines.begin();
    
    //Create all the fonts.
    for (; it != charLines.end(); ++it) 
    {
        gg::font::AngelCodeChar *aChar = new gg::font::AngelCodeChar;      
        gg::font::fillCharData(aChar, *it);
        
        //Insert into map
        CharMap::iterator lb = font->charDictionary().lower_bound(aChar->m_id);
        font->charDictionary().insert(lb, CharMap::value_type(aChar->m_id, aChar));

    }
 
    //Vector Size
    CHECK_EQUAL(MAP_SIZE, font->charDictionary().size());
    
    CharMap::iterator lb = font->charDictionary().lower_bound(KEY_TO_FETCH);
    
    //Just be sure the map is properly made.
    CHECK_EQUAL(lb->second->m_id, KEY_TO_FETCH);
    
    gg::font::AngelCodeChar *aChar = lb->second;
    
    //Last Char Element Values.
    CHECK_EQUAL(122, aChar->m_id);
    CHECK_EQUAL(51, aChar->m_coords.origin.x);
    CHECK_EQUAL(118, aChar->m_coords.origin.y);
    CHECK_EQUAL(21, aChar->m_coords.size.width);
    CHECK_EQUAL(15, aChar->m_coords.size.height);
    CHECK_EQUAL(0, aChar->m_xOffset);
    CHECK_EQUAL(10, aChar->m_yOffset);
    CHECK_EQUAL(20, aChar->m_xAdvance);
    
}
