//
//  SpriteSheet.mm
//  Particles_2
//
//  Created by Nicolas Goles on 10/29/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SpriteSheet.h"
#import "Texture2D.h"

#pragma mark private_action_methods
void SpriteSheet::initImplementation(GLuint inSpriteWidth, GLuint inSpriteHeight, GLuint inSpacing, float inImageScale)
{
	//Sets the width, height  and spacing within the spritesheet.
	spriteWidth	= inSpriteWidth;
	spriteHeight = inSpriteHeight;
	spacing	= inSpacing;
	horizontalNumber	= ((sheetImage->getImageWidth() - spriteWidth) / (spriteWidth + spacing)) + 1;
	verticalNumber		= ((sheetImage->getImageHeight() - spriteHeight) / (spriteHeight + spacing)) + 1;
	if((sheetImage->getImageHeight() - spriteHeight) % (spriteHeight + spacing) != 0)
		verticalNumber++;
}


#pragma mark public_action_methods
void SpriteSheet::initWithImage(Image *inSpriteSheet, GLuint spriteWidth, GLuint spriteHeight, GLuint spriteSpacing)
{
	sheetImage = inSpriteSheet;	
	this->initImplementation(spriteWidth, spriteHeight, spriteSpacing, 1.0f);
}

//This inits the sprite Sheet from a textureFile, it initializes an Image() and the image will validate .png or .pvr, and ask the manager to init.
void SpriteSheet::initWithImageNamed(const std::string &inTextureName, GLuint spriteWidth, GLuint spriteHeight, GLuint spriteSpacing, float imageScale)
{
	sheetImage = new Image();
	sheetImage->initWithTextureFile(inTextureName);
	this->initImplementation(spriteWidth, spriteHeight, spriteSpacing, imageScale);
}

//This will return a certain sprite at X,Y position inside this SpriteSheets sheetImage.
Image* SpriteSheet::getSpriteAt(GLuint x, GLuint y)
{
	CGPoint spritePoint = CGPointMake(x * (spriteWidth + spacing), y * (spriteHeight + spacing));	
	return sheetImage->getSubImage(spritePoint, spriteWidth, spriteHeight, sheetImage->getScale());
}

CGPoint	SpriteSheet::getOffsetForSpriteAt(int x, int y)
{
	return CGPointMake(x * (spriteWidth + spacing), y * (spriteHeight + spacing));
}

Quad2*	SpriteSheet::getTextureCoordsForSpriteAt(GLuint x, GLuint y)
{
	CGPoint offsetPoint = this->getOffsetForSpriteAt(x,y);
	sheetImage->calculateTexCoordsAtOffset(offsetPoint, spriteWidth, spriteHeight);
	
	return sheetImage->getTexCoords();
}

Quad2*	SpriteSheet::getVerticesForSpriteAt(GLuint x, GLuint y, CGPoint point, BOOL isCenterOfImage)
{
	sheetImage->calculateVertices(point, spriteWidth, spriteHeight, isCenterOfImage);
	return sheetImage->getVertex();
}

void	SpriteSheet::renderSpriteAt(GLuint x, GLuint y, CGPoint point, BOOL isCenterOfImage)
{	
	CGPoint	spritePoint = this->getOffsetForSpriteAt(x,y);
	// Rather than return a new image for this sprite we are going to just render the specified
	// sprite at the specified location
	sheetImage->renderSubImageAtPoint(point, spritePoint, spriteWidth, spriteHeight, isCenterOfImage);
}

#pragma mark getters
Image*	SpriteSheet::getSheetImage()
{
	return sheetImage;
}

GLuint	SpriteSheet::getSpriteWidth()
{
	return spriteWidth;
}

GLuint	SpriteSheet::getSpriteHeight()
{
	return spriteHeight;
}

GLuint	SpriteSheet::getSpacing()
{
	return spacing;
}

int		SpriteSheet::getHorizontalNumber()
{
	return horizontalNumber;
}

int		SpriteSheet::getVerticalNumber()
{
	return verticalNumber;
}

Quad2*	SpriteSheet::getVertices()
{
	return vertices;
}

Quad2*	SpriteSheet::getTexCoords()
{
	return texCoords;
}

