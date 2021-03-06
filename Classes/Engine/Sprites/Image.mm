//
//  Image.mm
//  Particles_2
//
//  Created by Nicolas Goles on 10/19/09.
//  Copyright 2009 Gando-Games All rights reserved.
//

#import "Image.h"
#include "FileUtils.h"
#include "SharedTextureManager.h"

Image::Image()
    : vertices(NULL)
    , texCoords(NULL)
    , indices(NULL)
    , texture(NULL)
    , imageWidth(0)
    , imageHeight(0)
    , textureWidth(0)
    , textureHeight(0)
    , textureOffsetX(0)
    , textureOffsetY(0)
    , maxTexWidth(0)
    , maxTexHeight(0)
    , texWidthRatio(0)
    , texHeightRatio(0)
    , rotation(0)
    , flipHorizontally(false)
    , flipVertically(false)

{
	m_scale.x = 1.0f;
    m_scale.y = 1.0f;    
	colourFilter[0]	= 1.0f;
	colourFilter[1]	= 1.0f;
	colourFilter[2]	= 1.0f;
	colourFilter[3]	= 1.0f;
}

Image::~Image()
{
    free(vertices);
	free(texCoords);
	free(indices);
    vertices = NULL;
    texCoords = NULL;
    indices = NULL;
    texture = NULL; //Not free.
}

#pragma mark initializers
void Image::initImplementation()
{
	if(texture)
	{	
		imageWidth = texture.contentSize.width;
		imageHeight = texture.contentSize.height;
		textureWidth = texture.pixelsWide;
		textureHeight = texture.pixelsHigh;
		maxTexWidth = imageWidth / (float)textureWidth;
		maxTexHeight = imageHeight / (float)textureHeight;
		texWidthRatio = 1.0f / (float)textureWidth;
		texHeightRatio = 1.0f / (float)textureHeight;

		// Init vertex arrays
		int totalQuads = 1;
		texCoords = (Quad2 *)malloc( sizeof(texCoords[0]) * totalQuads);
		vertices = (Quad2 *)malloc( sizeof(vertices[0]) * totalQuads);
		indices	= (GLushort *)malloc( sizeof(indices[0]) * totalQuads * 6);
	}
}

/*Init an image with pre-allocated Texture2D*/
void Image::initWithTexture2D(Texture2D *inTexture)
{
	if(inTexture)
	{
		texture = inTexture;
		initImplementation();
	}else{
		printf("Could not load texture when creating Image from Texture2D\n");
	}
}

/*Init an image with pre-allocated Texture2D and a input scaling*/
void Image::initWithTexture2D(Texture2D *inTexture, const GGPoint &inScale)
{
	if(inTexture)
	{
		texture = inTexture;     
		initImplementation();
	}else {
		printf("Could not load texture when creating Image from Texture2D with scale: %f, %f\n", inScale.x, inScale.y);
	}
}

/*Does try to initialize an Image with a texture file*/
void Image::initWithTextureFile(const std::string &inTextureName)
{	
	Texture2D *imTexture = TEXTURE_MANAGER->createTexture(inTextureName);
	
	if(imTexture)
	{
		texture = imTexture;
		textureName = std::string(inTextureName);
		initImplementation();
	}else {
		printf("Could not load texture when creating Image from file %s\n",inTextureName.c_str());
		assert(false);
	}
}

/*Does try to initialize an Image with a texture file and an input Scaling*/
void Image::initWithTextureFile(const std::string &inTextureName, float imageScale)
{	
	Texture2D *imTexture = TEXTURE_MANAGER->createTexture(inTextureName);
    
	if(imTexture)
	{
		texture = imTexture;
		m_scale.x = imageScale;
        m_scale.y = imageScale;        
		textureName = inTextureName;
		initImplementation();
	}else {
		printf("Could not load texture when creating Image from File :%s\n",inTextureName.c_str());
	}
}

/*Does initialize an Image with a UIImage*/
void Image::initWithUIImage(UIImage* image)
{
	texture = [[Texture2D alloc] initWithImage:image filter:GL_NEAREST];
	initImplementation();
}

/*Does initialize an Image with a UIImage and a GL_FILTER*/
void Image::initWithUIImage(UIImage* inImage, GLenum filter)
{
	texture	= [[Texture2D alloc] initWithImage:inImage filter:filter];
}

/*Does initialize an Image with a UIImage a Scale and a GL_FILTER*/
void Image::initWithUIImage(UIImage* inImage, float inScale, GLenum inFilter)
{
	texture = [[Texture2D alloc] initWithImage:inImage filter:inFilter];
	m_scale.x = inScale;
    m_scale.y = inScale;
	initImplementation();
}

/*
 *	Getters and Setters
 */
#pragma mark setters
void Image::setTextureName(const std::string &inTextureName)
{
	textureName = std::string(inTextureName);
}

void Image::setTextureOffsetX(int inTextureOffset)
{
	textureOffsetX = inTextureOffset;
}

void Image::setTextureOffsetY(int inTextureOffset)
{
	textureOffsetY = inTextureOffset;
}

void Image::setImageWidth(GLuint inWidth)
{
	imageWidth = inWidth;
}

void Image::setImageHeight(GLuint inHeight)
{
	imageHeight = inHeight;
}

void Image::setRotation(float inRotation)
{
	rotation = inRotation;
}

void Image::setColorFilter(float red, float green, float blue, float alpha)
{
	colourFilter[0] = red;
	colourFilter[1] = green;
	colourFilter[2] = blue;
	colourFilter[3] = alpha;
}

void Image::setAlpha(float alpha)
{
	colourFilter[3] = alpha;
}

#pragma mark getters
Image* Image::getSubImage(const GGPoint &inPoint,  GLuint inSubImageWidth, GLuint inSubImageHeight, const GGPoint &inSubImageScale)
{
	//Create a new Image instance using the texture which has been assigned to the current instance
	Image *subImage = new Image();
	subImage->initWithTexture2D(texture, inSubImageScale);
	
	//We need set the subImage texture name equal to it's parent textureName. (since it will be a scrap of the bigger texture)
	subImage->setTextureName(textureName);
	
	// Define the offset of the subimage we want using the point provided
	subImage->setTextureOffsetX(inPoint.x);
	subImage->setTextureOffsetY(inPoint.y);
	
	// Set the width and the height of the subimage
	subImage->setImageWidth(inSubImageWidth);
	subImage->setImageHeight(inSubImageHeight);
	
	// Set the rotatoin of the subImage to match the current images rotation
	subImage->setRotation(rotation);
    
	return subImage;
}

const std::string &Image::getTextureName()
{
	return textureName;
}

int Image::getImageWidth()
{
	return imageWidth;
}

int Image::getImageHeight()
{
	return imageHeight;
}

GGPoint &Image::getScale()
{
	return m_scale;
}

Quad2* Image::getTexCoords()
{
	return texCoords;
}

Quad2* Image::getVertex()
{
	return vertices;
}

#pragma mark rendering

void Image::renderAtPoint(CGPoint point, BOOL center)
{
	CGPoint offsetPoint = CGPointMake(textureOffsetX, textureOffsetY);
	
	calculateVertices(point, imageWidth, imageHeight, center);
	calculateTexCoordsAtOffset(offsetPoint, imageWidth, imageHeight);
	
	render(point, texCoords, vertices);
}

void Image::renderSubImageAtPoint(CGPoint point, CGPoint offsetPoint, GLfloat subImageWidth, GLfloat subImageHeight, BOOL isCenterOfImage)
{
	// Calculate the vertex and texcoord values for this image
	this->calculateVertices(point, subImageWidth, subImageHeight, isCenterOfImage);
	this->calculateTexCoordsAtOffset(offsetPoint, subImageWidth, subImageHeight);
	
	// Now that we have defined the texture coordinates and the quad vertices we can render to the screen 
	// using them
	this->render(point, texCoords, vertices);
}

const void Image::render(const CGPoint point, const Quad2* tc, const Quad2* qv)
{		   
	// Save the current matrix to the stack
	glPushMatrix();
	
	// Rotate around the Z axis by the angle defined for this image
	glTranslatef(point.x, point.y, 0);
	glRotatef(-rotation, 0.0f, 0.0f, 1.0f);
	glTranslatef(-point.x, -point.y, 0);
    
    //Default is no color filter.
    glColor4f(colourFilter[0], colourFilter[1], colourFilter[2], colourFilter[3]);
	
	// Set client states so that the Texture Coordinate Array will be used during rendering
	glEnableClientState(GL_VERTEX_ARRAY);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	
	// Enable Texture_2D
	glEnable(GL_TEXTURE_2D);
	
	//We ask the texture manager to bind for us, to not over-bind a texture.
	TEXTURE_MANAGER->bindTexture(textureName);
	
	// Set up the VertexPointer to point to the vertices we have defined
	glVertexPointer(2, GL_FLOAT, 0, qv);
	
	// Set up the TexCoordPointer to point to the texture coordinates we want to use
	glTexCoordPointer(2, GL_FLOAT, 0, tc);
	
	// Enable blending as we want the transparent parts of the image to be transparent
	glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);// removed due to "duplicate glFunction"
	
	// Draw the vertices to the screen
	glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
	
	// Now we are done drawing disable blending
	glDisable(GL_BLEND);
	
	// Disable as necessary
	glDisable(GL_TEXTURE_2D);
	glDisableClientState(GL_VERTEX_ARRAY);
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);
	
	// Restore the saved matrix from the stack
	glPopMatrix();
}

#pragma mark calculations
void Image::calculateTexCoordsAtOffset(CGPoint offsetPoint, GLuint subImageWidth, GLuint subImageHeight)
{
	// Calculate the texture coordinates using the offset point from which to start the image and then using the width and height
	// passed in
	
	if(!flipHorizontally && !flipVertically) {
		texCoords[0].br_x = texWidthRatio * subImageWidth + (texWidthRatio * offsetPoint.x);
		texCoords[0].br_y = texHeightRatio * offsetPoint.y;
		
		texCoords[0].tr_x = texWidthRatio * subImageWidth + (texWidthRatio * offsetPoint.x);
		texCoords[0].tr_y = texHeightRatio * subImageHeight + (texHeightRatio * offsetPoint.y);
		
		texCoords[0].bl_x = texWidthRatio * offsetPoint.x;
		texCoords[0].bl_y = texHeightRatio * offsetPoint.y;
		
		texCoords[0].tl_x = texWidthRatio * offsetPoint.x;
		texCoords[0].tl_y = texHeightRatio * subImageHeight + (texHeightRatio * offsetPoint.y);
		return;
	}
	
	if(flipVertically && flipHorizontally) {
		texCoords[0].tl_x = texWidthRatio * subImageWidth + (texWidthRatio * offsetPoint.x);
		texCoords[0].tl_y = texHeightRatio * offsetPoint.y;
		
		texCoords[0].bl_x = texWidthRatio * subImageWidth + (texWidthRatio * offsetPoint.x);
		texCoords[0].bl_y = texHeightRatio * subImageHeight + (texHeightRatio * offsetPoint.y);
		
		texCoords[0].tr_x = texWidthRatio * offsetPoint.x;
		texCoords[0].tr_y = texHeightRatio * offsetPoint.y;
		
		texCoords[0].br_x = texWidthRatio * offsetPoint.x;
		texCoords[0].br_y = texHeightRatio * subImageHeight + (texHeightRatio * offsetPoint.y);
		return;
	}
	
	if(flipHorizontally) {
		texCoords[0].bl_x = texWidthRatio * subImageWidth + (texWidthRatio * offsetPoint.x);
		texCoords[0].bl_y = texHeightRatio * offsetPoint.y;
		
		texCoords[0].tl_x = texWidthRatio * subImageWidth + (texWidthRatio * offsetPoint.x);
		texCoords[0].tl_y = texHeightRatio * subImageHeight + (texHeightRatio * offsetPoint.y);
		
		texCoords[0].br_x = texWidthRatio * offsetPoint.x;
		texCoords[0].br_y = texHeightRatio * offsetPoint.y;
		
		texCoords[0].tr_x = texWidthRatio * offsetPoint.x;
		texCoords[0].tr_y = texHeightRatio * subImageHeight + (texHeightRatio * offsetPoint.y);
		return;
	}
	
	if(flipVertically) {
		texCoords[0].tr_x = texWidthRatio * subImageWidth + (texWidthRatio * offsetPoint.x);
		texCoords[0].tr_y = texHeightRatio * offsetPoint.y;
		
		texCoords[0].br_x = texWidthRatio * subImageWidth + (texWidthRatio * offsetPoint.x);
		texCoords[0].br_y = texHeightRatio * subImageHeight + (texHeightRatio * offsetPoint.y);
		
		texCoords[0].tl_x = texWidthRatio * offsetPoint.x;
		texCoords[0].tl_y = texHeightRatio * offsetPoint.y;
		
		texCoords[0].bl_x = texWidthRatio * offsetPoint.x;
		texCoords[0].bl_y = texHeightRatio * subImageHeight + (texHeightRatio * offsetPoint.y);
		return;
	}
	
	if(flipVertically && flipHorizontally) {
		texCoords[0].tl_x = texWidthRatio * subImageWidth + (texWidthRatio * offsetPoint.x);
		texCoords[0].tl_y = texHeightRatio * offsetPoint.y;
		
		texCoords[0].bl_x = texWidthRatio * subImageWidth + (texWidthRatio * offsetPoint.x);
		texCoords[0].bl_y = texHeightRatio * subImageHeight + (texHeightRatio * offsetPoint.y);
		
		texCoords[0].tr_x = texWidthRatio * offsetPoint.x;
		texCoords[0].tr_y = texHeightRatio * offsetPoint.y;
		
		texCoords[0].br_x = texWidthRatio * offsetPoint.x;
		texCoords[0].br_y = texHeightRatio * subImageHeight + (texHeightRatio * offsetPoint.y);
		return;
	}
	
}

void Image::calculateVertices(CGPoint point, GLuint subImageWidth, GLuint subImageHeight, BOOL center)
{
	// Calculate the width and the height of the quad using the current image scale and the width and height
	// of the image we are going to render
	GLfloat quadWidth = subImageWidth * m_scale.x;
	GLfloat quadHeight = subImageHeight * m_scale.y;
	
	// Define the vertices for each corner of the quad which is going to contain our image.
	// We calculate the size of the quad to match the size of the subimage which has been defined.
	// If center is true, then make sure the point provided is in the center of the image else it will be
	// the bottom left hand corner of the image
	if(center) {
		vertices[0].br_x = point.x + quadWidth / 2;
		vertices[0].br_y = point.y + quadHeight / 2;
		
		vertices[0].tr_x = point.x + quadWidth / 2;
		vertices[0].tr_y = point.y + -quadHeight / 2;
		
		vertices[0].bl_x = point.x + -quadWidth / 2;
		vertices[0].bl_y = point.y + quadHeight / 2;
		
		vertices[0].tl_x = point.x + -quadWidth / 2;
		vertices[0].tl_y = point.y + -quadHeight / 2;
	} else {
		vertices[0].br_x = point.x + quadWidth;
		vertices[0].br_y = point.y + quadHeight;
		
		vertices[0].tr_x = point.x + quadWidth;
		vertices[0].tr_y = point.y;
		
		vertices[0].bl_x = point.x;
		vertices[0].bl_y = point.y + quadHeight;
		
		vertices[0].tl_x = point.x;
		vertices[0].tl_y = point.y;
	}
}
