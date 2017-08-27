//
//  MoreInputView.swift
//  Keyboard
//
//  Created by chenwei on 2017/7/20.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import UIKit
import Hue

protocol MoreInputViewDelegate: NSObjectProtocol {
    func moreInputView(_ inputView: MoreInputView, didSelect item: MoreItem)
}

private let kOnePageLines: Int = 2
private let kOnePageLineItems: Int = 4
private let kOneItemHeight: CGFloat = 280/3

class MoreInputView: UIView {
    
    weak var delegate: MoreInputViewDelegate?
    
    fileprivate var items = [MoreItem]()
    
    var pageItemCount: Int {
        return kOnePageLines * kOnePageLineItems
    }
    
    var totalPageCount: Int = 0
    
    lazy var collectionView: UICollectionView = {
        
        var itemWidth = (self.bounds.width - 10*2)/CGFloat(kOnePageLineItems)
        itemWidth = CGFloatPixelRound(itemWidth)
    
        let padding = (self.bounds.width - CGFloat(kOnePageLineItems) * itemWidth) / 2.0
        let paddingLeft = CGFloatPixelRound(padding)
        
        var layout = MoreInputViewLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: itemWidth, height: kOneItemHeight)
        
        let frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: kOneItemHeight*CGFloat(kOnePageLines))
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.register(MoreItemCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.scrollsToTop = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: 25))
        pageControl.pageIndicatorTintColor = UIColor(hex: "#BBBBBB")
        pageControl.currentPageIndicatorTintColor = UIColor(hex: "#8B8B8B")
        pageControl.hidesForSinglePage = true
        return pageControl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.addSubview(collectionView)
        self.addSubview(pageControl)
        pageControl.top = collectionView.bottom

    }
    
    func loadData(_ data: [MoreItem]) {

        if data == self.items {
            return
        }
        self.items = data
        
        totalPageCount = Int(ceil(Float(items.count)/Float(pageItemCount)))
        pageControl.numberOfPages = totalPageCount
        pageControl.currentPage = 0
        collectionView.reloadData()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension MoreInputView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pageItemCount
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return totalPageCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MoreItemCell

        let index = indexPath.row + pageItemCount*indexPath.section
        if index >= self.items.count {
            cell.item = nil;
        } else {
            cell.item = self.items[index]
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension MoreInputView: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.width)
    }
    
}


