//
//  LocationTextField.m
//  1004 PickerView综合应用
//
//  Created by 张思琦 on 15/10/11.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "LocationTextField.h"
#import "ProvincesDateModel.h"

@interface LocationTextField () <UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) NSArray *groupOfProvinces;

@property (nonatomic, assign) NSInteger indexOfProvince;
@end

@implementation LocationTextField

#pragma mark - lazy of groupOfProvinces
- (NSArray *)groupOfProvinces{
    if (_groupOfProvinces == nil) {
        //获取plist路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"provinces" ofType:@"plist"];
        //获取plist文件中的数组
        NSArray *groupOfInstance = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *groupOfModel = [NSMutableArray array];
        
        for (NSDictionary *instance in groupOfInstance) {
            ProvincesDateModel *model = [ProvincesDateModel provinceDataModelWithDict:instance];
            [groupOfModel addObject:model];
        }
        
        _groupOfProvinces = groupOfModel;
    }
    
    return _groupOfProvinces;
}

#pragma mark - 初始化操作
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib{
    [self setUp];
}

- (void)setUp {
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    pickerView.delegate = self;
    pickerView.dataSource= self;
    
    self.inputView = pickerView;
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {//Provinces
        return self.groupOfProvinces.count;
    }else{//cities
        //根据indexOfProvince获取当前省的数据模型
        ProvincesDateModel *province = self.groupOfProvinces[self.indexOfProvince];
        return province.cities.count;
    }
}

#pragma mark - UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        ProvincesDateModel *province = self.groupOfProvinces[row];
        return province.name;
    }else{
        ProvincesDateModel *province = self.groupOfProvinces[self.indexOfProvince];
        return province.cities[row];
    }
}

//使用该方法获取当前获得的省份
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        //保存当前选择的省
        self.indexOfProvince = row;
        [pickerView reloadComponent:1];
    }
    
    ProvincesDateModel *province = self.groupOfProvinces[self.indexOfProvince];
    NSString *provinceName = province.name;
    
    NSInteger index = [pickerView selectedRowInComponent:1];
    NSString *cityName = province.cities[index];
    
    self.text = [NSString stringWithFormat:@"%@-%@", provinceName, cityName];
}

- (void)prepareForUse
{
    [self pickerView:nil didSelectRow:0 inComponent:0];
}
@end

