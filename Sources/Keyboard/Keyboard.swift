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

private let kInputViewHeight: CGFloat = 216
private let kToolViewHeight: CGFloat = 49

class Keyboard: UIView {
    
    var type: KeyboardType = .normal

    var status: ToolViewStatus = .none
    
    var keyBoardFrameTop: CGFloat = 0
    
    //MARK: 属性
    lazy var toolView: ToolView = {
        let frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: kToolViewHeight)
        let toolView = ToolView(frame: frame)
        toolView.delegate = self
        return toolView
    }()
    
    lazy var emoticonInputView: EmoticonInputView = {
        let frame = CGRect(x: 0, y: kToolViewHeight, width: self.bounds.width, height: kInputViewHeight)
        let inputView = EmoticonInputView(frame: frame)
        inputView.delegate = self
        return inputView
    }()
    
    lazy var moreInputView: MoreInputView = {
        let frame = CGRect(x: 0, y: self.bounds.height, width: self.bounds.width, height: kInputViewHeight)
        let inputView = MoreInputView(frame: frame)
        inputView.delegate = self
        return inputView
    }()
    
    /// @用户的数组
    var atCache: [String] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func didMoveToWindow() {
        setup()
    }
    
    func setup() {
        
        self.addSubview(toolView)
        self.addSubview(emoticonInputView)
        self.addSubview(moreInputView)

        toolView.emoticonButton.addTarget(self, action: #selector(handelEmotionClick(_:)), for: .touchUpInside)
        toolView.voiceButton.addTarget(self, action: #selector(handelVoiceClick(_:)), for: .touchUpInside)
        toolView.moreButton.addTarget(self, action: #selector(handelMoreClick(_:)), for: .touchUpInside)        
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillChangeFrame(_:)),
                                               name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
     
        refreshStatus(.text)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func keyboardWillChangeFrame(_ notification: Notification) {
        
        if !(self.window != nil) {
            return
        }
        
        let userInfo = notification.userInfo!
        let endFrameValue = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue
        let beginFrameValue = userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue

        self.keyBoardFrameTop = endFrameValue.cgRectValue.minY
        willShowKeyboard(from: beginFrameValue.cgRectValue, to: endFrameValue.cgRectValue)
    }
    
    func willShowKeyboard(from beginFrame: CGRect, to endFrame: CGRect) {
        
        self.refreshStatus(self.status)
        
    }

    
    func refreshStatus(_ status: ToolViewStatus) {
        
        self.status = status
        self.toolView.updateStatus(status)
        
        switch status {
        case .text, .audio:
            if self.toolView.showsKeyboard {
                self.top = self.keyBoardFrameTop - self.toolView.height
            } else {
                self.top = self.superview!.height - self.toolView.height
            }
            
        case .more, .emoticon:
            self.bottom = self.superview!.height
        default: 
            
            break
            
        }
        
    }
    
    // MARK: Action
    func handelVoiceClick(_ sender: UIButton) {
        
    }
    
    func handelEmotionClick(_ sender: UIButton) {
        
        if self.status != .emoticon {
            
            self.bringSubview(toFront: emoticonInputView)
            emoticonInputView.isHidden = false
            
            if self.toolView.showsKeyboard {
                self.status = .emoticon
                self.toolView.showsKeyboard = false
            } else {
                self.refreshStatus(.emoticon)
            }
            
        } else {
            self.status = .text
            self.toolView.showsKeyboard = true
        }
        
    }
    
    func handelMoreClick(_ sender: UIButton) {
        
        if self.status != .more {
            
            self.bringSubview(toFront: moreInputView)
            moreInputView.isHidden = false
            
            if self.toolView.showsKeyboard {
                self.status = .more
                self.toolView.showsKeyboard = false
            } else {
                self.refreshStatus(.more)
            }
            
        } else {
            self.status = .more
            self.toolView.showsKeyboard = true
        }

        
    }
    
    override func layoutSubviews() {
        superview?.layoutSubviews()
        //moreInputView.top = toolView.bottom
        //emoticonInputView.top = toolView.bottom
    }
    
}

// MARK: text部分
extension Keyboard {
    
    func onTextDelete() {
        
    }
    
    
    
}


extension Keyboard: ToolViewDelegate {
    
    func textViewShouldBeginEditing() {
        self.status = .text
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
