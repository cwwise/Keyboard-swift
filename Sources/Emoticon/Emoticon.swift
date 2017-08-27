//
//  Emoticon.swift
//  Keyboard
//
//  Created by chenwei on 2017/3/26.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import UIKit

public enum EmoticonType: Int {
    case image
    case expression     // 图片
}

public class Emoticon: NSObject {
    
    /// 表情类型
    var type: EmoticonType
    
    var id: String?
    /// 文字
    var title: String?
    /// 图片路径
    var png: String?
    
    var gif: String?
    
    // 大图
    var originalUrl: URL?
    // 小图
    var thumbUrl: URL?
    
    convenience init(title: String, png: String) {
        self.init(title: title, png: png, type: .image)
    }
    
    convenience init(express title: String, png: String, gif: String? = nil) {
        self.init(title: title, png: png, gif: gif, type: .expression)
    }
    
    private init(title: String? = nil,
                 png: String? = nil,
                 code: String? = nil,
                 gif: String? = nil,
                 type: EmoticonType) {
        self.title = title
        self.png = png
        self.type = type
    }
    
    public override var description: String {
        return self.title ?? "无title"
    }
    
}




