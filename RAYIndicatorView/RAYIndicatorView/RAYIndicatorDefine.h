//
//  RAYIndicatorDefine.h
//  RAYIndicatorView
//
//  Created by richerpay on 15/5/27.
//  Copyright (c) 2015年 richerpay. All rights reserved.
//

#ifndef RAYIndicatorView_RAYIndicatorDefine_h
#define RAYIndicatorView_RAYIndicatorDefine_h

#define SCREEN_WIDTH                [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT               [UIScreen mainScreen].bounds.size.height


#define IMAGE(file)                 [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:file  ofType:nil]]

#define RGBA(r,g,b,a)               [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define COLORWITHWHITE(w,a)         [UIColor colorWithWhite:w alpha:a]

#endif
