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
#include <deque>

namespace gg { namespace utils {
 
template <class T>
class ObjectPool
{
public:
    ObjectPool() : m_size(0)
    {
        //Empty Constructor.
        //Used when you don't want to declare the pool size inmediatly.
        //You can then assign a pool by copy.
        //ObjectPool<T *> p = ObjectPool<T*> a_pool(100);
    }
    
    ObjectPool(int size) : m_size(size)
    {
        m_pool = new T[m_size];
        m_inuse = new bool[m_size];
        
        //Assign all inUse to false
        for(int i = 0; i < m_size; ++i)
        {
            m_pool[i].index = i;
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
        m_freePool.push_front(index);
        m_inuse[index] = false;
    }
    
    /* Ask for an "unused" pool's object*/
    T& create()
    {
        int i;
        
        if(m_freePool.size())
        {
            int index = m_freePool.front();
            m_freePool.pop_front();
            return m_pool[index];
        }
        
        for (i = 0; i < m_size; ++i)
        {
            if (m_inuse[i] == false)
            {
                m_inuse[i] = true;
                return m_pool[i];
            }
        }
        
        this->debugPrintInUse();
        
        //Object Pool is empty, handle properly.
        assert(false);
        
        return m_pool[i];
    }
    
    /* Overload [] operator for easy pool item access */
    T& operator[](const int index){
        return m_pool[index];
    }
    
    void debugPrintInUse()
    {
        std::cout << "ObjectPool Size : " << m_size << std::endl;
        
        for (int i = 0; i < m_size; ++i)
        {
            std::cout << i << " " << m_inuse[i] << std::endl;
        }
    }
    
private:
    int m_size;
    T *m_pool;
    std::deque<int> m_freePool;
    bool *m_inuse;
};

    
}}

#endif
