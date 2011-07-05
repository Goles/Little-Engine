//
//  AngelFont.h
//  GandoEngine
//
//  Created by Nicolas Goles on 6/28/11.
//  Copyright 2011 GandoGames. All rights reserved.
//

#ifndef __ANGEL_CODE_PARSER_H__
#define __ANGEL_CODE_PARSER_H__

#include <string>
#include <vector>

enum kAngelCommon {
    kAngelCommon_lineHeight = 0,
    kAngelCommon_base,
    kAngelCommon_scaleW,
    kAngelCommon_scaleH,
    kAngelCommon_pages,
    kAngelCommon_packed,
    kAngelCommon_total,
};

enum kAngelChar {
    kAngelChar_id = 0,
    kAngelChar_x,
    kAngelChar_y,
    kAngelChar_width,
    kAngelChar_height,
    kAngelChar_xoffset,
    kAngelChar_yoffset,
    kAngelChar_xadvance,
    kAngelChar_page,
    kAngelChar_chnl,
    kAngelChar_total,
};

class AngelCodeParser
{
public:
    void parseAngelFile(const std::string &filePath);
    const std::vector<std::vector<int> > &charLines() const { return m_charLines; }
    const std::vector<int> &commonLine() const { return m_commonLine; }
    const std::string &bitMapFileName() const { return m_bitMapFileName; }

protected:
    void parseAngelFileContainer(const std::string &fileContainer);
    
    std::vector<int> processCharLine(const std::string &charLine);
    std::vector<int> processCommonLine(const std::string &commonLine);
    std::string processPageLine(const std::string &pageLine);

    void tokenizeCommonLine(const std::string &line, std::vector<int> &tokenHolder);
    void tokenizeCharLine(const std::string &line, std::vector<int> &tokenHolder);
    void tokenizePageLine(const std::string &pageLine, std::string &bitMapFileNameHolder);

private:
    std::vector<std::vector<int> > m_charLines;
    std::vector<int> m_commonLine;
    std::string m_bitMapFileName;
};


#endif