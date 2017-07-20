//
//  EmoticonInputView.swift
//  CWWeChat
//
//  Created by wei chen on 2017/7/19.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

private let kEmoticonHeight: CGFloat = 50
private let kToolViewHeight: CGFloat = 37

protocol EmoticonInputViewDelegate: class {
    
}

class EmoticonInputView: UIView {

    weak var delegate: EmoticonInputViewDelegate?
    
    var groupList = [EmoticonGroup]()
    
    var collectionView: UICollectionView!
    var toolView: EmoticonToolView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }
    
    func setupUI() {
        setupCollectionView()
        setupToolView()
    }
    
    func setupToolView() {
        let frame = CGRect(x: 0, y: self.height - kToolViewHeight, width: self.width, height: kToolViewHeight)
        toolView = EmoticonToolView(frame: frame)
        self.addSubview(toolView)
    }
    
    func setupCollectionView() {
        
        let layout = EmoticonInputViewLayout()
        layout.maxColumn = 8
        layout.maxRow = 4
        layout.margin = 10
        
        let frame = CGRect(x: 0, y: 0, width: self.width, height: kEmoticonHeight*3)
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(EmoticonCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.top = 5;
        self.addSubview(collectionView)
        
    }
    
    func reloadData() {
        toolView.loadData(groupList)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}

extension EmoticonInputView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

extension EmoticonInputView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groupList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! EmoticonCell
        cell.emoticon = groupList[indexPath.row].emoticons[indexPath.row]
        return cell
    }
    
}


