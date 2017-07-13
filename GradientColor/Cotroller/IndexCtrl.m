//
//  IndexCtrl.m
//  GradientColor
//
//  Created by LOLITA on 2017/7/13.
//  Copyright © 2017年 LOLITA. All rights reserved.
//

#import "IndexCtrl.h"
#import "CAGradientLayerCtrl.h"
#import "GraphicsCtrl.h"

@interface IndexCtrl ()

@property (strong, nonatomic) NSArray *datas;

@end

@implementation IndexCtrl

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"渐变色";
    
    self.tableView.tableFooterView = [UIView new];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



// !!!: 数据初始化
-(NSArray *)datas{
    if (_datas==nil) {
        _datas = @[@[@[@"矩形渐变色",[CAGradientLayerCtrl class]],@[@"不规则渐变色",[CAGradientLayerCtrl class]]],
                   @[@[@"线性向渐变",[GraphicsCtrl class]],@[@"径向渐变",[GraphicsCtrl class]]]];
    }
    return _datas;
}






#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *items = self.datas[section];
    return items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"LOLITA";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = [self.datas[indexPath.section][indexPath.row] firstObject];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        CAGradientLayerCtrl *ctrl = [[self.datas[indexPath.section][indexPath.row] lastObject] new];
        ctrl.title = [self.datas[indexPath.section][indexPath.row] firstObject];
        [self.navigationController pushViewController:ctrl animated:YES];
    }
    else{
        GraphicsCtrl *ctrl = [[self.datas[indexPath.section][indexPath.row] lastObject] new];
        ctrl.title = [self.datas[indexPath.section][indexPath.row] firstObject];
        [self.navigationController pushViewController:ctrl animated:YES];
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSArray *titles = @[@"CAGradientLayer",@"Core_Graphics"];
    return titles[section];
}

@end
