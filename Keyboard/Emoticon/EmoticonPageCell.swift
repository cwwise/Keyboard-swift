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

class EmoticonPageCell: UICollectionViewCell {
    
    weak var delegate: EmoticonPageCellDelegate?
    
    var groupInfo: EmoticonGroupInfo!
    var group: EmoticonGroup!
    
    // 预览(需要修复的问题 越边界的问题 上面)
    var previewer: EmoticonPreviewer!
    var collectionView: UICollectionView!
    
    weak var currentPreviewerCell: EmoticonCell?

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
        collectionView.canCancelContentTouches = false
        collectionView.isMultipleTouchEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        self.addSubview(collectionView)
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPress(_:)))
        self.addGestureRecognizer(longPress)
        previewer = EmoticonPreviewer(frame: CGRect.zero)
        previewer.isHidden = true
        self.addSubview(previewer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: 长按事件
extension EmoticonPageCell {
    
    func longPress(_ gesture: UILongPressGestureRecognizer) {

        switch gesture.state {
        case .began:
            let point = gesture.location(in: self.collectionView)
            let cell = cellForPoint(point)
            touchesBegan(cell)
            
        case .changed:
            let point = gesture.location(in: self.collectionView)
            let cell = cellForPoint(point)
            touchesMoved(cell)
            
        default:
            previewer.hidePreview()
            break
        }
    }
    
    func touchesBegan(_ cell: EmoticonCell?) {
        
        guard let cell = cell,
         cell.isDelete == false else {
            return
        }
    
        currentPreviewerCell = cell
        let rect = cell.convert(cell.bounds, to: self)
        previewer.preview(from: rect, emoticonCell: cell)
    }
    
    func touchesMoved(_ cell: EmoticonCell?) {
        
        if let currentCell = currentPreviewerCell, currentCell.isDelete == true {
            return
        }
        
        guard let cell = cell, cell != currentPreviewerCell else {
            return
        }
        
        currentPreviewerCell = cell
        let rect = cell.convert(cell.bounds, to: self)
        previewer.preview(from: rect, emoticonCell: cell)
    }

    
    func cellForPoint(_ point: CGPoint) -> EmoticonCell? {

        guard let indexPath = self.collectionView.indexPathForItem(at: point),
            let cell = self.collectionView.cellForItem(at: indexPath) as? EmoticonCell else {
                return nil
        }
        return cell
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
        } else if index < group!.count {
            self.delegate?.emoticonPageCell(self, didSelect: group.emoticons[index])
        }
        
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        self.delegate?.emoticonPageCell(self, didScroll: index)
    }
    
}
