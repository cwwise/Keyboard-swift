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
    
    var gif: String?    
    // 原图（本地路径 或者 网络路径）
    var originalUrl: URL?
    // 小图
    var thumbUrl: URL?
    
    // 小表情 
    convenience init(title: String, path: URL) {
        self.init(title: title, originalUrl: path, type: .image)
    }
    
    convenience init(express title: String, originalUrl: URL, gif: String? = nil) {
        self.init(title: title, originalUrl: originalUrl, gif: gif, type: .expression)
    }
    
    private init(title: String? = nil,
                 originalUrl: URL? = nil,
                 gif: String? = nil,
                 type: EmoticonType) {
        self.originalUrl = originalUrl
        self.title = title
        self.type = type
    }
    
    public override var description: String {
        return self.title ?? "无title"
    }
    
}





