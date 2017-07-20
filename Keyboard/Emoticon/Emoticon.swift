//
//  Emoticon.swift
//  Keyboard
//
//  Created by chenwei on 2017/3/26.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import UIKit

public enum EmoticonType: Int {
    case favorite
    case emoji
    case image
    case expression     // 图片
}

class Emoticon: NSObject {
    
    /// 表情类型
    var type: EmoticonType
    
    var id: String?
    /// 文字
    var title: String?
    /// 图片路径
    var png: String?
    
    var gif: String?

    // 表情emotion
    var code: String?

    convenience init(code: String) {
        self.init(code: code, type: .emoji)
    }
    
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
        self.code = code
    }
    
}





