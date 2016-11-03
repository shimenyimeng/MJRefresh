//
//  ViewController.m
//  017-  MJRefresh
//
//  Created by mac on 16/10/25.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import <MJRefresh.h>

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@end

NSString *cellIdentifier = @"cellIdentifier";
@implementation ViewController {
    
    NSMutableArray *_dataListArr;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    [self.view addSubview:tableView];
    
    _dataListArr = [NSMutableArray array];
    for (NSInteger i = 0; i < 10; i++) {
        
        NSString *str = [NSString stringWithFormat:@"%zd", arc4random_uniform(100)];
        [_dataListArr addObject:str];
        
    }
    NSLog(@"---%@", _dataListArr);
    
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        NSLog(@"正在刷新，加载更多数据");
        
        for (NSInteger i = 0; i < 10; i++) {
            
            NSString *str = [NSString stringWithFormat:@"%zd", arc4random_uniform(100)];
            [_dataListArr addObject:str];
            
        }
        
        [tableView reloadData];
        
        // 停止转动
        [tableView.mj_header endRefreshing];
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataListArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = _dataListArr[indexPath.row];
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
