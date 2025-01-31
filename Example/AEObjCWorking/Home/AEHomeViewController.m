//
//  AEHomeViewController.m
//  AEObjCWorking_Example
//
//  Created by Adonis_HongYang on 2020/1/7.
//  Copyright © 2020 HYAdonisCoding. All rights reserved.
//

#import "AEHomeViewController.h"

@interface AEHomeViewController ()

@end

@implementation AEHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    
}

- (NSArray *)getLocalJsonData:(NSString *)fileName {
    NSArray *array = @[];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    if (filePath != nil) {
        NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
        NSError *error = nil;
        id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
        
        if (error != nil) {
            NSLog(@"JSON解析出错: %@", error.localizedDescription);
        } else {
            if ([jsonObject isKindOfClass:[NSDictionary class]]) {
                NSDictionary *jsonDictionary = (NSDictionary *)jsonObject;
                // 在这里处理解析后的JSON数据
                array = [jsonDictionary objectForKey: @"home_data"];
            } else {
                NSLog(@"JSON数据不是一个字典");
            }
        }
    }
    return array;
}
#pragma mark -- Lazy Load

- (NSArray *)dataArray {
    if (!_dataArray) {
        // 首先查找本地json文件home_data
        NSArray *home_data = [self getLocalJsonData:@"home_data"];
        if (home_data.count > 0) {
            _dataArray = home_data;
        } else {
            _dataArray = @[@"AEPreviewPDFController",
                           @"AEPDFReaderViewController",
                           @"AEGPTViewController",
                           @"AEConvertRectViewController",
                           @"AEImageSetViewController",
                           @"AEFontsViewController",
                           @"AETabBarViewController",
                           @"AEKnowledgeViewController",
                           @"AEGifViewController",
                           @"AEGradientViewController",
                           @"AECustomTitleViewController",
                           @"AEFileOperationViewController",
                           @"AELifeViewController",
                           @"AEAddressViewController",
                           @"AEPlistViewController",
                           @"AEUnconventionalViewController",
                           @"AEOCKnowledgeViewController",
                           @"AEPopoverShowController",
                           @"AEHTMLParsingController",
                           @"AEIntelligentSortingController",
                           @"AEDynamicCardController",
                           @"AECustomOptioinController",
                           @"AECustomOptioinViewController",
                           @"AEMainTabBarController"];
        }
    }
    return _dataArray;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        UIView *footerView = [[UIView alloc] init];
        footerView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = footerView;
        
        //隐藏自带的分割线
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        // 设置tableView背景色
        _tableView.backgroundColor = [UIColor whiteColor];
        //估算高度
        _tableView.estimatedRowHeight = 150;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
            make.right.left.mas_equalTo(0);
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
        }];
    }
    return _tableView;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    NSString *string = self.dataArray[indexPath.row];
    if (string.length>14) {
        string = [string substringWithRange:NSMakeRange(2, string.length-12)];
    }
    cell.textLabel.text = string;
    cell.backgroundColor = ((indexPath.row%2) != 0) ? UIColor.cyanColor : UIColor.yellowColor;
    cell.textLabel.textColor = ((indexPath.row%2) != 0) ? UIColor.purpleColor : UIColor.magentaColor;
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *vc = [NSClassFromString(self.dataArray[indexPath.row]) new];
    if (vc) {
        NSString *string = self.dataArray[indexPath.row];
        string = [string substringWithRange:NSMakeRange(2, string.length-12)];
        vc.title = string;
        [self.navigationController pushViewController:vc animated:YES];
//        [self presentViewController:vc animated:YES completion:^{
//                    //
//        }];
    }
}
@end
