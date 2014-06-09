//
//  test.h
//  zhubao
//
//  Created by johnson on 14-5-31.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductCell.h"

@interface test : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate> 
@property (weak, nonatomic) IBOutlet UICollectionView *productCollection;

@end
