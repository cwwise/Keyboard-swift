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
        magnifier.size = CGSize(width: 50, height: 85)
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
        self.addSubview(magnifier)
        magnifier.addSubview(magnifierLabel)
        magnifier.addSubview(magnifierContent)
        
        magnifierContent.centerX = magnifier.width/2
        magnifierLabel.centerX = magnifier.width/2
        magnifierLabel.top = magnifierContent.bottom + 5
    }
    
    func preview(from rect: CGRect, emoticonCell: EmoticonCell) {
       
        self.size = CGSize(width: 50, height: 85)
        self.centerX = rect.midX
        self.bottom = rect.maxY - 3
        self.isHidden = false

        // 普通表情 和 大图表情 处理不一样
        magnifierLabel.text = emoticonCell.emoticon?.title
        
        magnifierContent.image = emoticonCell.imageView.image
        magnifierContent.top = 20;
        
        magnifierContent.layer.removeAllAnimations()
        
        let duration = 0.1
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseIn, animations: {
            self.magnifierContent.top = 3
        }) { (finished) in
            UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
                self.magnifierContent.top = 6
            }) { (finished) in
                UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
                    self.magnifierContent.top = 5
                }) { (finished) in
                }
            }
        }
        
    }
    
    func hidePreview() {
        self.isHidden = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
