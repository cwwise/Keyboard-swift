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
        sendButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        sendButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10 + 8, 0, 8)
        sendButton.setTitle("Send", for: .normal)
        sendButton.setTitleColor(.white, for: .normal)
        sendButton.setTitleColor(.lightGray, for: .highlighted)
        sendButton.setTitleColor(.gray, for: .disabled)
        
        sendButton.setBackgroundImage(UIImage(named: "EmotionsSendBtnBlue"), for: .normal)
        sendButton.setBackgroundImage(UIImage(named: "EmotionsSendBtnBlueHL"), for: .highlighted)
        sendButton.setBackgroundImage(UIImage(named: "EmotionsSendBtnGrey"), for: .disabled)
        
        sendButton.isEnabled = false
        return sendButton
    }()
    
    // 发送按钮
    let settingButton: UIButton = {
        let settingButton = UIButton(type: .custom)
        
        settingButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        settingButton.setImage(UIImage(named: "EmotionsSetting"), for: .normal)
        settingButton.setBackgroundImage(UIImage(named: "EmotionsSendBtnGrey"), for: .normal)
        settingButton.setBackgroundImage(UIImage(named: "EmotionsSendBtnGrey"), for: .highlighted)
    
        return settingButton
    }()
    
    var addButton: UIButton = {
        let addButton = UIButton(type: .custom)
        addButton.setImage(UIImage(named: "EmotionsBagAdd"), for: .normal)
        return addButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(addButton)
        self.addSubview(collectionView)
        
        self.addSubview(sendButton)
        self.addSubview(settingButton)
        
        addButton.frame = CGRect(x: 0, y: 0, width: itemWidth, height: self.height)
        collectionView.frame = CGRect(x: itemWidth, y: 0, width: self.width-itemWidth, height: self.height)
        
        sendButton.frame = CGRect(x: self.width-itemWidth, y: 0, width: itemWidth, height: self.height)
        settingButton.frame = CGRect(x: self.width, y: 0, width: itemWidth, height: self.height)
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
        cell.group = groupList[indexPath.row]
        return cell
    }
    
}

