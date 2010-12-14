//
//  Image.h
//  Particles_2
//
//  Created by Nicolas Goles on 10/19/09.
//  Copyright 2009 Nicolas Goles. All rights reserved.
//

/*
 *	Coded in C++ to start avoiding the Objective-C overhead. Still Texture2D is in Obj-C but as a future 
	project it should be ported to pure C++ to reduce the overhead of the class.
 *  Test!
 *	_NG
 */

#ifndef _IMAGE_H_
#define _IMAGE_H_

#include <string>
#include <iostream>

#import "Texture2D.h"
#include "LuaRegisterManager.h"

typedef struct {
	float tl_x, tl_y;
	float tr_x, tr_y;
	float bl_x, bl_y;
	float br_x, br_y;
} Quad2;


/** Image base class.
 @remarks
 Allows several initialization modes, such as passing a texture name, file name, or UIImage
 The object's properties can be set and modified once the object is defined, through its setter methods.
 Method "getSubImage" allows manipulation of SpriteSheet objects
 */
class Image
{
public:
//------------------------------------------------------------------------------
	/** Image Constructor
	    @remarks
	        Sets all coordinates and offsets to 0.
	        Additionally, the texture can be initialized in various ways, using pre-loaded textures or files. */
	            
	Image();
	
//------------------------------------------------------------------------------	
	/** Initializer for pre-loaded textures
    	@param inTexture Pointer to a Texture2D object.
	 */
	void	initWithTexture2D(Texture2D *inTexture);
	
	/** @param scale Optional scaling amount. */
	void	initWithTexture2D(Texture2D *inTexture, float scale);
	
	/** Use a file name to load texture data
	    @param inTextureName file name containing texture data. 
	 */
	void	initWithTextureFile(const std::string &inTextureName);
	
	/** 	    @param scale Optional scaling amount */
	void	initWithTextureFile(const std::string &textureName, float inScale);
	
	/** Use pre-loaded texture data. */
	void	initWithUIImage(UIImage *inImage);
	
	/** @param filter Optional GLFilter to apply. */
	void	initWithUIImage(UIImage *inImage, GLenum filter);
	
	/** @param inScale Optional scaling amount */
	void	initWithUIImage(UIImage *inImage, float inScale, GLenum filter);
	
//------------------------------------------------------------------------------	
	/** Crop an existing Image object to form a sub-image.
	    @param point Upper left corner of selected area.
	    @param subImageWidth Width of selected area.
	    @param subImageHeight Height of selected area.
	    @param subImageScale Scaling factor for the resulting Image.	        
	*/
	Image *getSubImage(CGPoint point,  GLuint subImageWidth, GLuint subImageHeight, float subImageScale);

	/** Renders the Image
	    @param point Coordinates of a point.
	    @param centerOfImage If set, point is the center of the image, else it's bottom left corner.
	*/    
	void	renderAtPoint(CGPoint point, BOOL centerOfImage);
	
	/** Select and render a sub-image, using a point as corner or center position.
	    @param point Render coordinates
	    @param offsetPoint Upper left corner of selected area 
	*/
	void	renderSubImageAtPoint(CGPoint point, CGPoint offsetPoint, GLfloat subImageWidth, GLfloat subImageHeight, BOOL isCenterOfImage);
   
	/** Render using texture coordinates and vertices
        @param point Render coordinates
        @param tc Texture Coordinates
        @param qv Quad Vertices
    */
	void	render(CGPoint point, Quad2* tc, Quad2* qv);
	
	/** Handles vertex calculations, storing results in Image.vertices[] malloc'd space. */
	void	calculateVertices(CGPoint point, GLuint subImageWidth, GLuint subImageHeight, BOOL center);
	
	/** Calculates vertex coordinates, storing results in Image.texCoords[] malloc'd space */
	void	calculateTexCoordsAtOffset(CGPoint offsetPoint, GLuint subImageWidth, GLuint subImageHeight);
    
	/** OpenGL bind(), GL tells the GPU to bind the texture. */
	void	bind();
	
//------------------------------------------------------------------------------
	/** Lua Interface
		@remarks
			This methods are to expose this class to the Lua runtime.
	 */
	static void registrate(void)
	{
		luabind::module(LR_MANAGER_STATE) 
		[
		 luabind::class_<Image>("Image")
		 .def(luabind::constructor<>())
		 .def("initWithTextureFile", (void(Image::*)(const std::string &))&Image::initWithTextureFile)
		 .property("scale", &Image::getScale, &Image::setScale)
		 ];	
	}
	
//------------------------------------------------------------------------------
	/** Applies a color filter to the Image object.
	    @param Red 
	    @param Green
	    @param Blue 0.0 -> 1.0 Amout of color to apply
	    @param alpha Transparency layer
	*/ 
	void setColorFilter(float Red, float Green, float Blue, float alpha);
	
	/** Manually set the transparency amount */
	void setAlpha(float alpha);
	
	/** Manually set texture offset X coordinates */
	void setTextureOffsetX(int inTextureOffset);
	
	/** Manually set texture offset Y coordinates */
	void setTextureOffsetY(int inTextureOffset);
	
	/** Manually set Image Width */
	void setImageWidth(GLuint inWidth);
	
	/** Manually set Image Height */
	void setImageHeight(GLuint inHeight);
	
	/** Set rotation amount 
	    @param inRotation Rotation amount, in degrees.
	*/
	void setRotation(float inRotation);
	
	/** Modify the texture name */
	void setTextureName(const std::string &inTextureName);
	
	/** Sets the Horizontal Flip toggle */
	void setFlipHorizontally(bool f) { flipHorizontally = f; }
	
	/** Sets the Vertical Flip toggle */
	void setFlipVertically(bool f) { flipVertically = f; }
	
	/** Directly set the scale of the Image*/
	void setScale(float s){ scale = s; }
	
	/** Gets Image width */
	int		getImageWidth();
	
	/** Gets Image height */
	int		getImageHeight();
	
	/** Gets Image scale */
	float const getScale();
	
	/** Get texture coordinates */
	Quad2*	getTexCoords();
	
	/** Gets Image vertex list */
	Quad2*	getVertex();
	
	/** Gets the texture name */
	std::string getTextureName();
	
//------------------------------------------------------------------------------
protected:	
	void initImplementation();
private:
	Texture2D	*texture;
	std::string	textureName;
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
	bool		flipHorizontally;
	bool		flipVertically;
	float		colourFilter[4];
	
	// Vertex arrays
	Quad2		*vertices;
	Quad2		*texCoords;
	GLushort	*indices;
};

#endif
