//
//  RAYIndicatorView.h
//  RAYIndicatorView
//
//  Created by richerpay on 15/5/27.
//  Copyright (c) 2015年 richerpay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RAYIndicatorView : UIView

- (void)setIndicatorView:(NSString *)showMessage;

- (void)startAnimating;
- (void)stopAnimating;
//- (BOOL)isAnimating;

@end
