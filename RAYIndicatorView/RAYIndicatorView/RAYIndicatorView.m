//
//  RAYIndicatorView.m
//  RAYIndicatorView
//
//  Created by richerpay on 15/5/27.
//  Copyright (c) 2015年 richerpay. All rights reserved.
//

#import "RAYIndicatorView.h"

@interface RAYIndicatorView()

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatiorView;
@property (nonatomic, strong) UILabel *label;

@end


@implementation RAYIndicatorView
#pragma mark -
#pragma mark - life cycle
- (id)initWithFrame:(CGRect)frame {
    self= [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        self.layer.cornerRadius = 5;
        
        [self addSubview:self.activityIndicatiorView];
        self.activityIndicatiorView.center = CGPointMake(frame.size.width/2, frame.size.height/3);
        [self startAnimating];
        
        [self addSubview:self.label];
        self.label.bounds = CGRectMake(0, 0, frame.size.width, frame.size.height/5);
        self.label.center = CGPointMake(frame.size.width/2, frame.size.height/2+20);
                                       
    }
    return self;
}

#pragma mark - Delegate

#pragma mark - event response

#pragma mark - private methods

- (void)setIndicatorView:(NSString *)showMessage  {
    self.label.text = showMessage;
}

- (void)startAnimating {
    
    [self.activityIndicatiorView startAnimating];
}

- (void)stopAnimating {
    
    [self.activityIndicatiorView stopAnimating];
}

- (BOOL)isAnimating {
    return [self.activityIndicatiorView isAnimating];
}


#pragma mark - getters and setters
- (UIActivityIndicatorView *)activityIndicatiorView {
    
    if (_activityIndicatiorView == nil) {
        _activityIndicatiorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _activityIndicatiorView.hidesWhenStopped = YES;
        
    }
    return _activityIndicatiorView;
}

- (UILabel *)label {
    
    if (_label == nil) {
        _label = [[UILabel alloc]initWithFrame:CGRectZero];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font= [UIFont fontWithName:@"DFWaWaSC-W5" size:14];
        _label.text = @"这个字体好看吧";
        _label.backgroundColor = [UIColor clearColor];
        _label.numberOfLines = 0;
        _label.textColor =[UIColor blackColor];
    }
    return _label;
}

@end
