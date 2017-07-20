//
//  CWEmoticonToolView.swift
//  CWWeChat
//
//  Created by wei chen on 2017/7/19.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

private let itemWidth: CGFloat = 45

protocol EmoticonToolViewDelegate {
    
}

/// 表情标签
class EmoticonToolView: UIView {

    var delegate: EmoticonToolViewDelegate?
    /// 数据源
    var groupList: [EmoticonGroup] = [EmoticonGroup]()
    
    lazy var collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: itemWidth, height: self.frame.height)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        collectionView.register(EmoticonToolItemCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        collectionView.delegate = self
        collectionView.scrollsToTop = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()

    // 发送按钮
    let sendButton: UIButton = {
       let sendButton = UIButton(type: .custom)
        sendButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        sendButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        sendButton.setTitle("发送", for: .normal)
        sendButton.setTitleColor(.white, for: .normal)
        sendButton.setTitleColor(.lightGray, for: .highlighted)
        sendButton.setTitleColor(.gray, for: .disabled)
        
        sendButton.setBackgroundImage(UIImage(named: "EmotionsSendBtnBlue"), for: .normal)
        sendButton.setBackgroundImage(UIImage(named: "EmotionsSendBtnBlueHL"), for: .highlighted)
        sendButton.setBackgroundImage(UIImage(named: "EmotionsSendBtnGrey"), for: .disabled)
        
        sendButton.isEnabled = false
        return sendButton
    }()
    
    // 设置
    let settingButton: UIButton = {
        let settingButton = UIButton(type: .custom)
        
        settingButton.setImage(UIImage(named: "EmotionsSetting"), for: .normal)
        settingButton.setBackgroundImage(UIImage(named: "EmotionsSendBtnGrey"), for: .normal)
        settingButton.setBackgroundImage(UIImage(named: "EmotionsSendBtnGrey"), for: .highlighted)
    
        return settingButton
    }()
    
    lazy var addButton: UIButton = {
        let addButton = UIButton(type: .custom)
        addButton.setImage(UIImage(named: "EmotionsBagAdd"), for: .normal)
        addButton.frame = CGRect(x: 0, y: 0, width: itemWidth, height: self.height)

        // 添加一条线
        let line: CALayer = CALayer()
        line.backgroundColor = UIColor(white: 0.9, alpha: 1.0).cgColor
        line.frame = CGRect(x: itemWidth-0.5, y: 8, width: 0.5, height: self.height - 2*8)
        addButton.layer.addSublayer(line)
        
        return addButton
    }()
    
    func loadData(_ groupList: [EmoticonGroup]) {
        if groupList == self.groupList {
            return
        }
        self.groupList = groupList
        self.collectionView.reloadData()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(addButton)
        self.addSubview(collectionView)
        
        self.addSubview(sendButton)
        self.addSubview(settingButton)
        
        collectionView.frame = CGRect(x: addButton.right, y: 0, width: self.width-itemWidth, height: self.height)
        
        let buttonWidth: CGFloat = 52
        sendButton.frame = CGRect(x: self.width-buttonWidth, y: 0, width: buttonWidth, height: self.height)
        settingButton.frame = CGRect(x: self.width, y: 0, width: buttonWidth, height: self.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension EmoticonToolView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

extension EmoticonToolView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groupList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! EmoticonToolItemCell
        
        cell.imageView.image = UIImage(contentsOfFile: groupList[indexPath.row].icon)

        return cell
    }
    
}

