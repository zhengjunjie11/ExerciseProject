//
//  AutoCellHeightVC.m
//  ExerciseProject
//
//  Created by 天空吸引我 on 2018/10/10.
//  Copyright © 2018年 天空吸引我. All rights reserved.
//

#import "AutoCellHeightVC.h"
#import "AutoHeightCell.h"
#import "CTFrameParserConfig.h"
#import "CTFrameParser.h"
#import "CoreTextData.h"
#import "YYFPSLabel.h"

@interface AutoCellHeightVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_dataArray;
}
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic, strong) YYFPSLabel *fpsLabel;

@end

static NSString *CellName = @"AutoHeightCell";

@implementation AutoCellHeightVC

- (instancetype)init {
    if ([super init]) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return self;
}
- (void)viewDidLoad {

    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.view addSubview:self.tableView];
    [self readData];
     [self testFPSLabel];
}
- (void)testFPSLabel {
    _fpsLabel = [YYFPSLabel new];
    _fpsLabel.frame = CGRectMake(200, 200, 50, 30);
    [_fpsLabel sizeToFit];
    [self.view addSubview:_fpsLabel];

    // 如果直接用 self 或者 weakSelf，都不能解决循环引用问题

    // 移除也不能使 label里的 timer invalidate
    //        [_fpsLabel removeFromSuperview];
}
- (void)readData {

    NSString *path = [[NSBundle mainBundle] pathForResource:@"content" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];

    _dataArray = [NSJSONSerialization JSONObjectWithData:data
                                                     options:NSJSONReadingAllowFragments
                                                       error:nil];
    [_tableView reloadData];

}

- (UITableView *)tableView {
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView registerClass:[AutoHeightCell class] forCellReuseIdentifier:CellName];
        _tableView.estimatedRowHeight = 55.5;//估算高度
        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    AutoHeightCell *cell = [tableView dequeueReusableCellWithIdentifier:CellName forIndexPath:indexPath];

    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

    NSDictionary *dict = _dataArray[indexPath.row];
    AutoHeightCell *zcell = (AutoHeightCell *)cell;
    [zcell setTitle:dict[@"nickname"] contentText:dict[@"describe"] headimg:dict[@"headimg"] imageArray:dict[@"img"]];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {


    NSDictionary *dict = _dataArray[indexPath.row];
    CTFrameParserConfig *config = [[CTFrameParserConfig alloc] init];
    config.width = 300;
    config.textColor = [UIColor blackColor];

    NSDictionary *attr = [CTFrameParser attributesWithConfig:config];
    NSMutableAttributedString *attributedString =
    [[NSMutableAttributedString alloc] initWithString:dict[@"describe"]
                                           attributes:attr];
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:[UIColor redColor]
                             range:NSMakeRange(0, 7)];
    CoreTextData *data = [CTFrameParser parseAttributedContent:attributedString
                                                        config:config];

    return data.height+45;
}
/*
 "headimg" :"football",
 "nickname" : "Wilamowitz",
 "describe" : "更进一步地，实际工作中，我们更希望通过一个排版文件，来设置需要排版的文字的 ",
 "img" : ["football","zjj_photo"],
 */


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
