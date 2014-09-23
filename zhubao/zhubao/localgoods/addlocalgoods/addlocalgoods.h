//
//  addlocalgoods.h
//  zhubao
//
//  Created by johnson on 14-9-23.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface addlocalgoods : UIViewController<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    //区分图片位置
    NSInteger pictag;
    //保存图片路径
    NSString *pic1;
    NSString *pic2;
    NSString *pic3;
    BOOL isFullScreen;
    //下拉菜单
    UIActionSheet *myActionSheet;
    
    UIPopoverController *popoverController;
    
    //图片2进制路径
    NSString* filePath;
    NSArray *typelist;
    NSString *typevalue;
}

@property (nonatomic,assign) id <UIApplicationDelegate> mydelegate;

@property (weak, nonatomic) IBOutlet UIImageView *zhengmianview;
@property (weak, nonatomic) IBOutlet UIImageView *fanmianview;
@property (weak, nonatomic) IBOutlet UIImageView *cemianview;

@property (weak, nonatomic) IBOutlet UITextField *modelnoText;
@property (weak, nonatomic) IBOutlet UITextField *goldweightText;
@property (weak, nonatomic) IBOutlet UITextField *mianctText;
@property (weak, nonatomic) IBOutlet UITextField *miancountText;
@property (weak, nonatomic) IBOutlet UITextField *fitctText;
@property (weak, nonatomic) IBOutlet UITextField *fitcountText;
@property (weak, nonatomic) IBOutlet UITextField *priceText;
@property (weak, nonatomic) IBOutlet UITextField *typeText;
@property (weak, nonatomic) IBOutlet UITableView *typeTView;
@property (weak, nonatomic) IBOutlet UITextField *nameText;

@end
