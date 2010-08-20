//
//  SpriteSheet.h
//  Particles_2
//
//  Created by Nicolas Goles on 10/29/09.
//  Copyright 2009 GandoGames. All rights reserved.
//

#ifndef _SPRITE_SHEET_H_
#define _SPRITE_SHEET_H_

#import "Image.h"
#include <string>
#include <iostream>

class SpriteSheet
{
public:
	
	//Action Methods
	void	initWithImage(Image *spriteSheet, GLuint spriteWidth, GLuint spriteHeight, GLuint spriteSpacing);
	void	initWithImageNamed(const std::string &inTextureName, GLuint spriteWidth, GLuint spriteHeight, GLuint spacing, float imageScale);
	Image*	getSpriteAt(GLuint x, GLuint y);
	void	renderSpriteAt(GLuint x, GLuint y, CGPoint point, BOOL isCenterOfImage);
	CGPoint	getOffsetForSpriteAt(int x, int y);
	Quad2*	getTextureCoordsForSpriteAt(GLuint x, GLuint y);
	Quad2*	getVerticesForSpriteAt(GLuint x, GLuint y, CGPoint point, BOOL isCenterOfImage);
	
	//Getters
	Image*	getSheetImage();
	GLuint	getSpriteWidth();
	GLuint	getSpriteHeight();
	GLuint	getSpacing();
	int		getHorizontalNumber();
	int		getVerticalNumber();
	Quad2*	getVertices();
	Quad2*	getTexCoords();
	
private:
	// Class Atributes
	Image*	sheetImage;			//This wil be the main spriteSheet image.
	GLuint	spriteWidth;		//One sprite width
	GLuint	spriteHeight;		//One sprite height.
	GLuint	spacing;			//This represents the separation between sprites.
	int		horizontalNumber;	//Number of sprites un horizontal row.
	int		verticalNumber;		//Number of sprites in vertical row.
	Quad2*	vertices;			//Vertex array
	Quad2*	texCoords;			//Texture Coordinates array
	
	//Action Methods
	void initImplementation(GLuint inSpriteWidth, GLuint inSpriteHeight, GLuint inSpacing, float inImageScale);
};

#endif