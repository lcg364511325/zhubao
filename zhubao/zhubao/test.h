//
//  test.h
//  zhubao
//
//  Created by johnson on 14-5-31.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductCell.h"
#import "AppDelegate.h"
#import "Index.h"

@interface test : UIViewController<UITextViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIApplicationDelegate>

@property (retain, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic,assign) id <UIApplicationDelegate> mydelegate;//当前请求过来的对象

@end
