//
//  ustomtailor.h
//  zhubao
//
//  Created by johnson on 14-5-28.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Index.h"
#import "product.h"
#import "NakedDiamond.h"
#import "diploma.h"
#import "member.h"
#import "shoppingcartCell.h"

@interface ustomtailor : UIViewController<UITextViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    //下拉菜单
    UIActionSheet *myActionSheet;
    
    
    //图片2进制路径
    NSString* filePath;
    NSMutableArray *shoppingcartlist;
}
@property (retain, nonatomic) IBOutlet UIView *primaryView;
@property (retain, nonatomic) IBOutlet UIView *secondaryView;
@property (retain, nonatomic) IBOutlet UIView *primaryShadeView;
@property (retain, nonatomic) IBOutlet UIView *thirdaryView;
@property (weak, nonatomic) IBOutlet UITableView *textureselect;
@property (strong, nonatomic) NSArray *mainlist;
@property (weak, nonatomic) IBOutlet UITextField *texturetext;
@property (weak, nonatomic) IBOutlet UITextField *goldweightText;
@property (weak, nonatomic) IBOutlet UITextField *miandiaText;
@property (weak, nonatomic) IBOutlet UITextField *mianNoText;
@property (weak, nonatomic) IBOutlet UITextField *fitDiaText;
@property (weak, nonatomic) IBOutlet UITextField *fitNoText;
@property (weak, nonatomic) IBOutlet UITextField *sizeText;
@property (weak, nonatomic) IBOutlet UITextField *fontText;
@property (weak, nonatomic) IBOutlet UIImageView *zhengmianview;
@property (weak, nonatomic) IBOutlet UIImageView *fanmianview;
@property (weak, nonatomic) IBOutlet UIImageView *cemianview;
@property (weak, nonatomic) IBOutlet UITableView *goodsview;
@property (weak, nonatomic) IBOutlet UIButton *shopcartcount;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;


- (IBAction)goAction:(id)sender;
- (IBAction)closeAction:(id)sender;

@end
