//
//  ViewController.m
//  YHPageViewController
//
//  Created by 林宁宁 on 2020/4/28.
//  Copyright © 2020 林宁宁. All rights reserved.
//

#import "ViewController.h"

#import "YHPageViewController1.h"
#import "YHPageViewController2.h"

@interface YHCellItem : NSObject

@property (copy, nonatomic) NSString * title;
@property (copy, nonatomic) NSString * subTitle;
/// cell点击
@property (copy, nonatomic) void(^clickBlock)(__kindof YHCellItem * passItem);

@end

@implementation YHCellItem

@end



@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (retain, nonatomic) UITableView * tableView;

@property (retain, nonatomic) NSMutableArray <YHCellItem *>* dataList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"PageViewController";
    [self.navigationController.navigationBar setTranslucent:NO];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 50;
    [self.view addSubview:self.tableView];
    
    self.dataList = [NSMutableArray new];
    
    __weak typeof(&*self)weakSelf = self;
    
    YHCellItem * item = [YHCellItem new];
    item.title = @"导航条下方";
    [item setClickBlock:^(__kindof YHCellItem *passItem) {
        UIViewController * vc = [YHPageViewController1 new];
        vc.title = passItem.title;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    [self.dataList addObject:item];
    
    
    item = [YHCellItem new];
    item.title = @"导航条上";
    [item setClickBlock:^(__kindof YHCellItem *passItem) {
        UIViewController * vc = [YHPageViewController2 new];
        vc.title = passItem.title;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    [self.dataList addObject:item];
    
    item = [YHCellItem new];
    item.title = @"滑动到第一页左滑返回";
    [item setClickBlock:^(__kindof YHCellItem *passItem) {
        UIViewController * vc = [NSClassFromString(@"YHPageViewController3") new];
        vc.title = passItem.title;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    [self.dataList addObject:item];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifyPage"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"CellIdentifyPage"];
    }
    
    cell.textLabel.text = self.dataList[indexPath.row].title;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YHCellItem * item = self.dataList[indexPath.row];
    
    if(item.clickBlock){
        item.clickBlock(item);
    }
}



@end
