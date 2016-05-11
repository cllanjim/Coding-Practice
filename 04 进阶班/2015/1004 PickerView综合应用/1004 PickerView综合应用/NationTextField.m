//
//  NationTextField.m
//  1004 PickerView综合应用
//
//  Created by 张思琦 on 15/10/11.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "NationTextField.h"
#import "NationDataModel.h"
#import "NationView.h"


@interface NationTextField() <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) NSArray *groupOfNationDataModel;

@end

@implementation NationTextField

#pragma mark - 初始化操作
- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        [self setUpAllView];
    }
    return self;
}

- (void)awakeFromNib{
    [self setUpAllView];
}

- (void)setUpAllView{
    //创建
    UIPickerView *nationPick = [[UIPickerView alloc] init];
    
    //设置代理
    nationPick.delegate = self;
    nationPick.dataSource = self;
    
    //设置自定义textField的弹出界面
    self.inputView = nationPick;
}

#pragma mark - <UIPickerViewDataSource>
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.groupOfNationDataModel.count;
}

#pragma mark - <UIPickerViewDelegate>
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    //创建pickView中view的样式
    NationView *nationView = [NationView nationView];
    //对pickView中view设置数据
    nationView.dataModel = self.groupOfNationDataModel[row];
    
    return nationView;
}

//设置pickView中view的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 100;
}

//获取选中的pickView
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NationDataModel *dataModel = self.groupOfNationDataModel[row];
    self.text = dataModel.name;

}

#pragma mark - lazy of GroupOfNationDataModel
- (NSArray *)groupOfNationDataModel
{
    if (_groupOfNationDataModel == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"flags" ofType:@"plist"];
        NSArray *groupOfInstance = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *groupOfModel = [NSMutableArray array];
        for (NSDictionary *instance in groupOfInstance) {
            NationDataModel *model = [NationDataModel nationDataModelWithDict:instance];
            [groupOfModel addObject:model];
        }
        _groupOfNationDataModel  = groupOfModel;
    }
    return _groupOfNationDataModel;
}

- (void)prepareForUse{
    [self pickerView:nil didSelectRow:0 inComponent:0];

}

@end
