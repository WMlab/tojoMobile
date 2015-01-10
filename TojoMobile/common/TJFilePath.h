//
//  TJFilePath.h
//  TojoMobile
//
//  Created by 纪鹏 on 15/1/11.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJFilePath : NSObject

/**
 * 获得某bundle下文件路径
 *
 *      @param bundle        bundle对象，默认为mainBundle, [NSBundle mainBundle]
 *      @param relativePath  bundle下内容相对路径
 *
 *      @returns bundle中内容的绝对路径.
 */
NSString* TJPathForBundleResource(NSBundle* bundle, NSString* relativePath);

/**
 * 获得documents目录下文件路径
 *
 *      @returns documents目录下文件绝对路径.
 */
NSString* TJPathForDocumentsResource(NSString* relativePath);


/**
 * 获得caches目录下文件路径
 *
 *      @returns caches目录下文件绝对路径.
 */
NSString* TJPathForCachesResource(NSString* relativePath);

@end
