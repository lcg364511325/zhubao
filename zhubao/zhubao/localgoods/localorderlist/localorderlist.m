//
//  localorderlist.m
//  zhubao
//
//  Created by johnson on 14-9-25.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "localorderlist.h"
#import "proclassEntity.h"

@interface localorderlist ()

@end

@implementation localorderlist

@synthesize primaryView;
@synthesize primaryShadeView;
@synthesize secondShadeView;
@synthesize mainlist=_mainlist;
@synthesize mainmanlist;
@synthesize netlist=_netlist;
@synthesize colorlist=_colorlist;
@synthesize texturelist=_texturelist;
@synthesize productcollect;
@synthesize countLable;
@synthesize btntexture;
@synthesize btninlay;
@synthesize btnseric;


//查询结果
NSMutableArray *resultlist=nil;

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
    [self.navigationController setNavigationBarHidden:YES];
    
    [self.productcollect registerClass:[ProductCell class] forCellWithReuseIdentifier:@"ProductCell"];
    stylearray = [[NSMutableArray alloc] init];
    texturearray = [[NSMutableArray alloc] init];
    inlayarray = [[NSMutableArray alloc] init];
    seriearray = [[NSMutableArray alloc] init];
    btnarray1 = [[NSMutableArray alloc] init];
    btnarray2 = [[NSMutableArray alloc] init];
    btnarray3 = [[NSMutableArray alloc] init];
    btnarray4 = [[NSMutableArray alloc] init];
    countLable.text=nil;
    
    //进来时候加载全部数据
    sqlService *sql=[[sqlService alloc]init];
    resultlist=[sql GetLocalProductList:nil type2:nil type3:nil type4:nil page:1 pageSize:1500];
    
    //加载类别
    [self loadproclass];
    
}


//加载类别
-(void)loadproclass
{
    NSMutableArray *proclassarray=[NSMutableArray arrayWithCapacity:1];
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    
    proclassEntity *entity=[[proclassEntity alloc]init];
    entity.Id=@"0";
    entity.name=@"全部";
    entity.uId=myDelegate.entityl.uId;
    [proclassarray addObject:entity];
    
    sqlService *_sqlService=[[sqlService alloc]init];
    NSArray *classlist=[_sqlService GetProclassList:myDelegate.entityl.uId page:1 pageSize:1500];
    [proclassarray addObjectsFromArray:classlist];
    
    int i;
    int count=[proclassarray count];
    UIButton *btn;
    UIImageView *endimg;
    UIImageView *lineimg;
    for (i=0; i<count; i++) {
        if (i==(count-1)) {
            btn=[[UIButton alloc]initWithFrame:CGRectMake(58.5+i*58, 7, 57, 29.5)];
            endimg=[[UIImageView alloc]initWithFrame:CGRectMake(btn.frame.origin.x+57, 7, 3, 29.5)];
            endimg.image=[UIImage imageNamed:@"proclass_end"];
            [self.view addSubview:endimg];
        }else{
            btn=[[UIButton alloc]initWithFrame:CGRectMake(58.5+i*58, 7, 57, 29.5)];
            lineimg=[[UIImageView alloc]initWithFrame:CGRectMake(btn.frame.origin.x+57, 7, 1, 29.5)];
            lineimg.image=[UIImage imageNamed:@"proclass_line"];
            [self.view addSubview:lineimg];
        }
        
        proclassEntity *dict=[proclassarray objectAtIndex:i];
        
        
        btn.titleLabel.font=[UIFont boldSystemFontOfSize:12.0f];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:dict.name forState:UIControlStateNormal];
        if (i==0) {
            [btn setBackgroundImage:[UIImage imageNamed:@"proclass_sed"] forState:UIControlStateNormal];
            btnstyle=btn;
            btn.tag=0;
        }else{
            [btn setBackgroundImage:[UIImage imageNamed:@"proclass_bg"] forState:UIControlStateNormal];
            btn.tag=[dict.Id integerValue];
        }
        [btn addTarget:self action:@selector(styleselect:) forControlEvents:UIControlEventTouchDown];
        
        [self.view addSubview:btn];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)closeAction
{
    if (self.popupViewController != nil) {
        [self dismissPopupViewControllerAnimated:YES completion:^{
            NSLog(@"popup view dismissed");
        }];
    }
}

-(void)closesc{
    if (self.popupViewController != nil) {
        [self dismissPopupViewControllerAnimated:YES completion:^{
            NSLog(@"popup view dismissed");
        }];
    }
}

-(void)rotateStart{
    [rImageView setRotate:TRUE];
}

-(void)rotateStop{
    [rImageView setRotate:FALSE];
}

//款式选择
-(void)styleselect:(UIButton *)btn
{
    countLable.text=nil;
    NSInteger btntag=[btn tag];
    NSString * style=nil;
    if (btntag==0) {
        for (UIButton * btn1 in btnarray1) {
            [btn1 setBackgroundImage:[UIImage imageNamed:@"proclass_bg"] forState:UIControlStateNormal];
        }
        [btnarray1 removeAllObjects];
        [stylearray removeAllObjects];
        [btn setBackgroundImage:[UIImage imageNamed:@"proclass_sed"] forState:UIControlStateNormal];
    }else{
        [btn setBackgroundImage:[UIImage imageNamed:@"proclass_sed"] forState:UIControlStateNormal];
        style=[NSString stringWithFormat:@"%d",btntag];
    }
    if (btntag!=0) {
        [btnstyle setBackgroundImage:[UIImage imageNamed:@"proclass_bg"] forState:UIControlStateNormal];
    }
    [btnarray1 addObject:btn];
    if (style) {
        NSUInteger len=[stylearray count];
        NSUInteger i;
        BOOL isequal=NO;
        for (i=0; i<len; i++) {
            NSString * value=[stylearray objectAtIndex:i];
            isequal = [style isEqualToString:value];
            if (isequal) {
                [stylearray removeObjectAtIndex:i];
                [btn setBackgroundImage:[UIImage imageNamed:@"proclass_bg"] forState:UIControlStateNormal];
                i=len;
            }
        }
        if (!isequal) {
            [stylearray addObject:style];
        }
    }
    //款式
    NSMutableString *styleindex=[[NSMutableString alloc] init];
    for (NSString *index in stylearray) {
        if (styleindex.length!=0) {
            [styleindex appendString:@","];
            [styleindex appendString:index];
        }else{
            [styleindex appendString:index];
        }
    }
    //材质
    NSMutableString *textrueindex=[[NSMutableString alloc] init];
    for (NSString *index in texturearray) {
        if (textrueindex.length!=0) {
            [textrueindex appendString:@","];
            [textrueindex appendString:index];
        }else{
            [textrueindex appendString:index];
        }
    }
    //镶口
    NSMutableString *inlayindex=[[NSMutableString alloc] init];
    for (NSString *index in inlayarray) {
        if (inlayindex.length!=0) {
            [inlayindex appendString:@","];
            [inlayindex appendString:index];
        }else{
            [inlayindex appendString:index];
        }
    }
    //系列
    NSMutableString *serieindex=[[NSMutableString alloc] init];
    for (NSString *index in seriearray) {
        if (serieindex.length!=0) {
            [serieindex appendString:@" or "];
            [serieindex appendString:index];
        }else{
            [serieindex appendString:index];
        }
    }
    
    NSString * serieindexs=serieindex;
    if([seriearray count]>1)serieindexs=[NSString stringWithFormat:@"(%@)",serieindex];
    
    resultlist = [NSMutableArray arrayWithCapacity:10];
    [productcollect reloadData];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作（异步操作）
        sqlService *sql=[[sqlService alloc]init];
        resultlist=[sql GetLocalProductList:styleindex type2:textrueindex type3:inlayindex type4:serieindexs page:1 pageSize:1500];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [productcollect reloadData];
        });
    });
    
}


//材质选择
-(IBAction)textureselect:(id)sender
{
    countLable.text=nil;
    UIButton* btn = (UIButton*)sender;
    NSInteger btntag=[btn tag];
    NSString *texture=nil;
    if (btntag==0) {
        for (UIButton * btn2 in btnarray2) {
            [btn2 setBackgroundImage:nil forState:UIControlStateNormal];
        }
        [btnarray2 removeAllObjects];
        [texturearray removeAllObjects];
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==1){
        texture=@"1";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==2){
        texture=@"2";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==3){
        texture=@"3";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==4){
        texture=@"4";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==5){
        texture=@"5";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==6){
        texture=@"6";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==7){
        texture=@"7";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }
    [btnarray2 addObject:btn];
    if (btntag!=0) {
        [btntexture setBackgroundImage:nil forState:UIControlStateNormal];
    }
    if (texture) {
        NSUInteger len=[texturearray count];
        NSUInteger i;
        BOOL isequal=NO;
        for (i=0; i<len; i++) {
            NSString * value=[texturearray objectAtIndex:i];
            isequal = [texture isEqualToString:value];
            if (isequal) {
                [texturearray removeObjectAtIndex:i];
                [btn setBackgroundImage:nil forState:UIControlStateNormal];
                i=len;
            }
        }
        if (!isequal) {
            [texturearray addObject:texture];
        }
    }
    //款式
    NSMutableString *styleindex=[[NSMutableString alloc] init];
    for (NSString *index in stylearray) {
        if (styleindex.length!=0) {
            [styleindex appendString:@","];
            [styleindex appendString:index];
        }else{
            [styleindex appendString:index];
        }
    }
    //材质
    NSMutableString *textrueindex=[[NSMutableString alloc] init];
    for (NSString *index in texturearray) {
        if (textrueindex.length!=0) {
            [textrueindex appendString:@","];
            [textrueindex appendString:index];
        }else{
            [textrueindex appendString:index];
        }
    }
    //镶口
    NSMutableString *inlayindex=[[NSMutableString alloc] init];
    for (NSString *index in inlayarray) {
        if (inlayindex.length!=0) {
            [inlayindex appendString:@","];
            [inlayindex appendString:index];
        }else{
            [inlayindex appendString:index];
        }
    }
    //系列
    NSMutableString *serieindex=[[NSMutableString alloc] init];
    for (NSString *index in seriearray) {
        if (serieindex.length!=0) {
            [serieindex appendString:@" or "];
            [serieindex appendString:index];
        }else{
            [serieindex appendString:index];
        }
    }
    
    NSString * serieindexs=serieindex;
    if([seriearray count]>1)serieindexs=[NSString stringWithFormat:@"(%@)",serieindex];
    
    resultlist = [NSMutableArray arrayWithCapacity:10];
    [productcollect reloadData];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作（异步操作）
        sqlService *sql=[[sqlService alloc]init];
        resultlist=[sql GetLocalProductList:styleindex type2:textrueindex type3:inlayindex type4:serieindexs page:1 pageSize:1500];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [productcollect reloadData];
        });
    });
}

//镶口选择
-(IBAction)inlayselect:(id)sender
{
    countLable.text=nil;
    UIButton* btn = (UIButton*)sender;
    NSInteger btntag=[btn tag];
    NSString *inlay=nil;
    if (btntag==0) {
        for (UIButton * btn3 in btnarray3) {
            [btn3 setBackgroundImage:nil forState:UIControlStateNormal];
        }
        [btnarray3 removeAllObjects];
        [inlayarray removeAllObjects];
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==1){
        inlay=@"0.00-0.02";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==2){
        inlay=@"0.03-0.07";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==3){
        inlay=@"0.08-0.12";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==4){
        inlay=@"0.13-0.17";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==5){
        inlay=@"0.18-0.22";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==6){
        inlay=@"0.23-0.28";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==7){
        inlay=@"0.29-0.39";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==8){
        inlay=@"0.40-0.49";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==9){
        inlay=@"0.50-0.59";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==10){
        inlay=@"0.60-0.69";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==11){
        inlay=@"0.70-0.69";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==12){
        inlay=@"0.80-0.69";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==13){
        inlay=@"0.90-0.69";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==14){
        inlay=@"1-100000";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }
    [btnarray3 addObject:btn];
    if (btntag!=0) {
        [btninlay setBackgroundImage:nil forState:UIControlStateNormal];
    }
    if (inlay) {
        NSUInteger len=[inlayarray count];
        NSUInteger i;
        BOOL isequal=NO;
        for (i=0; i<len; i++) {
            NSString * value=[inlayarray objectAtIndex:i];
            isequal = [inlay isEqualToString:value];
            if (isequal) {
                [inlayarray removeObjectAtIndex:i];
                [btn setBackgroundImage:nil forState:UIControlStateNormal];
                i=len;
            }
        }
        if (!isequal) {
            [inlayarray addObject:inlay];
        }
    }
    //款式
    NSMutableString *styleindex=[[NSMutableString alloc] init];
    for (NSString *index in stylearray) {
        if (styleindex.length!=0) {
            [styleindex appendString:@","];
            [styleindex appendString:index];
        }else{
            [styleindex appendString:index];
        }
    }
    //材质
    NSMutableString *textrueindex=[[NSMutableString alloc] init];
    for (NSString *index in texturearray) {
        if (textrueindex.length!=0) {
            [textrueindex appendString:@","];
            [textrueindex appendString:index];
        }else{
            [textrueindex appendString:index];
        }
    }
    //镶口
    NSMutableString *inlayindex=[[NSMutableString alloc] init];
    for (NSString *index in inlayarray) {
        if (inlayindex.length!=0) {
            [inlayindex appendString:@","];
            [inlayindex appendString:index];
        }else{
            [inlayindex appendString:index];
        }
    }
    //系列
    NSMutableString *serieindex=[[NSMutableString alloc] init];
    for (NSString *index in seriearray) {
        if (serieindex.length!=0) {
            [serieindex appendString:@" or "];
            [serieindex appendString:index];
        }else{
            [serieindex appendString:index];
        }
    }
    
    NSString * serieindexs=serieindex;
    if([seriearray count]>1)serieindexs=[NSString stringWithFormat:@"(%@)",serieindex];
    
    resultlist = [NSMutableArray arrayWithCapacity:10];
    [productcollect reloadData];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作（异步操作）
        sqlService *sql=[[sqlService alloc]init];
        resultlist=[sql GetLocalProductList:styleindex type2:textrueindex type3:inlayindex type4:serieindexs page:1 pageSize:1500];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [productcollect reloadData];
        });
    });
}

//系列
-(IBAction)serie:(id)sender
{
    countLable.text=nil;
    UIButton* btn = (UIButton*)sender;
    NSInteger btntag=[btn tag];
    NSString * serie=nil;
    if (btntag==1) {
        serie=@"Pro_f_pair='true'";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if(btntag==2){
        serie=@"Pro_hotE=1";
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }else if (btntag==0){
        for (UIButton * btn4 in btnarray4) {
            [btn4 setBackgroundImage:nil forState:UIControlStateNormal];
        }
        [btnarray4 removeAllObjects];
        [seriearray removeAllObjects];
        [btn setBackgroundImage:[UIImage imageNamed:@"options_sedBg"] forState:UIControlStateNormal];
    }
    [btnarray4 addObject:btn];
    if (btntag!=0) {
        [btnseric setBackgroundImage:nil forState:UIControlStateNormal];
    }
    if (serie) {
        NSUInteger len=[seriearray count];
        NSUInteger i;
        BOOL isequal=NO;
        for (i=0; i<len; i++) {
            NSString * value=[seriearray objectAtIndex:i];
            isequal = [serie isEqualToString:value];
            if (isequal) {
                [seriearray removeObjectAtIndex:i];
                [btn setBackgroundImage:nil forState:UIControlStateNormal];
                i=len;
            }
        }
        if (!isequal) {
            [seriearray addObject:serie];
        }
    }
    //款式
    NSMutableString *styleindex=[[NSMutableString alloc] init];
    for (NSString *index in stylearray) {
        if (styleindex.length!=0) {
            [styleindex appendString:@","];
            [styleindex appendString:index];
        }else{
            [styleindex appendString:index];
        }
    }
    //材质
    NSMutableString *textrueindex=[[NSMutableString alloc] init];
    for (NSString *index in texturearray) {
        if (textrueindex.length!=0) {
            [textrueindex appendString:@","];
            [textrueindex appendString:index];
        }else{
            [textrueindex appendString:index];
        }
    }
    //镶口
    NSMutableString *inlayindex=[[NSMutableString alloc] init];
    for (NSString *index in inlayarray) {
        if (inlayindex.length!=0) {
            [inlayindex appendString:@","];
            [inlayindex appendString:index];
        }else{
            [inlayindex appendString:index];
        }
    }
    //系列
    NSMutableString *serieindex=[[NSMutableString alloc] init];
    for (NSString *index in seriearray) {
        if (serieindex.length!=0) {
            [serieindex appendString:@" or "];
            [serieindex appendString:index];
        }else{
            [serieindex appendString:index];
        }
    }
    NSString * serieindexs=serieindex;
    if([seriearray count]>1)serieindexs=[NSString stringWithFormat:@"(%@)",serieindex];
    
    resultlist = [NSMutableArray arrayWithCapacity:10];
    [productcollect reloadData];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作（异步操作）
        sqlService *sql=[[sqlService alloc]init];
        resultlist=[sql GetLocalProductList:styleindex type2:textrueindex type3:inlayindex type4:serieindexs page:1 pageSize:1500];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [productcollect reloadData];
        });
    });
}

//搜索结果数目
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [resultlist count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProductCell *cell = (ProductCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ProductCell" forIndexPath:indexPath];
    productEntity *entity=[resultlist objectAtIndex:[indexPath row]];
    NSString *count=[NSString stringWithFormat:@"%lu",(unsigned long)[resultlist count]];
    countLable.text=[[@"共有首饰" stringByAppendingString:count] stringByAppendingString:@"件"];
    
    //    NSString *url1=pathInDocumentDirectory([NSString stringWithFormat:@"images/%@%@",entity.Pro_author,@"_001.jpg"]);
    //    if ([[NSFileManager defaultManager] fileExistsAtPath:url1]) {
    //        cell.productImage.image=[UIImage imageWithContentsOfFile:url1];
    //    }else{
    if ([entity.producttype isEqualToString:@"1"]) {
        cell.productImage.image=[[UIImage alloc] initWithContentsOfFile:entity.Pro_smallpic];
    }else{
        NSURL *imgUrl=[NSURL URLWithString:[NSString stringWithFormat:@"http://seyuu.com%@",entity.Pro_smallpic]];
        if (hasCachedImage(imgUrl)) {
            cell.productImage.image=[UIImage imageWithContentsOfFile:pathForURL(imgUrl)];
        }else
        {
            cell.productImage.image=[UIImage imageNamed:@""];
            NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:imgUrl,@"url",cell.productImage,@"imageView",nil];
            [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
            
        }
    }
    
    //    }
    cell.show3dImage.hidden=NO;
    if (![self isexistsfile:entity.Pro_author]) {
        cell.show3dImage.hidden=YES;
    }
    
    cell.productLable.text = entity.Pro_model;
    return cell;
}

//点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    productEntity *entity = [resultlist objectAtIndex:[indexPath row]];
    prodeuctDetail *prodeuctDetailcontroller = [[prodeuctDetail alloc] initWithNibName:@"prodeuctDetail" bundle:nil];
    prodeuctDetailcontroller.mydelegate=self.parentViewController.self;
    prodeuctDetailcontroller.proid=entity.Id;
    
    [self.parentViewController.self presentPopupViewController:prodeuctDetailcontroller animated:YES completion:^(void) {
        NSLog(@"popup view presented");
    }];
}

//保留小数位数
-(NSString *)notRounding:(float)price afterPoint:(int)position{
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    
    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:price];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [NSString stringWithFormat:@"%@",roundedOunces];
}

-(BOOL)isexistsfile:(NSString *)Pro_author
{
    BOOL isshow=FALSE;
    for(int i=1;i<60;i++){
        NSString *strApend;
        if(i<9)
            strApend=@"00";
        else
            strApend=@"0";
        
        NSString *path = [NSString stringWithFormat:@"%@_%@%d.jpg",Pro_author, strApend,i];
        NSLog(@"%@", path);
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *dcoumentpath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
        // 解压缩文件夹路径
        NSString* unzipPath = [dcoumentpath stringByAppendingString:@"/images"];
        if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/%@",unzipPath,path]]) {
            isshow=TRUE;
            break;
        }
    }
    
    return isshow;
}

-(void)reloaddata
{
    //款式
    NSMutableString *styleindex=[[NSMutableString alloc] init];
    for (NSString *index in stylearray) {
        if (styleindex.length!=0) {
            [styleindex appendString:@","];
            [styleindex appendString:index];
        }else{
            [styleindex appendString:index];
        }
    }
    //材质
    NSMutableString *textrueindex=[[NSMutableString alloc] init];
    for (NSString *index in texturearray) {
        if (textrueindex.length!=0) {
            [textrueindex appendString:@","];
            [textrueindex appendString:index];
        }else{
            [textrueindex appendString:index];
        }
    }
    //镶口
    NSMutableString *inlayindex=[[NSMutableString alloc] init];
    for (NSString *index in inlayarray) {
        if (inlayindex.length!=0) {
            [inlayindex appendString:@","];
            [inlayindex appendString:index];
        }else{
            [inlayindex appendString:index];
        }
    }
    //系列
    NSMutableString *serieindex=[[NSMutableString alloc] init];
    for (NSString *index in seriearray) {
        if (serieindex.length!=0) {
            [serieindex appendString:@" or "];
            [serieindex appendString:index];
        }else{
            [serieindex appendString:index];
        }
    }
    NSString * serieindexs=serieindex;
    if([seriearray count]>1)serieindexs=[NSString stringWithFormat:@"(%@)",serieindex];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作（异步操作）
        sqlService *sql=[[sqlService alloc]init];
        resultlist=[sql GetLocalProductList:styleindex type2:textrueindex type3:inlayindex type4:serieindexs page:1 pageSize:1500];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [productcollect reloadData];
        });
    });
}

-(void)refleshBuycutData
{
    
    sqlService *sql=[[sqlService alloc]init];
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    myDelegate.entityl.resultcount=[sql getBuyproductcount:myDelegate.entityl.uId];
    
    sqlService *shopcar=[[sqlService alloc] init];
    shoppingcartlist=[shopcar GetBuyproductList:myDelegate.entityl.uId];
    shopcart *scg=[[shopcart alloc]init];
    [scg reloadshopcart];
    
}

@end
