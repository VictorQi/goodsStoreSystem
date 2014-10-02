//
//  MyCell.m
//  goodsManagementSystem
//
//  Created by victor on 14-9-29.
//  Copyright (c) 2014年 victor_qi. All rights reserved.
//

#import "MyCell.h"

@implementation MyCell


- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 65)];
        _label.backgroundColor = [UIColor greenColor];
        // 字体大小
        _label.font = [UIFont systemFontOfSize:15.0];
        // 不限制行数
        _label.numberOfLines = 0;
        // 换行模式
        _label.lineBreakMode = NSLineBreakByCharWrapping;
        [self.contentView addSubview:_label];
    }
    return self;
}

- (void) setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x +=10;
    frame.size.width -= 2*10;
    [super setFrame:frame];
}




@end
