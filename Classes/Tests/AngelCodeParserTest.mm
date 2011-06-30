//
//  AngelCodeFont.mm
//  GandoEngine
//
//  Created by Nicolas Goles on 6/28/11.
//  Copyright 2011 GandoGames. All rights reserved.
//

#include "unittestpp.h"

#include "IFont.h"
#include "AngelCodeParser.h"
#include <string>
#include <vector>
#include <iostream>

struct AngelCodeParserMock : public AngelCodeParser
{
public:
    
    virtual ~AngelCodeParserMock() {};
    
    void tokenizeCharLineMock(const std::string &line, std::vector<int> &tokenHolder) 
    {
        AngelCodeParser::tokenizeCharLine(line, tokenHolder);
    }
    
    void tokenizeCommonLineMock(const std::string &line, std::vector<int> &tokenHolder)
    {
        AngelCodeParser::tokenizeCommonLine(line, tokenHolder);
    }
    
    void parseAngelFileContainerMock(const std::string &fileContainer)
    {
        AngelCodeParser::parseAngelFileContainer(fileContainer);
    }
};

struct AngelCodeParserFixture {
    
    AngelCodeParserFixture() {        
        parser = new AngelCodeParserMock();
    }
    
    ~AngelCodeParserFixture() {
        delete parser;
    }
    
    AngelCodeParserMock *parser;
    std::vector<int> sampleTokens;
    std::vector<int> outputTokens;
};

TEST_FIXTURE (AngelCodeParserFixture, CommonLineTokenSize)
{    
    std::string testLine("common lineHeight=40 base=26 scaleW=256 scaleH=512 pages=1 packed=0");
    parser->tokenizeCommonLineMock(testLine, outputTokens);
    CHECK_EQUAL (6, outputTokens.size());
}

TEST_FIXTURE (AngelCodeParserFixture, ProcessAngelCodeCommonLine)
{

    sampleTokens.reserve(6);

    std::string testLine("common lineHeight=40 base=26 scaleW=256 scaleH=512 pages=1 packed=0");
    
    sampleTokens[kAngelCommon_lineHeight] = 40;
    sampleTokens[kAngelCommon_base] = 26;
    sampleTokens[kAngelCommon_scaleW] = 256;
    sampleTokens[kAngelCommon_scaleH] = 512;
    sampleTokens[kAngelCommon_pages] = 1;
    sampleTokens[kAngelCommon_packed] = 0;
    
    parser->tokenizeCommonLineMock(testLine, outputTokens);
    
    CHECK_EQUAL (sampleTokens[kAngelCommon_lineHeight], outputTokens[kAngelCommon_lineHeight]);
    CHECK_EQUAL (sampleTokens[kAngelCommon_base], outputTokens[kAngelCommon_base]);
    CHECK_EQUAL (sampleTokens[kAngelCommon_scaleW], outputTokens[kAngelCommon_scaleW]);
    CHECK_EQUAL (sampleTokens[kAngelCommon_scaleH], outputTokens[kAngelCommon_scaleH]);
    CHECK_EQUAL (sampleTokens[kAngelCommon_pages], outputTokens[kAngelCommon_pages]);
    CHECK_EQUAL (sampleTokens[kAngelCommon_packed], outputTokens[kAngelCommon_packed]);
}

TEST_FIXTURE (AngelCodeParserFixture, CharLineTokenSize)
{
    std::string testLine("char id=0   x=-1     y=30     width=4     height=0     xoffset=0     yoffset=1    xadvance=7     page=0  chnl=0 ");
    parser->tokenizeCharLineMock(testLine, outputTokens);    
    CHECK_EQUAL (10, outputTokens.size());
}

TEST_FIXTURE (AngelCodeParserFixture, ProcessAngelCodeCharLine)
{
    std::string testLine("char id=1   x=2     y=3     width=4     height=5     xoffset=6     yoffset=7    xadvance=8     page=9  chnl=0 ");
    
    sampleTokens.reserve(10);
    
    sampleTokens[kAngelChar_id] = 1;
    sampleTokens[kAngelChar_x] = 2;
    sampleTokens[kAngelChar_y] = 3;
    sampleTokens[kAngelChar_width] = 4;
    sampleTokens[kAngelChar_height] = 5;
    sampleTokens[kAngelChar_xoffset] = 6;
    sampleTokens[kAngelChar_yoffset] = 7;
    sampleTokens[kAngelChar_xadvance] = 8;
    sampleTokens[kAngelChar_page] = 9;
    sampleTokens[kAngelChar_chnl] = 0;
    
    parser->tokenizeCharLineMock(testLine, outputTokens);
  
    CHECK_EQUAL (sampleTokens[kAngelChar_id], outputTokens[kAngelChar_id]);
    CHECK_EQUAL (sampleTokens[kAngelChar_x], outputTokens[kAngelChar_x]);
    CHECK_EQUAL (sampleTokens[kAngelChar_y], outputTokens[kAngelChar_y]);
    CHECK_EQUAL (sampleTokens[kAngelChar_width], outputTokens[kAngelChar_width]);
    CHECK_EQUAL (sampleTokens[kAngelChar_height], outputTokens[kAngelChar_height]);
    CHECK_EQUAL (sampleTokens[kAngelChar_xoffset], outputTokens[kAngelChar_xoffset]);
    CHECK_EQUAL (sampleTokens[kAngelChar_yoffset], outputTokens[kAngelChar_yoffset]);  
    CHECK_EQUAL (sampleTokens[kAngelChar_xadvance], outputTokens[kAngelChar_xadvance]);
    CHECK_EQUAL (sampleTokens[kAngelChar_page], outputTokens[kAngelChar_page]);
    CHECK_EQUAL (sampleTokens[kAngelChar_chnl], outputTokens[kAngelChar_chnl]);    
}

TEST ( FileContainerParser ) 
{
    const char * fileContainer =     
                                "info face=\"Arcade\" size=40 bold=0 italic=0 charset="" unicode=0 stretchH=100 smooth=1 aa=1 padding=0,0,0,0 spacing=1,1 \n \
                                common lineHeight=40 base=26 scaleW=256 scaleH=512 pages=1 packed=0 \n \
                                page id=0 file=\"font1.png\" \n \
                                chars count=94 \n \
                                char id=32   x=0     y=0     width=0     height=0     xoffset=0     yoffset=32    xadvance=20     page=0  chnl=0 \n";

    //Init Parser
    AngelCodeParserMock parser;
    parser.parseAngelFileContainerMock(fileContainer);
    
    CHECK_EQUAL ("font1.png", parser.bitMapFileName().c_str()); 
}

