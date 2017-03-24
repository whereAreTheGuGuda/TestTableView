//
//  TestTableView.h
//  TestTableView
//
//  Created by mac on 2017/2/9.
//  Copyright © 2017年 865288882@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestTableView : UIView
/**
 生成tableview
 frame:tableview的frame
 cellClassName:cell的类名 
 dataArray:数据数组
 updateFunctionKeyWord:cell中加载方法的统一标识符（项目中使用的cell都必须以同一标识符为方法开头  如update）
 */

-(id)initWithFrame:(CGRect)frame cellClassName:(NSString *)cellClassName dataArray:(NSMutableArray *)dataArray updateFunctionKeyWord:(NSString *)updateFunctionKeyWord;

@end
