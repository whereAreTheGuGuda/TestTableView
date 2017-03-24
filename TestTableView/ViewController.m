//
//  ViewController.m
//  TestTableView
//
//  Created by mac on 2017/2/9.
//  Copyright © 2017年 865288882@qq.com. All rights reserved.
//

#import "ViewController.h"
#import "TestTableView.h"
#import "UIView+BSHelper.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *array = @[@"aaa",@"bbb"];
    
    TestTableView *test = [[TestTableView alloc] initWithFrame:CGRectMake(0, 0, 500, 500) cellClassName:@"WCTestTableViewCell" dataArray:[NSMutableArray arrayWithArray:array] updateFunctionKeyWord:@"update"];
    [self.view addSubview:test];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
