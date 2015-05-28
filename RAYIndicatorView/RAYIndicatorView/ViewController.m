//
//  ViewController.m
//  RAYIndicatorView
//
//  Created by richerpay on 15/5/26.
//  Copyright (c) 2015年 richerpay. All rights reserved.
//

#import "ViewController.h"
#import "RAYIndicatorViewController.h"


@interface ViewController (){
    RAYTool *tool;
}

@property (nonatomic, strong)UIView *transitionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.transitionView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.transitionView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) oneFingerSwipe :(UISwipeGestureRecognizer *)recognizer {
    CGPoint point = [recognizer locationInView:_transitionView];
    NSLog(@"Swipe down - start location: %f,%f", point.x, point.y);
    
    RAYIndicatorViewController *indicatorViewController = [[RAYIndicatorViewController alloc] init];
//    indicatorViewController.modalPresentationStyle = UIModalPresentationFormSheet;
//    indicatorViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
   /*
    typedef NS_ENUM(NSInteger, UIModalTransitionStyle) {
        UIModalTransitionStyleCoverVertical = 0,                        //默认 竖向上推
        UIModalTransitionStyleFlipHorizontal,                           //水平翻转
        UIModalTransitionStyleCrossDissolve,                            //隐出隐现 快速闪现
        UIModalTransitionStylePartialCurl NS_ENUM_AVAILABLE_IOS(3_2),   //翻页
    };
    */
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"cube";
//    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:nil];
/*
    常見的轉換類型（type）：
         kCATransitionFade               //淡出
         kCATransitionMoveIn          //覆盖原图
         kCATransitionPush               //推出
         kCATransitionReveal          //底部显出来
    SubType:
         kCATransitionFromRight
         kCATransitionFromLeft    // 默认值
         kCATransitionFromTop
         kCATransitionFromBottom
    设置其他动画类型的方法(type):
         pageCurl   向上翻一页
         pageUnCurl 向下翻一页
         rippleEffect 滴水效果
         suckEffect 收缩效果，如一块布被抽走
         cube 立方体效果
         oglFlip 上下翻转效果
 */
    
    
    [self presentViewController:indicatorViewController animated:NO completion:nil];
}

- (UIView *)transitionView {
    if (_transitionView == nil) {
        _transitionView =  [[UIView alloc]initWithFrame:CGRectZero];
        _transitionView.backgroundColor = [UIColor redColor];
        
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentCenter;
        
        
        NSString *fonName = @"DFWaWaSC-W5";

        
        tool = [[RAYTool alloc]init];
        [tool asynchronouslySetFontName:fonName];
        label.font = [UIFont fontWithName:fonName size:14];
        label.text = @"向左⬅️滑动";
        label.bounds = CGRectMake(0, 0, 140, 50);
        label.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
        [_transitionView addSubview:label];
        
        // 创建一个手势识别器
        UISwipeGestureRecognizer *oneFingerSwipe =
        [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerSwipe:)] ;
        [oneFingerSwipe setDirection:UISwipeGestureRecognizerDirectionLeft];

        // Add the gesture to the view
        [_transitionView addGestureRecognizer:oneFingerSwipe];
        
    }
    return _transitionView;
}

@end
