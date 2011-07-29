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

#include "ConstantsAndMacros.h"
#import "Texture2D.h"
#include "Quad2.h"

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
    ~Image();
//------------------------------------------------------------------------------	
	/** Initializer for pre-loaded textures
    	@param inTexture Pointer to a Texture2D object.
	 */
	void	initWithTexture2D(Texture2D* inTexture);
	
	/** @param scale Optional scaling amount. */
	void	initWithTexture2D(Texture2D* inTexture, const GGPoint &scale);
	
	/** Use a file name to load texture data
	    @param inTextureName file name containing texture data. 
	 */
	void	initWithTextureFile(const std::string &inTextureName);
	
	/**  @param scale Optional scaling amount */
	void	initWithTextureFile(const std::string &textureName, float inScale);
	
	/** Use pre-loaded texture data. */
	void	initWithUIImage(UIImage* inImage);
	
	/** @param filter Optional GLFilter to apply. */
	void	initWithUIImage(UIImage* inImage, GLenum filter);
	
	/** @param inScale Optional scaling amount */
	void	initWithUIImage(UIImage* inImage, float inScale, GLenum filter);
	
//------------------------------------------------------------------------------	
	/** Crop an existing Image object to form a sub-image.
	    @param point Upper left corner of selected area.
	    @param subImageWidth Width of selected area.
	    @param subImageHeight Height of selected area.
	    @param subImageScale Scaling factor for the resulting Image.	        
	*/
	Image*	getSubImage(const GGPoint &point,  GLuint subImageWidth, GLuint subImageHeight, const GGPoint &subImageScale);

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
	const void render(CGPoint point, const Quad2* const tc, const Quad2* const qv);
	
	/** Handles vertex calculations, storing results in Image.vertices[] malloc'd space. */
	void	calculateVertices(CGPoint point, GLuint subImageWidth, GLuint subImageHeight, BOOL center);
	
	/** Calculates vertex coordinates, storing results in Image.texCoords[] malloc'd space */
	void	calculateTexCoordsAtOffset(CGPoint offsetPoint, GLuint subImageWidth, GLuint subImageHeight);
    
	/** OpenGL bind(), GL tells the GPU to bind the texture. */
	const inline void bind()
	{
		if(texture)
			[texture bind];
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
	
	/** Gets Image width */
	int	getImageWidth();
	
	/** Gets Image height */
	int	getImageHeight();
	
	/** Get Image scale */
	GGPoint &getScale();
    
    /** Set Image Scale */
    void setScale(const GGPoint &scale) { m_scale = scale; }
    
    /** Directly set the scale X of the Image*/
	void setScaleX(float s){ m_scale.x = s; }
    
    /** Directly set the scale Y of the Image*/
	void setScaleY(float s){ m_scale.y = s; }  
	
	/** Get texture coordinates */
	Quad2*	getTexCoords();
	
	/** Gets Image vertex list */
	Quad2*	getVertex();
	
	/** Gets the texture name */
	const std::string &getTextureName();
	
//------------------------------------------------------------------------------
protected:	
	void initImplementation();
	
private:
	// Vertex arrays
	Quad2		*vertices;
	Quad2		*texCoords;
	GLushort	*indices;
	
	//Texture
    Texture2D *texture;
	
	std::string	textureName;
    GGPoint		m_scale;
    int			imageWidth;
	int			imageHeight;
	int			textureWidth;
	int			textureHeight;
	int			textureOffsetX;
	int			textureOffsetY;
	float		colourFilter[4];
	float		maxTexWidth;
	float		maxTexHeight;
	float		texWidthRatio;
	float		texHeightRatio;
	float		rotation;
	bool		flipHorizontally;
	bool		flipVertically;
};

#endif
