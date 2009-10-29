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

#import <Foundation/Foundation.h>
#import "Texture2D.h"

typedef struct {
	float tl_x, tl_y;
	float tr_x, tr_y;
	float bl_x, bl_y;
	float br_x, br_y;
} Quad2;

class Image
{
public:
	//Constructor
	Image();
	
	//Initializers
	void	initWithTexture(Texture2D *inTexture);
	void	initWithTexture(Texture2D *inTexture, float inScale);
	void	initWithUIImage(UIImage *inImage);
	void	initWithUIImage(UIImage *inImage, GLenum filter);
	void	initWithUIImage(UIImage *inImage, float inScale);
	void	initWithUIImage(UIImage *inImage, float inScale, GLenum filter);	
	
	//Action Methods
	Image *	getSubImage(CGPoint point,  GLuint subImageWidth, GLuint subImageHeight, float subImageScale);
	void	renderAtPoint(CGPoint point, BOOL centerOfImage);
	void	render(CGPoint point, Quad2* tc, Quad2* qv);
	void	calculateVertices(CGPoint point, GLuint subImageWidth, GLuint subImageHeight, BOOL center);
	void	calculateTexCoordsAtOffset(CGPoint offsetPoint, GLuint subImageWidth, GLuint subImageHeight);
	void	bind();
	
	// Setters
	void	setColorFilter(float Red, float Green, float Blue, float alpha);
	void	setAlpha(float alpha);
	// More setters
	void initImplementation();
	void setTextureOffsetX(int inTextureOffset);
	void setTextureOffsetY(int inTextureOffset);
	void setImageWidth(GLuint inWidth);
	void setImageHeight(GLuint inHeight);
	void setRotation(float inRotation);
									   				   
private:
	// Game State
	//SingletonGameState *sharedGameState;
	// The OpenGL texture to be used for this image
	Texture2D	*texture;	
	int			imageWidth;
	int			imageHeight;
	int			textureWidth;
	int			textureHeight;
	float		maxTexWidth;
	float		maxTexHeight;
	float		texWidthRatio;
	float		texHeightRatio;
	int			textureOffsetX;
	int			textureOffsetY;
	float		rotation;
	float		scale;
	BOOL		flipHorizontally;
	BOOL		flipVertically;
	float		colourFilter[4];
	
	// Vertex arrays
	Quad2		*vertices;
	Quad2		*texCoords;
	GLushort	*indices;
};
