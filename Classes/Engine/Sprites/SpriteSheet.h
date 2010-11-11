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
//------------------------------------------------------------------------------
	/** Empty Constructor.
		@remarks
			Prevents C++ to create a "default" constructor just in case.
	 */
	SpriteSheet(){}
	
	/** Destructor
		@remarks
			Takes care of cleaning the sheetImage associated with the SpriteSheet. 
	 */
	~SpriteSheet()
	{
		delete sheetImage;
	}
//------------------------------------------------------------------------------
	/** Takes a spriteSheet, defines a sprite size, and calculates horizontal and vertical numbers 
	    @param spriteSheet Image containing several sprites
	    @param spriteWidth Width of each sprite
	    @param spriteHeight Height of each sprite
	    @param spriteSpacing Separation between sprites
	    @remarks Details of the implementation of this calculation can be found in SpriteSheet.mm:13
	*/
	void	initWithImage(Image *spriteSheet, GLuint spriteWidth, GLuint spriteHeight, GLuint spriteSpacing);
	
	/** Wrapper for previous method, takes a filename string, validates it and loads the contents into an Image.
	*/
	void	initWithImageNamed(const std::string &inTextureName, GLuint spriteWidth, GLuint spriteHeight, GLuint spacing, float imageScale);
	
	/** Calculates a point with coordinates for the selected sprite, and then passes it to getSubImage with the correct sprite size.
	    @returns The subImage as a new Image object.
	    @param horizontalNumber selects a sprite in the nth column
	    @param verticalNumber selects a sprite in the mth row
	*/
	Image*	getSpriteAt(GLuint horizontalNumber, GLuint verticalNumber);
	
	/** Wrapper for renderSubImage, translates hNum and vNum into coordinates, and passes directly to renderSubImage method.
	    @param point Render coordinates
	*/
	void	renderSpriteAt(GLuint horizontalNumber, GLuint verticalNumber, CGPoint point, BOOL isCenterOfImage);
	
	/** Calculates the coordinates for the selected sprite
	    @returns CGPoint with coordinates
	*/	
	CGPoint	getOffsetForSpriteAt(int horizontalNumber, int verticalNumber);
	
	/** Wrapper for calculateTexCoordsAtOffset, translates hNum and vNum, and passes them to calculateTexCoordsAtOffset.
	    @returns Quad2 with texture coordinates.
	*/
	Quad2*	getTextureCoordsForSpriteAt(GLuint horizontalNumber, GLuint verticalNumber);
	
	/** Wrapper for calculateVertices, NEEDS REVIEW! 
	    <br>
	    In SpriteSheet.mm, line 53:
	        <br>
	        Quad2*	SpriteSheet::getVerticesForSpriteAt(GLuint horizontalNumber, GLuint verticalNumber, CGPoint point, BOOL isCenterOfImage)<br>
            {<br>
	            sheetImage->calculateVertices(point, spriteWidth, spriteHeight, isCenterOfImage);<br>
	            return sheetImage->getVertex();<br>
            }<br>
        
        From what I see, there is no use for hNum and vNum, since we ask for "point" and pass it straight to calculateVertices.
        However, this is not consistent with the format used in the last function calls.
        What I think we should be doing here (and do correct me if I'm wrong), is similar to what we do in
        getTextureCoordsForSpriteAt; use getOffsetForSpriteAt to map hNum and vNum to a pixel coord, and pass
        that point to calculateVertices. We seem to be doing nothing of the sort.
        _FA
	*/
	Quad2*	getVerticesForSpriteAt(GLuint horizontalNumber, GLuint verticalNumber, CGPoint point, BOOL isCenterOfImage);
//------------------------------------------------------------------------------
	/** Lua Interface
	 @remarks
	 This method is to expose this class to the Lua runtime.
	 */
	static void registrate(void)
	{
		luabind::module(LR_MANAGER_STATE) 
		[
		 luabind::class_<SpriteSheet>("SpriteSheet")
		 .def(luabind::constructor<>())
		 .def("initWithImageNamed", &SpriteSheet::initWithImageNamed)
		 ];		
	}
//------------------------------------------------------------------------------
	Image*	getSheetImage();
	GLuint	getSpriteWidth();
	GLuint	getSpriteHeight();
	GLuint	getSpacing();
	int		getHorizontalNumber();
	int		getVerticalNumber();
	Quad2*	getVertices();
	Quad2*	getTexCoords();
	
	
//------------------------------------------------------------------------------	
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
