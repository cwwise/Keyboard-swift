//
//  CWEmoticonInputViewLayout.swift
//  CWWeChat
//
//  Created by wei chen on 2017/7/19.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

class EmoticonInputViewLayout: UICollectionViewLayout {

    var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
    var cacheLayoutAttributes = [IndexPath: UICollectionViewLayoutAttributes]()
    var contentHeight = CGFloat(0)
    
    // section
    var sections: Int = 0

    // column
    var maxColumn: Int = 0
    // row
    var maxRow: CGFloat = 0
    // margin
    var margin: CGFloat = 0
    
    
    var collectionViewHeight: CGFloat {
        return collectionView!.frame.height
    }
    
    var collectionViewWidth: CGFloat {
        return collectionView!.frame.width
    }
    
//    override public var collectionViewContentSize: CGSize {
//        return CGSize(width: collectionViewWidth, height: contentHeight)
//    }
    
    // MARK: - 返回大小
    override public var collectionViewContentSize: CGSize {
        let itemsize = self.getItemSize(column: CGFloat(maxColumn), row: maxRow, margin: margin)
        return CGSize(width: CGFloat(sections) * collectionViewWidth, height: margin + (maxRow * (itemsize.height + margin)))
    }

    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        if collectionView?.frame.width != newBounds.width {
            return true
        }
        return false
    }
    
    var contentOffset: CGPoint {
        return collectionView!.contentOffset
    }
    
}

extension EmoticonInputViewLayout {
    
    override func prepare() {
        super.prepare()
        
        // 1
        guard let collectionView = collectionView else {
            return
        }
        // 根据设置的Column Row, 计算得到每个item的大小
        let itemsize = getItemSize(column: CGFloat(maxColumn), row: maxRow, margin: margin)
        // 获取组数
        // 遍历每组里面的所有item
        sections = collectionView.numberOfSections
        for section in 0 ..< collectionView.numberOfSections {
            // 遍历每一个item
            for item in 0 ..< collectionView.numberOfItems(inSection: section) {
                // 根据 section, item 获取每一个item的indexPath值
                let indexPath = IndexPath(item: item, section: section)
                // 根据indexPath值, 获取每一个item的属性
                let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                // 通过一系列脑残计算, 得到x, y值
                let x = margin + (itemsize.width + margin) * CGFloat(item % maxColumn) + (CGFloat(section) * collectionViewWidth)
                let y = margin + (itemsize.height + margin) * CGFloat(item / Int(maxColumn))
                attribute.frame = CGRect(x: x, y: y, width: itemsize.width, height: itemsize.height)
                // 把每一个新的属性保存起来
                cacheLayoutAttributes[indexPath] = attribute
            }
        }
        
    }
    
    // MARK: - itemSize
    // 为了使得表情不变形, 因此 height = width
    func getItemSize(column: CGFloat, row: CGFloat, margin: CGFloat) -> CGSize {
        let width = (collectionViewWidth - ((column + 1) * margin)) / column
        return CGSize(width: width, height: width)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        guard let _ = collectionView else {
            return nil
        }
        
        visibleLayoutAttributes.removeAll(keepingCapacity: true)
        for (_, attributes) in cacheLayoutAttributes where attributes.frame.intersects(rect) {
            visibleLayoutAttributes.append(attributes)
        }
        return visibleLayoutAttributes
        
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cacheLayoutAttributes[indexPath]
    }
    
    
    
    
}


