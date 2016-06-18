//
//  SQKeyBoardEmotionPackage.swift
//  0605 自定义键盘
//
//  Created by 张思琦 on 16/6/5.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit

class SQKeyBoardEmoticonPackage: NSObject {
    //表情包所在的文件夹名称
    var id: String?
    //表情包的名称
    var group_name_cn: String?
    //表情包里的所有表情数组
    var groupOfEmoticons: [SQKeyBoardEmoticonModel]?
    
    
    //构造方法
    override init() {
        super.init()
    }
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
}


extension SQKeyBoardEmoticonPackage {
    
    class func loadAllEmoticonPackages() -> [SQKeyBoardEmoticonPackage]? {
        //创建用于保存SQKeyBoardEmoticonPackage的数组
        var models = [SQKeyBoardEmoticonPackage]()
        
        //1. 创建"最近添加"的表情包组
        let package = SQKeyBoardEmoticonPackage()
        //创建表情包模型中存储表情数据的数组
        package.groupOfEmoticons = [SQKeyBoardEmoticonModel]()
        package.appendEmptyEmoticon()
        models.append(package)
        
        //2. 创建其余的表情包组
        //获取Emoticons.bundle中的emoticons.plist的路径
        guard let path = NSBundle.mainBundle().pathForResource("emoticons.plist", ofType: nil, inDirectory: "Emoticons.bundle") else {
            return nil
        }
        
        //将emoticons.plist文件转换为字典
        guard let dict = NSDictionary(contentsOfFile: path) else {
            return nil
        }
        
        //根据字典中键为packages的值
        guard let array = dict["packages"] as? [[String: AnyObject]] else {
            return nil
        }
        
        //遍历数组, 取出每一组的数据
        for dict in array {
            // 4.1根据字典创建对应组的模型
            let package = SQKeyBoardEmoticonPackage(dict: dict)
            package.loadEmoticons()
            package.appendEmptyEmoticon()
            models.append(package)
        }
    
        return models
    }
    
    
    /**
     追加空白按钮
     当前组的数据不能被21整除时, 就追加空白按钮, 让当前组能够被21整除
     */
    private func appendEmptyEmoticon() {
        
        //1 获取当前组除以21之后的余数
        let count =  groupOfEmoticons!.count % 21
        
        //2 缺几个补几个
        //注意:数组的起始值为0,当达到20时,就已经到最后一个按钮了
        for _ in count..<20 {
            groupOfEmoticons?.append(SQKeyBoardEmoticonModel(isRemoveButton: false))
        }
        
        // 3.追加一个删除按钮
        groupOfEmoticons?.append(SQKeyBoardEmoticonModel(isRemoveButton: true))
    }
    
    /**
     加载当前组所有的表情
     */
    private func loadEmoticons() {
        // 1.生成当前组表情所在文件夹的路径
        guard let path: NSString = NSBundle.mainBundle().pathForResource(id, ofType: nil, inDirectory: "Emoticons.bundle") else {
            return
        }
        // 2.生成当前组表情中info.plist的路径
        let filePath = path.stringByAppendingPathComponent("info.plist")

        // 3.加载当前组表情中的字典
        guard let dict = NSDictionary(contentsOfFile: filePath) else {
            return
        }
        
        // 4.取出当前组表情的名称
        group_name_cn = dict["group_name_cn"] as? String
        
        
        // 5.加载当前组表情中的表情数组
        guard let array = dict["emoticons"] as? [[String: AnyObject]] else {
            return
        }
        
        // 6.遍历数组, 取出每个表情
        var models = [SQKeyBoardEmoticonModel]()
        var index = 0
        for dict in array {
            if index == 20{
                // 追加一个删除按钮
                models.append(SQKeyBoardEmoticonModel(isRemoveButton: true))
                index = 0
            }
            let emoticon = SQKeyBoardEmoticonModel(dict: dict)
            emoticon.id = id
            models.append(emoticon)
            index += 1
        }
        groupOfEmoticons = models
        
    }
    
    
    /**
     添加表情到最近组
     
     - parameter emoticon: 需要添加的表情
     */
    func addFavoriteEmoticon(emoticon: SQKeyBoardEmoticonModel) {
        /*
         规则:
         1.最近组永远只能有21个表情, 添加一个必须删除一个
         2.使用次数越多, 那么越排在前面
         3.被添加的表情不能重复
         */
        
        // 0.删除一个按钮
        groupOfEmoticons?.removeLast()
        
        // 1.判断当前表情是否已经添加过了
        if !groupOfEmoticons!.contains(emoticon) {
            // 当前表情没有添加过
            // 1.1删除一个表情
            groupOfEmoticons?.removeLast()
            
            // 1.2添加一个表情
            groupOfEmoticons?.append(emoticon)
        }
        
        // 2.排序
        groupOfEmoticons =  groupOfEmoticons?.sort({ (e1, e2) -> Bool in
            return e1.count > e2.count
        })
        
        // 3.添加删除按钮
        groupOfEmoticons?.append(SQKeyBoardEmoticonModel(isRemoveButton: true))
    }
}