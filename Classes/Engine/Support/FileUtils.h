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
    if(([relPath length] > 0) && ([relPath characterAtIndex:0] == '/'))
        return relPath;
    
    NSMutableArray *imagePathComponents = [NSMutableArray arrayWithArray:[relPath pathComponents]];
    
    NSString *file = [imagePathComponents lastObject];    
    [imagePathComponents removeLastObject];
    
    NSString *imageDirectory = [NSString pathWithComponents:imagePathComponents];
    
    NSString *fullpath = [[NSBundle mainBundle] pathForResource:file
                                                         ofType:NULL
                                                    inDirectory:imageDirectory];
    if (!fullpath)
        fullpath = relPath;
    
    
    return fullpath;
    
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
    const  NSString *path = fullPathFromRelativePath(relPath);
    const char *c_path = [path UTF8String];
    return c_path;
}

}} // namespace gg::util
#endif