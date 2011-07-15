//
//  gecImage.h
//  GandoEngine
//
//  Created by Nicolas Goles on 7/13/11.
//  Copyright 2011 GandoGames. All rights reserved.
//

#ifndef __GEC_IMAGE_H__
#define __GEC_IMAGE_H__

#include "gecVisual.h"

class Image;

class gecImage : public gecVisual {

public:
    gecImage()
        : m_image(NULL)
    {
        m_position.x = 0.0;
        m_position.y = 0.0;
    }
    virtual ~gecImage();
    
    virtual void update(float delta);
    virtual void render() const;
	virtual const std::string& componentID() const { return m_componentID; }
    
    inline void setImage(Image *image) {
        m_image = image;
    }
    
private:
    GGPoint m_position;
    Image *m_image;
    static const gec_id_type m_componentID;
};

#endif
