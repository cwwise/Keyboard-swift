//
//  Keyboard.swift
//  Keyboard
//
//  Created by chenwei on 2017/7/20.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import UIKit

/// 点击事件
public protocol KeyboardDelegate {
    
    
    
}

public enum KeyboardType {
    case normal
    case comment
}

let kInputViewHeight: CGFloat = 216
let kToolViewHeight: CGFloat = 49

public class Keyboard: UIView {
    // 类型
    public var type: KeyboardType = .normal
    // 状态
    public var status: ToolViewStatus = .none
    
    var keyBoardFrameTop: CGFloat = 0
    // 屏蔽模态视图中 收到其他界面的键盘通知
    var close: Bool = false
    
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
    
    func endInputing() {
        refreshStatus(.none)
        if self.toolView.showsKeyboard {
            self.toolView.showsKeyboard = false
        } else {
            UIView.animate(withDuration: 0.25) {
                self.top = self.superview!.height - kToolViewHeight
            }
        }
    }
    
    override public func didMoveToWindow() {
        setup()
    }
    
    func setup() {
        
        self.addSubview(toolView)
        self.addSubview(emoticonInputView)
        self.addSubview(moreInputView)

        registerKeyboard()
        refreshStatus(.keyboard)
    }
    
    func registerKeyboard() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillChangeFrame(_:)),
                                               name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        
        
    }

    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func keyboardWillChangeFrame(_ notification: Notification) {
        
        guard let userInfo = notification.userInfo,
            let endFrameValue = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue,
            let beginFrameValue = userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue,
            let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber,
            let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber else {
                return
        }
        
        let options = UIViewAnimationOptions(rawValue: (curve.uintValue << 16))
        let durationTime = duration.doubleValue
        let beginFrame = beginFrameValue.cgRectValue
        let endFrame = endFrameValue.cgRectValue

        print(beginFrame)
        print(endFrame)

        UIView.animate(withDuration: durationTime,
                       delay: 0, options: options,
                       animations: {
                      
                        
                        
                        
                        
        }) { (finished) in
            
            
        }
        
        
        self.keyBoardFrameTop = endFrameValue.cgRectValue.minY
    }
    
    @objc func keyboardWillShowFrame(_ notification: Notification) {
        
        let userInfo = notification.userInfo!
        let endFrameValue = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue
       // let beginFrameValue = userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue
      //  print(endFrameValue)

        UIView.animate(withDuration: 0.25) {
            self.top = endFrameValue.cgRectValue.minY - kToolViewHeight
        }
    }
    
    @objc func keyboardWillHideFrame(_ notification: Notification) {
        // 收到键盘消失
        let userInfo = notification.userInfo!
        let endFrameValue = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue
       // print(endFrameValue)

        // 判断情况 如果键盘模式和语音 则下落
        if self.status == .keyboard || self.status == .audio {
            
            UIView.animate(withDuration: 0.25) {
                self.top = endFrameValue.cgRectValue.minY - kToolViewHeight
            }
            
        }
        // 如果是表情和更多则保持高度
        else {
            
            
            
        }
        
        
        
    }
    
    
    func refreshStatus(_ status: ToolViewStatus) {
  
        
        self.status = status
    }
    
    // MARK: Action
    @objc func handelVoiceClick(_ sender: UIButton) {
        
    }
    
    @objc func handelEmotionClick(_ sender: UIButton) {
        
        if self.status != .emoticon {
            
            self.bringSubview(toFront: emoticonInputView)
            moreInputView.alpha = 0
            emoticonInputView.alpha = 1
            UIView.animate(withDuration: 0.25, animations: {
                self.emoticonInputView.top = kToolViewHeight
            })
            
            if self.toolView.showsKeyboard {
                self.status = .emoticon
                self.toolView.showsKeyboard = false
            } else {
                self.refreshStatus(.emoticon)
            }
            
        } else {
            self.status = .keyboard
            self.toolView.showsKeyboard = true
        }
        
    }
    
    @objc func handelMoreClick(_ sender: UIButton) {
        
        if self.status != .more {
            
            self.bringSubview(toFront: moreInputView)
            moreInputView.alpha = 1
            emoticonInputView.alpha = 0

            UIView.animate(withDuration: 0.25, animations: {
                self.moreInputView.top = kToolViewHeight
            })
            
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
    
}

// MARK: text部分
extension Keyboard {
    
    func onTextDelete() {
        
    }
    
    
    
}


extension Keyboard: ToolViewDelegate {
    
    public func toolView(_ toolView: ToolView, heightChange height: CGFloat) {
        
    }
    
    public func toolView(_ toolView: ToolView, statusChange status: ToolViewStatus) {
    
        // 显示更多键盘
        if status == .more {
            
            
        }
        
        
        
        
        
    }
    
    public func textViewShouldBeginEditing() {
        self.status = .keyboard
        UIView.animate(withDuration: 0.25, animations: {
            self.emoticonInputView.alpha = 0
            self.moreInputView.alpha = 0

        }) { (finshed) in
            self.moreInputView.top = kInputViewHeight
            self.emoticonInputView.top = kInputViewHeight
        }

    }
}


// MARK: - EmoticonInputViewDelegate
extension Keyboard: EmoticonInputViewDelegate {
    public func emoticonInputView(_ inputView: EmoticonInputView, didSelect emoticon: Emoticon) {
        
    }
    
    public func didPressDelete(_ inputView: EmoticonInputView) {
        
    }
    
    public func didPressSend(_ inputView: EmoticonInputView) {
        
    }    
}

// MARK: - MoreInputViewDelegate
extension Keyboard: MoreInputViewDelegate {
    
    func moreInputView(_ inputView: MoreInputView, didSelect item: MoreItem) {
        
        
    }
    
}
