/*
 *  VectorList.h
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 5/12/10.
 *  Copyright 2010 GandoGames. All rights reserved.
 *
 */

/*
 * This support file is used to work with vectors in a simmilar way to C arrays
 * when needed. Gotten from:
 * http://stackoverflow.com/questions/231491/how-to-initialize-const-stdvectort-like-a-c-array
 * used like:
 
	 #include <iostream>
	 #include <vector>
	 #include <iterator>
	 #include <algorithm>
	 using namespace std;
	 
	 template <typename T>
	 struct vlist_of : public vector<T> {
	 vlist_of(const T& t) {
	 (*this)(t);
	 }
	 vlist_of& operator()(const T& t) {
	 this->push_back(t);
	 return *this;
	 }
	 };
	 
	 int main() {
	 const vector<int> v = vlist_of<int>(1)(2)(3)(4)(5);
	 copy(v.begin(), v.end(), ostream_iterator<int>(cout, "\n"));
	 }
 */

#ifndef _VECTOR_LIST_H_
#define _VECTOR_LIST_H_

#include <iostream>
#include <vector>
#include <iterator>
#include <algorithm>

using namespace std;

template <typename T>
struct vlist_of : public vector<T> {
    vlist_of(const T& t) {
        (*this)(t);
    }
    vlist_of& operator()(const T& t) {
        this->push_back(t);
        return *this;
    }
};

#endif