//
//  LocalGoodslist.m
//  zhubao
//
//  Created by johnson on 14-7-16.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "LocalGoodslist.h"

@interface LocalGoodslist ()

@end

@implementation LocalGoodslist

@synthesize productcollect;
@synthesize countLable;
@synthesize btnstyle;
@synthesize btntexture;
@synthesize btninlay;
@synthesize btnseric;

//查询结果
NSMutableArray *list=nil;


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
    stylearray = [[NSMutableArray alloc] init];
    texturearray = [[NSMutableArray alloc] init];
    inlayarray = [[NSMutableArray alloc] init];
    seriearray = [[NSMutableArray alloc] init];
    btnarray1 = [[NSMutableArray alloc] init];
    btnarray2 = [[NSMutableArray alloc] init];
    btnarray3 = [[NSMutableArray alloc] init];
    btnarray4 = [[NSMutableArray alloc] init];
    [self.productcollect registerClass:[ProductCell class] forCellWithReuseIdentifier:@"ProductCell"];
    // Do any additional setup after loading the view from its nib.
}

//款式选择
-(IBAction)styleselect:(id)sender
{
    countLable.text=nil;
    UIButton* btn = (UIButton*)sender;
    NSInteger btntag=[btn tag];
    NSString * style=nil;
    if (btntag==0) {
        for (UIButton * btn1 in btnarray1) {
            [btn1 setBackgroundImage:nil forState:UIControlStateNormal];
        }
        [btnarray1 removeAllObjects];
        [stylearray removeAllObjects];
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==1){
        style=@"1";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==2){
        style=@"2";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==3){
        style=@"3";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==4){
        style=@"4";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==5){
        style=@"5";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==6){
        style=@"6";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==7){
        style=@"7";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==8){
        style=@"8";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==9){
        style=@"9";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }
    if (btntag!=0) {
        [btnstyle setBackgroundImage:nil forState:UIControlStateNormal];
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
                [btn setBackgroundImage:nil forState:UIControlStateNormal];
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
            [serieindex appendString:@","];
            [serieindex appendString:index];
        }else{
            [serieindex appendString:index];
        }
    }
    
    list = [NSMutableArray arrayWithCapacity:10];
    [productcollect reloadData];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作（异步操作）
        sqlService *sql=[[sqlService alloc]init];
        list=[sql GetProductList:styleindex type2:textrueindex type3:inlayindex type4:serieindex page:1 pageSize:1500];
        
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
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==1){
        texture=@"1";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==2){
        texture=@"2";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==3){
        texture=@"3";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==4){
        texture=@"4";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==5){
        texture=@"5";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==6){
        texture=@"6";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==7){
        texture=@"7";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
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
            [serieindex appendString:@","];
            [serieindex appendString:index];
        }else{
            [serieindex appendString:index];
        }
    }
    
    list = [NSMutableArray arrayWithCapacity:10];
    [productcollect reloadData];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作（异步操作）
        sqlService *sql=[[sqlService alloc]init];
        list=[sql GetProductList:styleindex type2:textrueindex type3:inlayindex type4:serieindex page:1 pageSize:1500];
        
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
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==1){
        inlay=@"0.00-0.02";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==2){
        inlay=@"0.03-0.07";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==3){
        inlay=@"0.08-0.12";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==4){
        inlay=@"0.13-0.17";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==5){
        inlay=@"0.18-0.22";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==6){
        inlay=@"0.23-0.28";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==7){
        inlay=@"0.29-0.39";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==8){
        inlay=@"0.40-0.49";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==9){
        inlay=@"0.50-0.59";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==10){
        inlay=@"0.60-0.69";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==11){
        inlay=@"0.70-0.69";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==12){
        inlay=@"0.80-0.69";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==13){
        inlay=@"0.90-0.69";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==14){
        inlay=@"1-100000";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
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
            [serieindex appendString:@","];
            [serieindex appendString:index];
        }else{
            [serieindex appendString:index];
        }
    }
    
    list = [NSMutableArray arrayWithCapacity:10];
    [productcollect reloadData];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作（异步操作）
        sqlService *sql=[[sqlService alloc]init];
        list=[sql GetProductList:styleindex type2:textrueindex type3:inlayindex type4:serieindex page:1 pageSize:1500];
        
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
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if(btntag==2){
        serie=@"Pro_hotE=1";
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
    }else if (btntag==0){
        for (UIButton * btn4 in btnarray4) {
            [btn4 setBackgroundImage:nil forState:UIControlStateNormal];
        }
        [btnarray4 removeAllObjects];
        [seriearray removeAllObjects];
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowcolor"] forState:UIControlStateNormal];
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
    
    list = [NSMutableArray arrayWithCapacity:10];
    [productcollect reloadData];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作（异步操作）
        sqlService *sql=[[sqlService alloc]init];
        list=[sql GetProductList:styleindex type2:textrueindex type3:inlayindex type4:serieindexs page:1 pageSize:1500];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [productcollect reloadData];
        });
    });
}

//搜索结果数目
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [list count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProductCell *cell = (ProductCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ProductCell" forIndexPath:indexPath];
    productEntity *entity=[list objectAtIndex:[indexPath row]];
    NSString *count=[NSString stringWithFormat:@"%lu",(unsigned long)[list count]];
    countLable.text=[[@"共有首饰" stringByAppendingString:count] stringByAppendingString:@"件"];
    
    //    NSString *url1=pathInDocumentDirectory([NSString stringWithFormat:@"images/%@%@",entity.Pro_author,@"_001.jpg"]);
    //    if ([[NSFileManager defaultManager] fileExistsAtPath:url1]) {
    //        cell.productImage.image=[UIImage imageWithContentsOfFile:url1];
    //    }else{
    NSURL *imgUrl=[NSURL URLWithString:[NSString stringWithFormat:@"http://seyuu.com%@",entity.Pro_smallpic]];
    if (hasCachedImage(imgUrl)) {
        cell.productImage.image=[UIImage imageWithContentsOfFile:pathForURL(imgUrl)];
    }else
    {
        cell.productImage.image=[UIImage imageNamed:@""];
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:imgUrl,@"url",cell.productImage,@"imageView",nil];
        [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
        
    }
    //    }
    
    cell.productLable.text = entity.Pro_model;
    return cell;
}

//点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
