//
//  Image.h
//  Particles_2
//
//  Created by Nicolas Goles on 10/19/09.
//  Copyright 2009 Gando Games. All rights reserved.
//

/*
 *	Coded in C++ to start avoiding the Objective-C overhead. Still Texture2D is in Obj-C but as a future 
	project it should be ported to pure C++ to reduce the overhead of the class.
 *
 *	_NG
 */

#ifndef _IMAGE_H_
#define _IMAGE_H_

#import "Texture2D.h"
#include <string>
#include <iostream>

/** Image base class.
    @remarks
        Allows several initialization modes, such as passing a texture name, file name, or UIImage
        The object's properties can be set and modified once the object is defined, through its setter methods.
*/
     

typedef struct {
	float tl_x, tl_y;
	float tr_x, tr_y;
	float bl_x, bl_y;
	float br_x, br_y;
} Quad2;

class Image
{
public:
	/** Image Constructor
	    @remarks
	        Sets all coordinates and offsets to 0.
	        Additionally, the texture can be initialized in various ways, using pre-loaded textures or files. */
	            
	Image();
	
	/**Initializer for pre-loaded textures
    	@param inTexture Pointer to a Texture2D object.*/
	void	initWithTexture2D(Texture2D *inTexture);
	/** @param scale Optional scaling amount. */
	void	initWithTexture2D(Texture2D *inTexture, float scale);
	
	/**Uses a file name to load texture data
	    @param inTextureName file name containing texture data. */
	void	initWithTextureFile(const std::string &inTextureName);
	/** 	    @param scale Optional scaling amount */
	void	initWithTextureFile(const std::string &textureName, float inScale);
	/**Uses pre-loaded texture data. */
	void	initWithUIImage(UIImage *inImage);
	/** @param filter Optional GLFilter to apply. */
	void	initWithUIImage(UIImage *inImage, GLenum filter);
	/** @param inScale Optional scaling amount */
	void	initWithUIImage(UIImage *inImage, float inScale, GLenum filter);	
	
	/** Crops an existing Image object.
	    @param point Upper left corner of selected area.
	    @param subImageWidth Width of selected area.
	    @param subImageHeight Height of selected area.
	    @param subImageScale Scaling factor for the resulting Image.	        
	*/
	Image *getSubImage(CGPoint point,  GLuint subImageWidth, GLuint subImageHeight, float subImageScale);
	/**Renders the Image
	    @param point Coordinates of a point.
	    @param centerOfImage If set, point is the center of the image, else it's bottom left corner.
	    
	void	renderAtPoint(CGPoint point, BOOL centerOfImage);
	void	renderSubImageAtPoint(CGPoint point, CGPoint offsetPoint, GLfloat subImageWidth, GLfloat subImageHeight, BOOL isCenterOfImage);
	void	render(CGPoint point, Quad2* tc, Quad2* qv);
	void	calculateVertices(CGPoint point, GLuint subImageWidth, GLuint subImageHeight, BOOL center);
	void	calculateTexCoordsAtOffset(CGPoint offsetPoint, GLuint subImageWidth, GLuint subImageHeight);
	void	bind();
	
	// Setters
	void setColorFilter(float Red, float Green, float Blue, float alpha);
	void setAlpha(float alpha);
	void setTextureOffsetX(int inTextureOffset);
	void setTextureOffsetY(int inTextureOffset);
	void setImageWidth(GLuint inWidth);
	void setImageHeight(GLuint inHeight);
	void setRotation(float inRotation);
	void setTextureName(const std::string &inTextureName);
	void setFlipHorizontally(bool f) { flipHorizontally = f; }
	void setFlipVertically(bool f) { flipVertically = f; }
	
	//Getters
	int		getImageWidth();
	int		getImageHeight();
	float		getScale();
	Quad2*	getTexCoords();
	Quad2*	getVertex();
	std::string getTextureName();
	
protected:	
	void initImplementation();
private:
	// Game State
	//SingletonGameState *sharedGameState;
	// The OpenGL texture to be used for this image
	Texture2D	*texture;
	std::string	textureName;
	int			imageWidth;
	int			imageHeight;
	int			textureWidth;
	int			textureHeight;
	float			maxTexWidth;
	float			maxTexHeight;
	float			texWidthRatio;
	float			texHeightRatio;
	int			textureOffsetX;
	int			textureOffsetY;
	float			rotation;
	float			scale;
	bool			flipHorizontally;
	bool			flipVertically;
	float			colourFilter[4];
	
	// Vertex arrays
	Quad2		*vertices;
	Quad2		*texCoords;
	GLushort	*indices;
};

#endif
