//
//  ObjectPool.h
//  GandoEngine
//
//  Created by Nicolas Goles on 3/9/11.
//  Copyright 2011 GandoGames. All rights reserved.
//

#ifndef __OBJECT_POOL_H__
#define __OBJECT_POOL_H__

#include <iostream>

namespace gg { namespace utils {
 
template <class T>
class ObjectPool
{
public:
    ObjectPool(int size) : m_size(size)
    {
        m_pool = new T[m_size];
        m_inuse = new bool[m_size];
        
        //Assign all inUse to false
        for(int i = 0; i < m_size; ++i)
        {
            m_inuse[i] = false;
        }
    }
    
    ~ObjectPool()
    {        
        delete []m_pool;
        delete []m_inuse;
    }
    
    /* Mark a pool's object as "unused" */
    void release(int index)
    {
        m_inuse[index] = false;
    }
    
    /* Ask for an "unused" pool's object*/
    T& create()
    {
        int i;
        
        for (i = 0; i < m_size; ++i)
        {
            if (!m_inuse[i])
            {
                m_inuse[i] = true;
                break;
            }
        }
        
        return m_pool[i];
    }
    
    /* Overload [] operator for easy pool item access */
    T& operator[](const int index){
        return m_pool[index];
    }
    
private:
    int m_size;
    T *m_pool;
    bool *m_inuse;
};

    
}}

#endif
