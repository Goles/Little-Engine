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
    virtual ~gecImage();
    
    void update();
    virtual void render() const;

    inline void setImage(Image *image) {
        m_image = image;
    }
    
private:
    GGPoint m_position;
    Image *m_image;
    
};



#endif
