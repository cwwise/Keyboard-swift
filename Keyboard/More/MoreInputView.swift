//
//  MoreInputView.swift
//  Keyboard
//
//  Created by chenwei on 2017/7/20.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import UIKit

protocol MoreInputViewDelegate: NSObjectProtocol {
    func moreInputView(_ inputView: MoreInputView, didSelect item: MoreItem)
}

class MoreInputView: UIView {
    
    weak var delegate: MoreInputViewDelegate?
    
    fileprivate var items = [MoreItem]()
    
    var pageControl: UIPageControl!

    lazy var collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        //layout.itemSize = CGSize(width: itemWidth, height: self.frame.height)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(MoreItemCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        collectionView.delegate = self
        collectionView.scrollsToTop = false
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    func reloadData(_ data: [MoreItem]) {

        if data == self.items {
            return
        }
        self.items = data
        collectionView.reloadData()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension MoreInputView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MoreItemCell

        return cell
    }
    
}

extension MoreInputView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}


