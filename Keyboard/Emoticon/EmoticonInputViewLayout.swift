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
    

    var collectionViewHeight: CGFloat {
        return collectionView!.frame.height
    }
    
    var collectionViewWidth: CGFloat {
        return collectionView!.frame.width
    }
    
    override public var collectionViewContentSize: CGSize {
        return CGSize(width: collectionViewWidth, height: contentHeight)
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
        
        // 计算
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


