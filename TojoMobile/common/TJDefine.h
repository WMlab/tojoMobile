//
//  TJDefine.h
//  TojoMobile
//
//  Created by 纪鹏 on 15/1/14.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#ifndef TojoMobile_TJDefine_h
#define TojoMobile_TJDefine_h

/** RGB颜色 */
#define TJColorRGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]
#define TJColorRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

/** HEX颜色 */
#define TJColorHex(c) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:((c)&0xFF)/255.0 alpha:1.0]
#define TJColorHexA(c,a) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:((c)&0xFF)/255.0 alpha:(a)]


#endif
