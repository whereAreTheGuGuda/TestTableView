//
//  TestTableView.m
//  TestTableView
//
//  Created by mac on 2017/2/9.
//  Copyright © 2017年 865288882@qq.com. All rights reserved.
//

#import <objc/runtime.h>
#import "TestTableView.h"

@interface TestTableView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSString *cellClassName;

@property (nonatomic, strong) UITableView *tab;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation TestTableView

-(id)initWithFrame:(CGRect)frame cellClassName:(NSString *)cellClassName dataArray:(NSMutableArray *)dataArray
{
    if (self) {
        self = [super initWithFrame:frame];
        _tab = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        _tab.delegate = self;
        _tab.dataSource = self;
        [self addSubview:_tab];
    }
    self.dataArray = dataArray;
    self.cellClassName = cellClassName;
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    Class cellClass = NSClassFromString(self.cellClassName);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellForRowAtIndexPath"];
    if (cell == nil) {
        cell = [[cellClass alloc] init];
    }
//    [TestTableView LogAllMethodsFromClass:cell];
    [cell performSelector:@selector(updateCellWith:) withObject:_dataArray[indexPath.row] afterDelay:0];
    return cell;
}

//+ (void)LogAllMethodsFromClass:(id)obj
//{
//    u_int count;
//    //class_copyMethodList 获取类的所有方法列表
//    Method *mothList_f = class_copyMethodList([obj class],&count) ;
//    for (int i = 0; i < count; i++) {
//        Method temp_f = mothList_f[i];
//        // method_getImplementation  由Method得到IMP函数指针
//        IMP imp_f = method_getImplementation(temp_f);
//        
//        // method_getName由Method得到SEL
//        SEL name_f = method_getName(temp_f);
//        
//        const char * name_s = sel_getName(name_f);
//        // method_getNumberOfArguments  由Method得到参数个数
//        int arguments = method_getNumberOfArguments(temp_f);
//        // method_getTypeEncoding  由Method得到Encoding 类型
//        const char * encoding = method_getTypeEncoding(temp_f);
//        
//        NSLog(@"方法名：%@\n,参数个数：%d\n,编码方式：%@\n",[NSString stringWithUTF8String:name_s],
//              arguments,[NSString stringWithUTF8String:encoding]);
//    }
//    free(mothList_f);
//    
//}
//

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
