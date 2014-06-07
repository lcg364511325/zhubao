//
//  NoticeReportCell.h
//  dzqz
//
//  Created by 飞翔 on 13-10-22.
//  Copyright (c) 2013年 moko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoticeReportCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *showimage;

@property (strong, nonatomic) IBOutlet UILabel *notice;

@property (strong, nonatomic) IBOutlet UILabel *noticeDate;

@property (strong, nonatomic) IBOutlet UILabel *tuDate;

@property (strong, nonatomic) IBOutlet UILabel *Dia_Col;

@property (strong, nonatomic) IBOutlet UILabel *Dia_Clar;

@property (strong, nonatomic) IBOutlet UILabel *Dia_Cut;

@property (strong, nonatomic) IBOutlet UILabel *Dia_Price;

@property (strong, nonatomic) IBOutlet UILabel *Dia_Sym;

@property (strong, nonatomic) IBOutlet UILabel *Dia_Lab;

@property (strong, nonatomic) IBOutlet UILabel *chasinglable;

@property (strong, nonatomic) IBOutlet UILabel *teslable;

@end
