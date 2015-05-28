//
//  RAYIndicatorViewController.m
//  RAYIndicatorView
//
//  Created by richerpay on 15/5/27.
//  Copyright (c) 2015年 richerpay. All rights reserved.
//

#import "RAYIndicatorViewController.h"

@interface RAYIndicatorViewController (){
    NSTimer *timer;
    
    UIActivityIndicatorView *activityIndicator;
}

@property (nonatomic, strong)UIView *transitionView;

@property (nonatomic, strong)UIButton *indicatorButton;
@property (nonatomic, strong)UIButton *progressButton;
@property (nonatomic, strong)UIButton *networkIndicatorButton;

@property (nonatomic, strong)UIProgressView *progressView;

@end

@implementation RAYIndicatorViewController

#pragma mark -
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:self.transitionView];
    
    [self.view addSubview:self.indicatorButton];
    [self.view addSubview:self.progressButton];
    [self.view addSubview:self.networkIndicatorButton];
    
    [self.view addSubview:self.progressView];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.transitionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.indicatorButton.frame = CGRectMake(10, 50, SCREEN_WIDTH-20, 40);
    self.progressButton.frame = CGRectMake(10, 110, SCREEN_WIDTH-20, 40);
    self.networkIndicatorButton.frame = CGRectMake(10, 170, SCREEN_WIDTH-20, 40);
    
    self.progressView.frame = CGRectMake(10, 230, SCREEN_WIDTH-20, 80);
    
}
//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    [UIView animateWithDuration:1 animations:^{
//        [[UIProgressView appearanceWhenContainedIn:[RAYIndicatorViewController class], nil] setFrame:CGRectMake(10.0, 310.0, 300.0, 129.0)];
//    } completion:nil];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Delegate

#pragma mark - event response
- (void) oneFingerSwipe :(UISwipeGestureRecognizer *)recognizer {
    CGPoint point = [recognizer locationInView:_transitionView];
    NSLog(@"Swipe down - start location: %f,%f", point.x, point.y);
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    //    animation.type = @"pageCurl";
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void) clickButton:(UIButton *)button {

    switch (button.tag) {
        case 1001:
            [self showIndicator];
            break;
        case 1002:
            
            [self showProgress];
            break;
        case 1003:
            [self showNetworkIndicator];
            break;
            
        default:
            break;
    }
}

#pragma mark - private methods
- (void) showNetworkIndicator {
    UIApplication *app = [UIApplication sharedApplication];
    if (app.isNetworkActivityIndicatorVisible) {
        app.networkActivityIndicatorVisible = NO;
    }
    else {
        app.networkActivityIndicatorVisible = YES;
    }
}
- (void)showProgress {
    if(self.progressView.progress != 0){
        [timer invalidate];
        
//        self.progressView.progress = 0;
        [self.progressView setProgress:0 animated:YES];

        
    }
    else{
        timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(runProgress) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
    }
}

- (void) showIndicator {
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    activityIndicator.bounds = CGRectMake(0, 0, 100, 100);
//    activityIndicator.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    activityIndicator.frame = CGRectMake(10, 260, SCREEN_WIDTH-20, 80);
    //    activityIndicator.hidesWhenStopped = YES;
    [self.view addSubview:activityIndicator];
    [activityIndicator startAnimating];
    
//操作队列
    
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc]init];
    
//设置最大的操作数
    [operationQueue setMaxConcurrentOperationCount:1];
//构建一个操作对象 selector 指定的方法是在另外一个线程中运行的
    NSInvocationOperation *operation = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(runIndicator) object:nil];
    [operationQueue addOperation:operation];
    
}

- (void) runProgress {
    
    if (self.progressView.progress == 1) {
        [timer invalidate];
        
    }
    else {
        self.progressView.progress += .05;
//        [self.progressView setProgress:.05 animated:YES];
    }
}

- (void) runIndicator {
    [NSThread sleepForTimeInterval:3];
    [activityIndicator stopAnimating];
}

#pragma mark - getters and setters
- (UIView *)transitionView {
    if (_transitionView == nil) {
        _transitionView =  [[UIView alloc]initWithFrame:CGRectZero];
        _transitionView.backgroundColor = [UIColor yellowColor];
        
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"向右➡️滑动";
        label.bounds= CGRectMake(0, 0, 140, 50);
        label.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
        [_transitionView addSubview:label];
        
        // 创建一个手势识别器
        UISwipeGestureRecognizer *oneFingerSwipe =
        [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerSwipe:)] ;
        [oneFingerSwipe setDirection:UISwipeGestureRecognizerDirectionRight];
        
        // Add the gesture to the view
        [_transitionView addGestureRecognizer:oneFingerSwipe];
        
    }
    return _transitionView;
}

- (UIButton *)indicatorButton {
    if (_indicatorButton == nil) {
        _indicatorButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _indicatorButton.tag = 1001;
        [_indicatorButton setTitle:@"indicator" forState:UIControlStateNormal];
        [_indicatorButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [_indicatorButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        
        _indicatorButton.layer.borderColor = [UIColor redColor].CGColor;
        _indicatorButton.layer.borderWidth = 2;
        _indicatorButton.layer.cornerRadius =5;
        
    }
    return _indicatorButton;
}

- (UIButton *)progressButton {
    if (_progressButton == nil) {
        _progressButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _progressButton.tag = 1002;
        [_progressButton setTitle:@"progress" forState:UIControlStateNormal];
        [_progressButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_progressButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        
        _progressButton.layer.borderColor = [UIColor redColor].CGColor;
        _progressButton.layer.borderWidth = 2;
        _progressButton.layer.cornerRadius =5;
    }
    return _progressButton;
}

- (UIButton *)networkIndicatorButton {
    if (_networkIndicatorButton == nil) {
        _networkIndicatorButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _networkIndicatorButton.tag = 1003;
        [_networkIndicatorButton setTitle:@"networkIndicator" forState:UIControlStateNormal];
        [_networkIndicatorButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_networkIndicatorButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        
        _networkIndicatorButton.layer.borderColor = [UIColor redColor].CGColor;
        _networkIndicatorButton.layer.borderWidth = 2;
        _networkIndicatorButton.layer.cornerRadius =5;
    }
    return _networkIndicatorButton;
}

- (UIProgressView *)progressView {
    if (_progressView == nil) {
        _progressView = [[UIProgressView alloc]init];
        _progressView.backgroundColor = [UIColor blackColor];
        _progressView.progressViewStyle = UIProgressViewStyleDefault;
//            UIProgressViewStyleDefault,     // normal progress bar
//            UIProgressViewStyleBar,         // for use in a toolbar
        _progressView.progress = .0;
        _progressView.progressTintColor = [UIColor redColor];
        _progressView.trackTintColor = [UIColor clearColor];
//        _progressView.progressImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"1.png"  ofType:nil] ];
//        _progressView.trackImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"2.png"  ofType:nil] ];
//        elf.progressView.frame = CGRectMake(self.progressView.frame.origin.x, self.progressView.frame.origin.y, self.progressView.frame.size.width, 9);
//        [[_progressView layer]setCornerRadius:10.0f];
//        [[_progressView layer]setBorderWidth:2.0f];
//        [[_progressView layer]setMasksToBounds:TRUE];
//        _progressView.clipsToBounds = YES;
//        [[_progressView layer]setFrame:CGRectMake(10, 230, SCREEN_WIDTH-20, 80)];
//        [[_progressView  layer]setBorderColor :[UIColor whiteColor].CGColor];
    }
    return _progressView;
}

@end
