//
//  imageUtils.m
//  美白
//
//  Created by 这个男人来自地球 on 2017/4/2.
//  Copyright © 2017年 zhang yannan. All rights reserved.
//

#import "imageUtils.h"
#import "tool.h"
@implementation imageUtils
+(UIImage *)imageWhitening:(UIImage *)image{
    //亮度的差值
    int lumi=20;
    //1、获取图片的大小，确定大小的目的是开辟内存空间
    //首先 将UIImage->CGImage
    CGImageRef imageRef=[image CGImage];
    //获取图片的宽和高
    NSUInteger imageWidth=CGImageGetWidth(imageRef);
    NSUInteger imageHeight=CGImageGetHeight(imageRef);
    
    //2、创建颜色空间（灰色空间   彩色空间）
    CGColorSpaceRef colorSpaceRef=CGColorSpaceCreateDeviceRGB();
    //3、创建图片上下文，保存图片信息
    //参数一：数据源（指针：创建一个指针指向这张图片）
    //如何创建这个指针？
    //像素格式（RGB  ARGB）A、R、G、B、每一个值表示一个分量，每个分量代表8位=一个字节
    //创建像素指针（将图片视为由N个像素组成的，图片即为像素数组）
    //像素指针指向首地址（像素指针大小：32位）
    //像素指针32位像素指针
    //创建指向该内存区域首地址的指针
    UInt32 *inputPixels=(UInt32 *)calloc(imageWidth*imageHeight, sizeof(UInt32));
    //参数二：图片的宽
    //参数三：图片的高
    //参数四：每一个分量（像素）的大小
    //参数五：每一行占用的内存大小 （1）计算每一行字节数（像素点）（2）像素点最大ARGB也就是四个字节
    //参数六：颜色空间
    //参数七：布局摆放是否有透明度
    CGContextRef contextRef = CGBitmapContextCreate(inputPixels,
                          imageWidth,
                          imageHeight,
                          8,
                          imageWidth * 4,
                          colorSpaceRef,
                          kCGImageAlphaPremultipliedLast | kCGImageByteOrder32Big);
    
    //第四步，根据上下文绘制图片
    CGContextDrawImage(contextRef,  CGRectMake(0, 0, imageWidth, imageHeight),imageRef);
    //美白 -> 操作像素点->操作RGBA分量
    //图像学中RGB  0-255  数值越大越白
    //原理：将RGB的分量值调大
    //通过for循环遍历图片上的每一个像素点
    for (int i=0; i<imageHeight; i++) {
        for (int j=0; j<imageWidth; j++) {
            //获取相对应位置的像素点
            UInt32 *currentPixels=inputPixels + i*imageWidth+j;
            //获取指针对应的值
            UInt32 color=*currentPixels;
            //操作像素点（操作RGBA分量值）
            UInt32 thisR,thisG,thisB,thisA;
            //R
            thisR = R(color);
            thisR = R(color) + lumi;
            thisR=thisR > 255 ? 255 : thisR;
            //G
            thisG = G(color);
            thisG = G(color) + lumi;
            thisG=thisG > 255 ? 255 : thisG;
            //B
            thisB = B(color);
            thisB = B(color) + lumi;
            thisB=thisB > 255 ? 255 : thisB;
            //A
            thisA = A(color);
            
            //更新像素点的值
//            *currentPixels=RGBAMake(thisR, thisG, thisB, thisA) ;
            *currentPixels = Mask8(thisR) | Mask8(thisG) <<8 | Mask8(thisB) <<16 | Mask8(thisA) <<24;
            
        }
    }
    //第六步 创建UIImage
    CGImageRef newImageRef=CGBitmapContextCreateImage(contextRef);
    UIImage *newImage=[UIImage imageWithCGImage:newImageRef];
    //第七步：释放内存
    CGColorSpaceRelease(colorSpaceRef);
    CGContextRelease(contextRef);
    CGImageRelease(newImageRef);
    free(inputPixels);
    return newImage;
}
@end
