//
//  Emoticon.swift
//  Keyboard
//
//  Created by chenwei on 2017/3/26.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import UIKit

public enum EmoticonFormat {
    case image  // png jpg
    case gif
}

public class Emoticon: NSObject {
    
    /// 唯一id
    var id: String
    ///
    var type: EmoticonType
    /// 表情格式
    var format: EmoticonFormat = .image
    /// 标题
    var title: String?
    ///
    var size: CGSize = CGSize.zero
    // 原图（本地路径 或者 网络路径）
    var originalUrl: URL?
    // 小图
    var thumbUrl: URL?
    
    //
    convenience init(id: String, title: String, path: URL) {
        self.init(id: id, title: title, originalUrl: path, type: .normal)
    }
    
    private init(id: String,
                 title: String? = nil,
                 originalUrl: URL? = nil,
                 type: EmoticonType) {
        self.id = id
        self.originalUrl = originalUrl
        self.title = title
        self.type = type
    }
    
    public override var description: String {
        return self.title ?? "无title"
    }
    
}





