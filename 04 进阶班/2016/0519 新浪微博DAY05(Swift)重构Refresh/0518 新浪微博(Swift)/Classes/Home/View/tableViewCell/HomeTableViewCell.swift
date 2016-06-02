//
//  HomeTableViewCell.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/5/26.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit
import SnapKit

class HomeTableViewCell: UITableViewCell {
    //MARK: - 设置基本属性
    var viewModel: StatusViewModel? {
        didSet{
            //设置数据
            topView.viewModel = viewModel
            contentTextLabel.text = viewModel?.contentStr
            pictureCollectionView.viewModel = viewModel
            
            //计算CollectionView的size和内部item的size
            let (clvSize, _) = pictureCollectionView.calculateSize()
            //设置相关属性
            pictureCollectionView.snp_updateConstraints { (make) -> Void in
                make.width.equalTo(clvSize.width)
                make.height.equalTo(clvSize.height)
            }
        
        }
    }
    
    //MARK: - 懒加载
    // 创建顶部视图
    lazy var topView: HomeCellTopView = HomeCellTopView()
    // 正文
    lazy var contentTextLabel =  UILabel(text: "", color: UIColor.darkGrayColor(), screenInset: CGFloat(SQHomeCellMargin))
    // 创建collectionView
    lazy var pictureCollectionView: HomeCellPictureCollectionView = HomeCellPictureCollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())
    // 底部工具条
    lazy var bottomView: HomeCellBottomView = HomeCellBottomView()

    
    //MARK: - 构造方法
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 生命周期相关
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
    }

    //MARK: - 外部控制方法
    func rowHeight(viewModel: StatusViewModel) -> CGFloat {
        //1.设置数据
        self.viewModel = viewModel
        //2.更新布局
        layoutIfNeeded()
        //3.返回行高
        return CGRectGetMaxY(bottomView.frame)
    }

    
    class func identiferWithViewModel(viewModel: StatusViewModel) -> String {
        return (viewModel.statusModel.retweeted_status != nil) ? HomeTableViewForwarCell.identifer() : HomeTableViewNormalCell.identifer()
    }

}


extension HomeTableViewCell{

    //MARK: - 设置UI界面
    func setupUI() {
        //1 添加子控件
        contentView.addSubview(topView)
        contentView.addSubview(contentTextLabel)
        contentView.addSubview(pictureCollectionView)
        contentView.addSubview(bottomView)
        
        //2 添加约束
        topView.snp_makeConstraints { (make) in
            make.top.equalTo(contentView.snp_top)
            make.left.equalTo(contentView.snp_left)
            make.right.equalTo(contentView.snp_right)
            make.height.equalTo(SQHomeCellIconWidth + SQHomeCellMargin)
        }
        
        contentTextLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(topView.snp_left).offset(SQHomeCellMargin)
            make.top.equalTo(topView.snp_bottom).offset(SQHomeCellMargin)
        }
        
        pictureCollectionView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(topView.snp_left).offset(SQHomeCellMargin)
            make.top.equalTo(contentTextLabel.snp_bottom).offset(SQHomeCellMargin)
        }
        
        bottomView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(contentView.snp_left)
            make.right.equalTo(contentView.snp_right)
            make.height.equalTo(44)
            make.top.equalTo(pictureCollectionView.snp_bottom).offset(SQHomeCellMargin)
        }
        
    }
}
