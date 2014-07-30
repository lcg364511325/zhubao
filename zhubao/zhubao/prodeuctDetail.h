//
//  prodeuctDetail.h
//  zhubao
//
//  Created by johnson on 14-7-28.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlService.h"

@interface prodeuctDetail : UIViewController<MWPhotoBrowserDelegate>
{
    UIButton* btnBack;
    RotateImageView *rImageView;
}


@property(retain , nonatomic) NSString * proid;//产品id
@property (weak, nonatomic) IBOutlet UIImageView *productpic;//产品图片
@property (weak, nonatomic) IBOutlet UIButton *addtoshopcart;//加入购物车按钮
@property (weak, nonatomic) IBOutlet UIButton *show3D;//3D展示按钮（非对戒）
@property (weak, nonatomic) IBOutlet UIButton *show3Dman;//3D展示（对戒男）
@property (weak, nonatomic) IBOutlet UIButton *show3Dwoman;//3D展示（对戒女）
@property (weak, nonatomic) IBOutlet UIButton *watchmorepic;//查看更多图片
@property (weak, nonatomic) IBOutlet UITextField *miantext;//主石
@property (weak, nonatomic) IBOutlet UITextField *nettext;//净度
@property (weak, nonatomic) IBOutlet UITextField *colortext;//颜色
@property (weak, nonatomic) IBOutlet UITextField *texturetext;//材质
@property (weak, nonatomic) IBOutlet UITextField *sizetext;//尺寸
@property (weak, nonatomic) IBOutlet UITextField *fonttext;//刻字
@property (weak, nonatomic) IBOutlet UITextField *numbertext;//数量
@property (weak, nonatomic) IBOutlet UITextField *dmiantext;//对戒主石
@property (weak, nonatomic) IBOutlet UITextField *dnettext;//对戒净度
@property (weak, nonatomic) IBOutlet UITextField *dcolortext;//对戒颜色
@property (weak, nonatomic) IBOutlet UITextField *dtexturetext;//对戒材质
@property (weak, nonatomic) IBOutlet UITextField *dsizetext;//对戒尺寸
@property (weak, nonatomic) IBOutlet UITextField *dfonttext;//对戒刻字
@property (weak, nonatomic) IBOutlet UIButton *mainselect;//主石选择
@property (weak, nonatomic) IBOutlet UIButton *netselect;//净度选择
@property (weak, nonatomic) IBOutlet UIButton *colorselect;//颜色选择
@property (weak, nonatomic) IBOutlet UIButton *texttureselect;//材质选择
@property (weak, nonatomic) IBOutlet UIButton *dmainselect;//对戒主石选择
@property (weak, nonatomic) IBOutlet UIButton *dnetselect;//对戒净度选择
@property (weak, nonatomic) IBOutlet UIButton *dcolorselect;//对戒颜色选择
@property (weak, nonatomic) IBOutlet UIButton *dtextureselect;//对戒材质选择
@property (weak, nonatomic) IBOutlet UITableView *miantable;//主石下拉框
@property (weak, nonatomic) IBOutlet UITableView *nettable;//净度下拉框
@property (weak, nonatomic) IBOutlet UITableView *colortable;//颜色下拉框
@property (weak, nonatomic) IBOutlet UITableView *texturetable;//材质下拉框
@property (weak, nonatomic) IBOutlet UILabel *modellable;//型号
@property (weak, nonatomic) IBOutlet UILabel *weighlable;//约重
@property (weak, nonatomic) IBOutlet UILabel *mainnanolable;//主石数量
@property (weak, nonatomic) IBOutlet UILabel *fitnanolable;//副石数量
@property (weak, nonatomic) IBOutlet UILabel *fitnaweighlable;//副石总重
@property (weak, nonatomic) IBOutlet UILabel *dweighlable;//对戒约重
@property (weak, nonatomic) IBOutlet UILabel *dmiannanolable;//对戒主石数量
@property (weak, nonatomic) IBOutlet UILabel *dfitnanolable;//对戒副石数量
@property (weak, nonatomic) IBOutlet UILabel *dfitweighlable;//对戒副石总重
@property (weak, nonatomic) IBOutlet UILabel *titlelable;//产品标题
@property (weak, nonatomic) IBOutlet UILabel *pricelable;//产品价格
@property (weak, nonatomic) IBOutlet UIButton *closebutton;
@property (weak, nonatomic) IBOutlet UILabel *kelalable;//克拉

@property (strong, nonatomic) NSArray *mainlist;
@property (strong, nonatomic) NSArray *dmainlist;
@property (strong, nonatomic) NSArray *netlist;
@property (strong, nonatomic) NSArray *colorlist;
@property (strong, nonatomic) NSArray *texturelist;

@property (weak, nonatomic) IBOutlet UIView *childview;

@property (nonatomic, strong) NSMutableArray *photos;

@property (nonatomic,assign) id <UIApplicationDelegate> mydelegate;//当前请求过来的对象


@end
