//
//  WCTestTableViewCell.m
//  TestTableView
//
//  Created by mac on 2017/2/9.
//  Copyright © 2017年 865288882@qq.com. All rights reserved.
//

#import "WCTestTableViewCell.h"

@interface WCTestTableViewCell ()

@property (nonatomic, strong) UILabel *titleLable;

@end

@implementation WCTestTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self) {
        self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
        
        _titleLable = [[UILabel alloc] init];
        [self addSubview:_titleLable];
    }
    return self;
}

-(void)updateCellWith:(NSString *)title
{
    [_titleLable setText:title];
    [_titleLable sizeToFit];
    [_titleLable setCenter:self.center];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
