//
//  CWEmoticonPreviewer.swift
//  CWWeChat
//
//  Created by wei chen on 2017/7/19.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit

protocol EmoticonResource {
    
}

private let magnifierSize = CGSize(width: 60, height: 100)
/// 表情长按之后效果
class EmoticonPreviewer: UIView {

    // magnifier是长按 之后展示表情的部分
    var magnifier: UIImageView = {
        let magnifier = UIImageView(image: UIImage(named: "EmoticonTips"))
        magnifier.frame = CGRect(origin: CGPoint.zero, size: magnifierSize)
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
    
    // 内容部分
    var magnifierContent: UIImageView = {
        let magnifierContent = UIImageView()
        magnifierContent.size = CGSize(width: 35, height: 35)
        return magnifierContent
    }()
    
    convenience init() {
        let frame = CGRect(origin: CGPoint.zero, size: magnifierSize)
        self.init(frame: frame)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(magnifier)
        magnifier.addSubview(magnifierContent)
        magnifier.addSubview(magnifierLabel)
        
        magnifierContent.centerX = magnifier.width/2
        magnifierContent.top = 5;

        magnifierLabel.centerX = magnifier.width/2        
        magnifierLabel.top = magnifierContent.bottom + 2
    }
    
    func preview(from rect: CGRect, emoticonCell: EmoticonCell) {
       
        self.centerX = rect.midX
        self.bottom = rect.maxY
        self.isHidden = false

        // 普通表情 和 大图表情 处理不一样
        magnifierLabel.text = emoticonCell.emoticon?.title
        
        magnifierContent.image = emoticonCell.imageView.image
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
    
    func backgroundImage() -> UIImage? {
        
        // 合成背景图
        let leftImage = UIImage(named: "EmoticonBigTipsLeft")?.resizableImage()
        let midImage = UIImage(named: "EmoticonBigTipsMiddle")
        let rightImage = UIImage(named: "EmoticonBigTipsRight")?.resizableImage()
        
        let height: CGFloat = 155
        let width: CGFloat = 140
        
        let size = CGSize(width: width, height: height)
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        
        let leftWidth: CGFloat = (width - 30)/2
        
        leftImage?.draw(in: CGRect(x: 0, y: 0, width: leftWidth, height: height))
        midImage?.draw(in: CGRect(x: leftWidth, y: 0, width: 30, height: height))
        rightImage?.draw(in: CGRect(x: leftWidth+30, y: 0, width: leftWidth, height: height))
        
        let resultImg = UIGraphicsGetImageFromCurrentImageContext()
        
        return resultImg
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension UIImage {
    
    func resizableImage() -> UIImage {
        let edge = UIEdgeInsets(top: size.height*0.45, left: size.width*0.45, bottom: size.height*0.45, right: size.width*0.45)
        let image = self.resizableImage(withCapInsets: edge, resizingMode: .stretch)
        return image
    }
    
}
