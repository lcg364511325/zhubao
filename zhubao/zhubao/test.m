//
//  test.m
//  zhubao
//
//  Created by johnson on 14-5-31.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "test.h"

@interface test ()

@end

@implementation test

@synthesize productCollection;

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
    [self.productCollection registerClass:[ProductCell class] forCellWithReuseIdentifier:@"ProductCell"];

}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 16;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProductCell *cell = (ProductCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ProductCell" forIndexPath:indexPath];
    
    //NSString *imageToLoad = [NSString stringWithFormat:@"image.png", indexPath.row];
    
    cell.productImage.image = [UIImage imageNamed:@"image"];
    
    cell.productLable.text = @"aaaaa";
    
    return cell;
}



@end
