//
//  EmojiGroup.swift
//  Keyboard
//
//  Created by chenwei on 2017/3/26.
//  Copyright © 2017年 cwcoder. All rights reserved.
//

import UIKit
import SwiftyJSON

enum EmoticonGroupType {
    case normal
    case big
}

class EmoticonGroup: NSObject {
    
    // id
    var id: String
    // 表情组 名称
    var name: String
    // 标签类型
    var type: EmoticonGroupType = .normal
    /// 表情图像路径
    var icon: String
    /// 表情数组
    var emoticons: [Emoticon] = []
    
    var count: Int {
        return emoticons.count
    }
    
    init(id: String,
         name: String = "",
         icon: String,
         emoticons: [Emoticon]) {
        self.id = id
        self.name = name
        self.icon = icon
        self.emoticons = emoticons
    }
    
}

extension EmoticonGroup {
    
    convenience init?(identifier : String) {
        let bundle = Bundle.main
        guard let path = bundle.path(forResource: "emoticons.bundle/\(identifier)/Info", ofType: "plist"),
        let dict = NSDictionary(contentsOfFile: path) else {
            return nil
        }
       
        let json = JSON(dict)
        let emoticonsArray = json["emoticons"].arrayValue
        
        let directory = URL(fileURLWithPath: path).deletingLastPathComponent().path
        
        let id = json["id"].stringValue
        let icon = json["image"].stringValue
        var emoticons: [Emoticon] = []
        
        for item in emoticonsArray {
            let id = item["id"].stringValue
            let title = item["title"].stringValue
            let _ = item["type"].stringValue
            let image = directory + "/" + item["image"].stringValue
            
            let emoticon = Emoticon(title: title, png: image)
            emoticon.id = id
            emoticons.append(emoticon)
        }
        
        self.init(id: id, icon: directory + "/" + icon, emoticons: emoticons)
            
     
    }
    
}
