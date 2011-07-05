//
//  AngelCodeParser.cpp
//  GandoEngine
//
//  Created by Nicolas Goles on 6/29/11.
//  Copyright 2011 GandoGames. All rights reserved.
//

#include "AngelCodeParser.h"

#include <fstream>
#include <sstream>
#include <streambuf>

void AngelCodeParser::parseAngelFile(const std::string &filePath)
{
    std::ifstream t(filePath.c_str());
    std::string fileContainer;
    
    //Load File into a fileContainer
    t.seekg(0, std::ios::end);
    fileContainer.reserve(t.tellg());
    t.seekg(0, std::ios::beg);
    
    fileContainer.assign((std::istreambuf_iterator<char>(t)),
                          std::istreambuf_iterator<char>());

    this->parseAngelFileContainer(fileContainer);
}

void AngelCodeParser::parseAngelFileContainer(const std::string &fileContainer)
{
    std::string lineHolder;
    std::vector<std::string> tokens;
    std::vector<std::string>::iterator line;
    std::istringstream buffer(fileContainer);

    while (std::getline(buffer, lineHolder, '\n')) {
        tokens.push_back(lineHolder);
    }
    
    for (line = tokens.begin(); line < tokens.end(); ++line) {
        size_t found_common;
        size_t found_char;
        size_t found_page;
        
        found_common = (*line).find("common ");
        found_char = (*line).find("char ");
        found_page = (*line).find("page");
        
        if (found_char != std::string::npos) {
            m_charLines.push_back(this->processCharLine(*line));
            
        } else if (found_common != std::string::npos) {
            m_commonLine = (this->processCommonLine(*line));
            
        } else if (found_page != std::string::npos) {
            m_bitMapFileName.assign(this->processPageLine(*line));

        }
    }
}

std::string AngelCodeParser::processPageLine(const std::string &pageLine)
{
    std::string bitMapFileNameHolder;
    tokenizePageLine(pageLine, bitMapFileNameHolder);
    return bitMapFileNameHolder;
}

std::vector<int> AngelCodeParser::processCommonLine(const std::string &commonLine)
{
    std::vector<int> tokens;
    this->tokenizeCommonLine(commonLine, tokens);
    return tokens;
}

std::vector<int> AngelCodeParser::processCharLine(const std::string &charLine)
{
    std::vector<int> tokens;
    this->tokenizeCharLine(charLine, tokens);
    return tokens;
}

void AngelCodeParser::tokenizeCommonLine(const std::string &commonLine, std::vector<int> &tokenHolder)
{
    std::istringstream buffer(commonLine);
    tokenHolder.reserve(kAngelCommon_total);
    std::string holder;
    
    while (std::getline(buffer, holder, ' ')) {
        std::string value;
        std::istringstream input(holder);
        int count = 0;
        
        while (std::getline(input, value, '=')) {
            if(count)
                tokenHolder.push_back(atoi(value.c_str()));

            ++count;
        }
    }
}

void AngelCodeParser::tokenizeCharLine(const std::string &charLine, std::vector<int> &tokenHolder)
{
    std::istringstream buffer(charLine);
    std::string holder;

    while (std::getline(buffer, holder, ' ')) {
        std::string value;
        std::istringstream input(holder);
        int count = 0;
        
        while (std::getline(input, value, '=')) {
            if (count)
                tokenHolder.push_back(atoi(value.c_str()));

            ++count;
        }
    }
}

void AngelCodeParser::tokenizePageLine(const std::string &pageLine, std::string &bitMapFileNameHolder)
{
    std::istringstream buffer(pageLine);
    std::string holder;
    
    while (std::getline(buffer, holder, ' ')) {
        std::string value;
        std::istringstream input(holder);
        bool isFileName = false;
        
        while(std::getline(input, value, '=')) {
            if (isFileName) {                
                size_t foundCommas;
                
                //Strip " from file Name. 
                while ((foundCommas = value.find("\"")) != std::string::npos) {
                    value.replace(foundCommas, 1, "");
                }
                
                bitMapFileNameHolder.assign(value);
                break;
            }
            
            if(value.compare("file") == 0)
                isFileName = true;                
        }     
    }
}
