//
//  ustomtailor.m
//  zhubao
//
//  Created by johnson on 14-5-28.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "ustomtailor.h"

@interface ustomtailor ()
{
    BOOL isFullScreen;
}
@end

@implementation ustomtailor

@synthesize primaryView;
@synthesize secondaryView;
@synthesize primaryShadeView;
@synthesize thirdaryView;
@synthesize textureselect;
@synthesize mainlist=_mainlist;
@synthesize texturetext;
@synthesize goldweightText;
@synthesize miandiaText;
@synthesize mianNoText;
@synthesize fitDiaText;
@synthesize fitNoText;
@synthesize sizeText;
@synthesize fontText;

//区分图片位置
NSInteger pictag=0;
//保存图片路径
NSString *pic1=nil;
NSString *pic2=nil;
NSString *pic3=nil;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSArray *mainarray = [[NSArray alloc] initWithObjects:@"18K黄", @"18K白",
                          @"18K双色", @"18K玫瑰金", @"PT900", @"Pt950", @"PD950",nil];
    self.mainlist = mainarray;
    texturetext.userInteractionEnabled=NO;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)doReg:(id)sender
{
    Index * _Index = [[Index alloc] init];
    
    [self.navigationController pushViewController:_Index animated:NO];
}

-(IBAction)doReg1:(id)sender
{
    product * _product = [[product alloc] init];
    
    [self.navigationController pushViewController:_product animated:NO];
}

-(IBAction)doReg2:(id)sender
{
    NakedDiamond * _NakedDiamond = [[NakedDiamond alloc] init];
    
    [self.navigationController pushViewController:_NakedDiamond animated:NO];
}

-(IBAction)doReg3:(id)sender
{
    diploma * _diploma = [[diploma alloc] init];
    
    [self.navigationController pushViewController:_diploma animated:NO];
}

-(IBAction)doReg4:(id)sender
{
    member * _member = [[member alloc] init];
    
    [self.navigationController pushViewController:_member animated:NO];
}

//购物车
- (IBAction)goAction:(id)sender
{
//    primaryShadeView.alpha=0.5;
//    secondaryView.frame = CGRectMake(140, 85, secondaryView.frame.size.width, secondaryView.frame.size.height);
//    secondaryView.hidden = NO;
}

- (IBAction)closeAction:(id)sender
{
    primaryShadeView.alpha=0;
    secondaryView.hidden = YES;
}

//设置页面跳转
-(IBAction)setup:(id)sender
{
    thirdaryView.hidden=NO;
    thirdaryView.frame=CGRectMake(750, 70, thirdaryView.frame.size.width, thirdaryView.frame.size.height);
}
//设置页面关闭
-(IBAction)closesetup:(id)sender
{
    thirdaryView.hidden=YES;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_mainlist count];
    //只有一组，数组数即为行数。
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             TableSampleIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:TableSampleIdentifier];
    }
    
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [self.mainlist objectAtIndex:row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *rowString = [self.mainlist objectAtIndex:[indexPath row]];
    texturetext.text=rowString;
    textureselect.hidden=YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self.view];
    //点击其他地方消失
    if (!CGRectContainsPoint([textureselect frame], pt)) {
        //to-do
        textureselect.hidden=YES;
    }
}

// 材质下拉框
- (IBAction)mianselect:(id)sender
{
    textureselect.hidden=NO;
}

//确认定制
-(IBAction)orderOfGoods:(id)sender
{
    sqlService * sql=[[sqlService alloc] init];
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    buyproduct * entity=[[buyproduct alloc]init];
    entity.producttype=@"2";
    entity.customerid=myDelegate.entityl.uId;
    entity.photos=pic1;
    entity.photom=pic2;
    entity.photob=pic3;
    entity.pgoldtype=texturetext.text;
    entity.pweight=goldweightText.text;
    entity.Dia_Z_weight=miandiaText.text;
    entity.Dia_Z_count=mianNoText.text;
    entity.Dia_F_weight=fitDiaText.text;
    entity.Dia_F_count=fitNoText.text;
    entity.psize=sizeText.text;
    entity.pdetail=fontText.text;
    buyproduct *successadd=[sql addToBuyproduct:entity];
    if (successadd) {
        NSString *rowString =@"成功加入购物车！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    } else{
        NSString *rowString =@"加入购物车失败！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
}

//重置数据
-(IBAction)resetdata:(id)sender
{
    texturetext.text=nil;
    goldweightText.text=nil;
    miandiaText.text=nil;
    mianNoText.text=nil;
    fitDiaText.text=nil;
    fitNoText.text=nil;
    sizeText.text=nil;
    fontText.text=nil;
}
/////////////////////////////////////////以为图片上传位置/////////////////////////////////////////////////
//选择图片
- (IBAction)chooseImage:(id)sender {
    
    UIActionSheet *sheet;
    
    sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
    
    sheet.tag = 255;
    [sheet showInView:self.view];
    UIButton * btn=(UIButton *)sender;
    pictag=[btn tag];
}

#pragma mark - 保存图片至沙盒
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    
    // 将图片写入文件
    
    [imageData writeToFile:fullPath atomically:NO];
}

#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	[picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    NSString *fullPath =nil;
    //记录文件
    
    if (pictag==0) {
        [self saveImage:image withName:@"currentImage1.png"];
        
        fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage1.png"];
        pic1=fullPath;
    }
    else if (pictag==1)
    {
        [self saveImage:image withName:@"currentImage2.png"];
        
        fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage2.png"];
        pic2=fullPath;
    }
    else if (pictag==2){
        [self saveImage:image withName:@"currentImage3.png"];
        
        fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage3.png"];
        pic3=fullPath;
    }
    
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
    isFullScreen = NO;
    if (pictag==0) {
        [self.zhengmianview setImage:savedImage];
        
        self.zhengmianview.tag = 100;
    }else if (pictag==1)
    {
        [self.fanmianview setImage:savedImage];
        
        self.fanmianview.tag = 100;
    }else if (pictag==2){
        [self.cemianview setImage:savedImage];
        
        self.cemianview.tag = 100;
    }
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[self dismissViewControllerAnimated:YES completion:^{}];
}


#pragma mark - actionsheet delegate
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                case 0:
                    // 取消
                    return;
                case 1:
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                    
                case 2:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
                
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
        
    }
}

@end
