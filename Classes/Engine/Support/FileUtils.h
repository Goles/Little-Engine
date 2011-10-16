//
//  FileUtils.h
//
//  Created by Nicolas Goles on 11/08/10.
//  Copyright 2010 Nicolas Goles. All rights reserved.
//

#ifndef _FILE_UTILS_H_
#define _FILE_UTILS_H_

#import <Foundation/Foundation.h>

namespace gg { namespace util {

/** Helper class to handle file operations */
static const NSString * fullPathFromRelativePath(NSString *relPath)
{
    // do not convert a path starting with '/'
    if([relPath characterAtIndex:0] == '/')
        return relPath;
    
    NSArray *tokens = [relPath componentsSeparatedByString:@"."];
    NSString *fullPath = [[NSBundle mainBundle] pathForResource:[tokens objectAtIndex:0] ofType:[tokens objectAtIndex:1]];

    if (!fullPath)
        fullPath = relPath;
    
    return fullPath;    
}

static const char * relativeCPathForFile(const char *fileName)
{
    NSString *relPath = [NSString stringWithCString:fileName encoding:NSUTF8StringEncoding];        
    const NSString *path = fullPathFromRelativePath(relPath);
    const char *c_path = [[path stringByDeletingLastPathComponent] UTF8String];   
    return c_path;
}

static const char * fullCPathFromRelativePath(const char *cPath)
{
    NSString *relPath = [NSString stringWithCString:cPath encoding:NSUTF8StringEncoding]; 
    return [fullPathFromRelativePath(relPath) UTF8String];
}

}} // namespace gg::util
#endif
