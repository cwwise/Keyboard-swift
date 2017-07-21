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
    
    func emoticonInputView(_ inputView: EmoticonInputView, didSelect emoticon: Emoticon)

}

struct EmoticonGroupInfo {
    let row: Int     // 行
    let column: Int  // 列
    let page: Int    // 页数
    var onePageCount: Int {
        return row*column
    }
}


class EmoticonInputView: UIView {

    weak var delegate: EmoticonInputViewDelegate?
    
    fileprivate var groupList = [EmoticonGroup]()
    fileprivate var groupInfoList = [EmoticonGroupInfo]()
    
    var collectionView: UICollectionView!
    var toolView: EmoticonToolView!
    var pageControl: UIPageControl!
    var previewer: EmoticonPreviewer!
    
    var selectIndex: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func setupUI() {
        self.backgroundColor = UIColor.lightGray
        setupCollectionView()
        setupPageControl()
        setupToolView()
    }
        
    func setupCollectionView() {
        
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
    
    func setupPageControl() {
        let frame = CGRect(x: 0, y: collectionView.bottom, width: self.bounds.width, height: 15)
        pageControl = UIPageControl(frame: frame)
        pageControl.currentPageIndicatorTintColor = UIColor.blue
        pageControl.pageIndicatorTintColor = UIColor.orange
        self.addSubview(pageControl)
    }
    
    func setupToolView() {
        let frame = CGRect(x: 0, y: self.height - kToolViewHeight, width: self.bounds.width, height: kToolViewHeight)
        toolView = EmoticonToolView(frame: frame)
        self.addSubview(toolView)
    }
    
    func reloadData(_ data: [EmoticonGroup]) {
        
        if data == groupList {
            return
        }
        groupList = data
        
        // 计算数据
        for group in groupList {
            
            var row: Int = 0
            var column: Int = 0
            var page: Int = 0

            if group.type == .normal {
                row = 3
                column = 8
                page = Int(ceil(Float(group.count) / Float(row*column-1)))
            } else {
                
            }
            
            let info = EmoticonGroupInfo(row: row, column: column, page: page)
            groupInfoList.append(info)
        }
        
        
        toolView.loadData(groupList)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension EmoticonInputView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return groupInfoList[selectIndex].page
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groupInfoList[selectIndex].onePageCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! EmoticonCell
       
        let emoticonOfPage = groupInfoList[selectIndex].onePageCount - 1
        if indexPath.row == emoticonOfPage {
            cell.isDelete = true
            cell.emoticon = nil
        } else {
            cell.isDelete = false
            let index = indexPath.row + emoticonOfPage*indexPath.section
            if index >= groupList[0].count {
                cell.emoticon = nil
            } else {
                cell.emoticon = groupList[selectIndex].emoticons[index]
            }
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension EmoticonInputView: UIScrollViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.width)

        
    }
}

// MARK: - EmoticonInputViewLayoutDelegate
//extension EmoticonInputView: EmoticonInputViewLayoutDelegate {
//
//    func emoticonGroupInfo() -> EmoticonGroupInfo {
//        return groupInfoList[0]
//    }
//
//}




