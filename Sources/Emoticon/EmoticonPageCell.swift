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
    func emoticonPageCell(_ cell: EmoticonPageCell, didScroll index: Int)
}

private let superView = UIApplication.shared.keyWindow!

/// 每一组表情 展示的cell
class EmoticonPageCell: UICollectionViewCell {
    
    weak var delegate: EmoticonPageCellDelegate?
    
    var groupInfo: EmoticonGroupInfo!
    
    var group: EmoticonGroup!
    
    var previewer: EmoticonPreviewer!
    
    var collectionView: UICollectionView!
    
    weak var currentPreviewerCell: EmoticonCell?

    override init(frame: CGRect) {
        super.init(frame: frame)
    
        let layout = EmoticonPageCellLayout()
        layout.delegate = self
        
        let frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: 160)
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(EmoticonCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self;
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.canCancelContentTouches = false
        collectionView.isMultipleTouchEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        self.addSubview(collectionView)
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPress(_:)))
        self.addGestureRecognizer(longPress)
        
        previewer = EmoticonPreviewer()
        previewer.isHidden = true
        superView.addSubview(previewer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: 长按事件
extension EmoticonPageCell {
    
    func longPress(_ gesture: UILongPressGestureRecognizer) {
        
        if gesture.state == .ended {
            previewer.isHidden = true
            return
        }
        // 选中cell不是删除按钮
        let point = gesture.location(in: self.collectionView)
        guard let indexPath = self.collectionView.indexPathForItem(at: point),
            let cell = self.collectionView.cellForItem(at: indexPath) as? EmoticonCell,
           cell.isDelete == false else {
            previewer.isHidden = true
            return
        }
        
        // 判断选择的cell是否与之前的cell相同
        if cell == currentPreviewerCell {
            previewer.isHidden = false
            return
        }
        
        currentPreviewerCell = cell
        
        let rect = cell.convert(cell.bounds, to: superView)
        previewer.preview(from: rect, emoticonCell: cell)
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
        return groupInfo.onePageCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! EmoticonCell
        
        let emoticonOfPage = groupInfo.onePageCount - 1
        // 最后一个cell 则显示删除按钮
        if indexPath.row == emoticonOfPage {
            cell.isDelete = true
            cell.emoticon = nil
        } else {
            cell.isDelete = false
            let index = indexPath.row + emoticonOfPage*indexPath.section
            if index >= group.count {
                cell.emoticon = nil
            } else {
                cell.emoticon = group.emoticons[index]
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let emoticonOfPage = groupInfo.onePageCount - 1
        let index = indexPath.row + emoticonOfPage*indexPath.section
     
        if indexPath.row == emoticonOfPage {
            self.delegate?.emoticonPageCell(self, didSelect: nil)
        } else if index < group.count {
            self.delegate?.emoticonPageCell(self, didSelect: group.emoticons[index])
        }
        
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        self.delegate?.emoticonPageCell(self, didScroll: index)
    }
    
}


extension EmoticonPageCell: EmoticonPageCellLayoutDelegate {
    
    func emoticonGroupInfo() -> EmoticonGroupInfo {
        return groupInfo
    }
    
}
