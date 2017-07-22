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
    
    var type: KeyboardType = .normal

    //MARK: 属性
    var toolView: ToolView = ToolView()
    
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
    
    /// @用户的数组
    var atCache: [String] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
    
        toolView.emoticonButton.addTarget(self, action: #selector(handelEmotionClick(_:)), for: .touchUpInside)
        toolView.voiceButton.addTarget(self, action: #selector(handelVoiceClick(_:)), for: .touchUpInside)
        toolView.moreButton.addTarget(self, action: #selector(handelMoreClick(_:)), for: .touchUpInside)        
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillChangeFrame(_:)),
                                               name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func keyboardWillChangeFrame(_ notification: Notification) {
        
    }
    
    // MARK: Action
    func handelVoiceClick(_ sender: UIButton) {
        
    }
    
    func handelEmotionClick(_ sender: UIButton) {
        
    }
    
    func handelMoreClick(_ sender: UIButton) {
        
    }
    
}

// MARK: text部分
extension Keyboard {
    
    func onTextDelete() {
        
    }
    
}


// MARK: - EmoticonInputViewDelegate
extension Keyboard: EmoticonInputViewDelegate {
    
    func emoticonInputView(_ inputView: EmoticonInputView, didSelect emoticon: Emoticon?) {
        
    }
    
    
    func didPressSend() {
        
    }
    
}

// MARK: - MoreInputViewDelegate
extension Keyboard: MoreInputViewDelegate {
    
    func moreInputView(_ inputView: MoreInputView, didSelect item: MoreItem) {
        
        
    }
    
}
