//
//  SQKeyBoardViewController.swift
//  0605 自定义键盘
//
//  Created by 张思琦 on 16/6/5.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit

/*
 emoticons.bundle 的根目录下保存了emoticons.plist 保存了表情包的基本信息
    >package 是一个数组,数组中存放的字典,用于记录该表情资源中表情包分组信息
        >字典中的id代表对应表情包的文件夹名称
 在表情包的文件夹中(对应字典中的id)都包含了info.plist
    >group_name_cn
    >emoticons       保存的是表情信息数组
        >code            UNICODE 编码字符串
        >chs             表情文字，发送给新浪微博服务器的文本内容
        >png             表情图片，在 App 中进行图文混排使用的图片
 */

class SQKeyBoardViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: SQKeyboardEmoticonsFlowLayout())
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.registerClass(SQKeyboardEmoticonsCell.self, forCellWithReuseIdentifier: "SQKeyboardEmoticonsCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    private lazy var toolBar: UIToolbar = {
        let toolBar = UIToolbar()
        
        toolBar.tintColor = UIColor.darkGrayColor()
        var barItems = [UIBarButtonItem]()
        
        for (index, title) in ["最近", "默认", "Emoji", "浪小花"].enumerate(){
            
            let item = UIBarButtonItem(title: title, style: .Plain, target: self, action: #selector(SQKeyBoardViewController.itemBtnClick(_:)))
            item.tag = index
            barItems.append(item)
        
            
            //添加弹簧
            let flexible = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
            barItems.append(flexible)
        }
        
        barItems.removeLast()
        
        toolBar.items = barItems
        
        return toolBar
    }()
    
    private lazy var allEmoticonPackage:[SQKeyBoardEmoticonPackage]? = SQKeyBoardEmoticonPackage.loadAllEmoticonPackages()
    
    var emoticonCallBack: (emoticon: SQKeyBoardEmoticonModel)->()

    init(callBack: (emoticon: SQKeyBoardEmoticonModel) -> ()) {
        emoticonCallBack = callBack
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1.添加子控件
        view.addSubview(collectionView)
        view.addSubview(toolBar)
        
        // 2.布局子控件
        // 2.1禁用autoresizing
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        
        // 2.2创建约束
        let dict = ["collectionView": collectionView, "toolBar": toolBar]
        
        var cons = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[collectionView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dict)
        cons += NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[toolBar]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dict)
        cons += NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[collectionView]-0-[toolBar(44)]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dict)
        
        // 2.3添加约束
        view.addConstraints(cons)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

extension SQKeyBoardViewController {

    @objc private func itemBtnClick(item: UIBarButtonItem) {
        // 该方法用于滚动collectionView到指定section的指定item中
        // scrollToItemAtIndexPath参数用于指定滚动位置
        // atScrollPosition参数用于说明
        //animated
        collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: 0, inSection: item.tag), atScrollPosition: .Left, animated: true)
    }

}



//MARK: - UICollectionViewDataSource
extension SQKeyBoardViewController: UICollectionViewDataSource{
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return allEmoticonPackage?.count ?? 0
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        let package = allEmoticonPackage![section]
        return package.groupOfEmoticons?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SQKeyboardEmoticonsCell", forIndexPath: indexPath) as! SQKeyboardEmoticonsCell
        cell.emoticon = allEmoticonPackage![indexPath.section].groupOfEmoticons![indexPath.item]
        return cell
    }
    
    
}


//MARK: - UICollectionViewDelegate
extension SQKeyBoardViewController: UICollectionViewDelegate{
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // 1.拿到当前点击的表情
        let emoticon = allEmoticonPackage![indexPath.section].groupOfEmoticons![indexPath.item]
        // 2.判断是否是删除按钮
        if emoticon.isRemoveButton {
            
        }else {
            // 不是删除按钮, 需要添加到最近组中
            emoticon.count += 1
            // 2.1拿到最近组
            allEmoticonPackage!.first!.addFavoriteEmoticon(emoticon)
            // 2.2刷新表格
            collectionView.reloadSections(NSIndexSet(index: 0))
        }
        
        // 3.执行闭包, 通知外界插入表情
        emoticonCallBack(emoticon: emoticon)
    }
    
}

//MARK: - SQKeyboardEmoticonsFlowLayout
class SQKeyboardEmoticonsFlowLayout: UICollectionViewFlowLayout {
    override func prepareLayout() {
        super.prepareLayout()
        
        //1设置cell
        let itemWidth = UIScreen.mainScreen().bounds.width / 7
        let itemHeight = itemWidth
        itemSize = CGSize(width: itemWidth, height: itemHeight)
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .Horizontal
        
        //2设置collectionView
        collectionView?.pagingEnabled = true
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.bounces = false
        
        //3.设置cell居中
        let offsetY = ((collectionView?.bounds.height)! - 3 * itemHeight) * 0.5
        collectionView?.contentInset = UIEdgeInsets(top: offsetY, left: 0, bottom: offsetY, right: 0)
        
    }
    
}

//MARK: - SQKeyboardEmoticonsCell
class SQKeyboardEmoticonsCell: UICollectionViewCell {
    // MAKR: - 懒加载
    private lazy var emoticonButton: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFontOfSize(32)
        btn.userInteractionEnabled = false
        return btn
    }()
    
    // 表情模型
    var emoticon: SQKeyBoardEmoticonModel? {
        didSet {
            
            // 3.判断是否是删除按钮
            if emoticon!.isRemoveButton {
                emoticonButton.setImage(UIImage(named: "compose_emotion_delete"), forState: .Normal)
                emoticonButton.setTitle(nil, forState: .Normal)
            } else {
                
                let image = UIImage(contentsOfFile: emoticon!.imagePath ?? "")
                let title = emoticon?.emojiStr
                
                emoticonButton.setImage(image, forState: .Normal)
                emoticonButton.setTitle(title, forState: .Normal)
            }
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(emoticonButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        emoticonButton.frame = CGRectInset(bounds, 4, 4)
    }
    
}