//
//  EmoticonPageCell.swift
//  Keyboard
//
//  Created by chenwei on 2017/7/22.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import UIKit

protocol EmoticonPageCellDelegate: class {
    func emoticonPageCell(_ cell: EmoticonPageCell, didSelect emoticon: Emoticon?)
}

class EmoticonPageCell: UICollectionViewCell {
    
    weak var delegate: EmoticonPageCellDelegate?
    
    var groupInfo: EmoticonGroupInfo?
    var group: EmoticonGroup?
    
    var collectionView: UICollectionView!

    override init(frame: CGRect) {
        super.init(frame: frame)
    
        let layout = EmoticonInputViewLayout()
        
        let frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: 160)
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(EmoticonCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self;
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        self.addSubview(collectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension EmoticonPageCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let groupInfo = groupInfo else {
            return 0
        }
        return groupInfo.page
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groupInfo!.onePageCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! EmoticonCell
        
        let emoticonOfPage = groupInfo!.onePageCount - 1
        if indexPath.row == emoticonOfPage {
            cell.isDelete = true
            cell.emoticon = nil
        } else {
            cell.isDelete = false
            let index = indexPath.row + emoticonOfPage*indexPath.section
            if index >= group!.count {
                cell.emoticon = nil
            } else {
                cell.emoticon = group!.emoticons[index]
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
