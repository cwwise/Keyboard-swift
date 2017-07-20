//
//  MoreCollectionLayout.swift
//  Keyboard
//
//  Created by chenwei on 2017/7/20.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import UIKit

class MoreCollectionLayout: UICollectionViewLayout {

    // 保存所有item
    var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
    fileprivate var cacheAttributes: [UICollectionViewLayoutAttributes] = []
    fileprivate var column: Int = 0
    fileprivate var row: Int = 0
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var collectionViewHeight: CGFloat {
        return collectionView!.frame.height
    }
    
    var collectionViewWidth: CGFloat {
        return collectionView!.frame.width
    }
    
    // MARK:- 重新布局
    override func prepare() {
        super.prepare()
     
        
        
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        visibleLayoutAttributes.removeAll(keepingCapacity: true)
        for attributes in cacheAttributes where attributes.frame.intersects(rect) {
            visibleLayoutAttributes.append(attributes)
        }
        return visibleLayoutAttributes
    }
    
    
    override var collectionViewContentSize: CGSize {
        let size: CGSize = super.collectionViewContentSize
        let collectionViewWidth: CGFloat = self.collectionView!.frame.size.width
        let nbOfScreen: Int = Int(ceil(size.width / collectionViewWidth))
        let newSize: CGSize = CGSize(width: collectionViewWidth * CGFloat(nbOfScreen), height: size.height)
        return newSize
    }
    
}
