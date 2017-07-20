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
    /// 文字
    var chs: String?
    /// 图片路径
    var png: String?
    
    var gif: String?

    ///表情图片的路径
    var code: String?

    convenience init(code: String) {
        self.init(code: code, type: .emoji)
    }
    
    convenience init(chs: String, png: String) {
        self.init(chs: chs, png: png, type: .image)
    }
    
    convenience init(express chs: String, png: String, gif: String) {
        self.init(chs: chs, png: png, gif: gif, type: .expression)
    }
    
    private init(chs: String? = nil,
                 png: String? = nil,
                 code: String? = nil,
                 gif: String? = nil,
                 type: EmoticonType) {
        self.chs = chs
        self.png = png
        self.type = type
        self.code = code
    }
    
}
