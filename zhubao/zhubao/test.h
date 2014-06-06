//
//  test.h
//  zhubao
//
//  Created by johnson on 14-5-31.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface test : UIViewController<UIScrollViewDelegate>
@property (strong,nonatomic)UIScrollView *scrollView;
@property (strong,nonatomic)NSMutableArray *slideImages;
@property (strong,nonatomic)UIPageControl *pageControl;

@end
