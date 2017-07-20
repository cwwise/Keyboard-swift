//
//  CWEmoticonPreviewer.swift
//  CWWeChat
//
//  Created by wei chen on 2017/7/19.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

/// 表情长按之后效果
class EmoticonPreviewer: UIView {

    // magnifier是长按 之后展示表情的部分
    var magnifier: UIImageView = {
        let magnifier = UIImageView(image: UIImage(named: "EmoticonTips"))
        magnifier.size = CGSize(width: 50, height: 80)
        magnifier.isHidden = true
        return magnifier
    }()
    
    var magnifierLabel: UILabel = {
        let magnifierLabel = UILabel()
        magnifierLabel.textAlignment = .center
        magnifierLabel.font = UIFont.systemFont(ofSize: 12)
        magnifierLabel.textColor = UIColor.gray
        magnifierLabel.size = CGSize(width: 40, height: 15)
        return magnifierLabel
    }()
    
    var magnifierContent: UIImageView = {
        let magnifierContent = UIImageView()
        magnifierContent.size = CGSize(width: 35, height: 35)
        return magnifierContent
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    func preview(emoticon: Emoticon) {
        
        // 普通表情 和 大图表情 处理不一样
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
