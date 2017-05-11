//
//  tool.h
//  美白
//
//  Created by 这个男人来自地球 on 2017/4/3.
//  Copyright © 2017年 zhang yannan. All rights reserved.
//

#ifndef tool_h
#define tool_h
//获取RBGA分量
#define Mask8(x) ((x) & 0xFF)
#define R(x) (Mask8(x))
#define G(x) (Mask8(x >> 8))
#define B(x) (Mask8(x >> 16))
#define A(x) (Mask8(x >> 24))
#define RGBAMake(r,g,b,a) ( Mask8(r) | Mask8(g) << 8 | Mask8(b) << 16) | Mask8(a) << 24)

#endif /* tool_h */
