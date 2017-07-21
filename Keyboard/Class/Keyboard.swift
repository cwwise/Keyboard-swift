//
//  Keyboard.swift
//  Keyboard
//
//  Created by chenwei on 2017/7/20.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import UIKit

/// 点击事件
protocol KeyboardDelegate {
    
    
    
}

enum KeyboardType {
    case normal
    case comment
}

class Keyboard: UIView {
    
    //MARK: 属性
    var toolView: ToolView = ToolView()
    
    var type: KeyboardType = .normal
    
    lazy var emoticonInputView: EmoticonInputView = {
        let inputView = EmoticonInputView()
        inputView.delegate = self
        return inputView
    }()
    
    lazy var moreInputView: MoreInputView = {
        let inputView = MoreInputView()
        inputView.delegate = self
        return inputView
    }()
    
    
    
    
    

}


// MARK: - EmoticonInputViewDelegate
extension Keyboard: EmoticonInputViewDelegate {
    
    func emoticonInputView(_ inputView: EmoticonInputView, didSelect emoticon: Emoticon) {
        
    }
    
}

// MARK: - MoreInputViewDelegate
extension Keyboard: MoreInputViewDelegate {
    
    func moreInputView(_ inputView: MoreInputView, didSelect item: MoreItem) {
        
        
    }
    
}
