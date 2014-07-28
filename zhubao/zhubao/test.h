//
//  test.h
//  zhubao
//
//  Created by johnson on 14-5-31.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductCell.h"
#import <objc/runtime.h>

@interface test : UIViewController<UITextViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

- (IBAction)chooseImage:(id)sender;

@property (retain, nonatomic) IBOutlet UIImageView *imageView;

@end
