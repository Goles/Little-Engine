/*
 *  gecFollowingCamera.h
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 1/31/11.
 *  Copyright 2011 GandoGames. All rights reserved.
 *
 */

#ifndef __GEC_FOLLOWING_CAMERA__
#define __GEC_FOLLOWING_CAMERA__

#include "ICompCamera.h"
#include "SceneManager.h"

class gecFollowingCamera : public ICompCamera
{
public:	
	gecFollowingCamera() 
        : m_cameraView(CGRectMake(0, 0, SCENE_MANAGER->getWindow().width, SCENE_MANAGER->getWindow().height))
        , m_deathZoneX(SCENE_MANAGER->getWindow().width/2)
        , m_deathZoneY(SCENE_MANAGER->getWindow().height/2)
        , m_active(true)
        , m_follow_x(true)
        , m_follow_y(true)
    {}
    
    virtual void update(float delta);
	virtual void restore();
	virtual void locate();		

	virtual const gec_id_type &componentID() const { return m_componentID; }
	inline bool getFollowX() const { return m_follow_x; }
	inline void setFollowX(bool doesFollow) { m_follow_x = doesFollow; }
	inline bool getFollowY() const { return m_follow_y; }
	inline void setFollowY(bool doesFollow) { m_follow_y = doesFollow; }
	inline int getDeathZoneX() const { return m_deathZoneX; }
	inline int getDeathZoneY() const { return m_deathZoneY; }	
	inline bool getActive() const { return m_active; }
	inline void setActive(bool active) { m_active = active; }
    
    inline void setDeathZoneX(int x) 
    {
		assert(x >= 0);
		m_deathZoneX = x;
	}
    
    inline void setDeathZoneY(int y) 
    {
		assert(y >= 0);
		m_deathZoneY = y;
	}
	
protected:
	inline void setCameraX(int x) { m_cameraView.origin.x = x; }
	inline void setCameraY(int y){ m_cameraView.origin.y = y; }
	
private:
	static const gec_id_type m_componentID;
	CGRect m_cameraView;
	int	 m_deathZoneX;
	int  m_deathZoneY;
	bool m_active;
	bool m_follow_x;
	bool m_follow_y;
};

#endif