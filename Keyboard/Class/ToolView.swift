//
//  ToolView.swift
//  Keyboard
//
//  Created by chenwei on 2017/7/20.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import UIKit

enum ToolViewStatus {
    case none
    case text
    case audio
    case emoticon
    case more
}

private let kItemSpacing: CGFloat = 3
private let kTextViewPadding: CGFloat = 6

/// 输入框按钮
class ToolView: UIView {

    // MARK: 属性
    var contentText: String? {
        didSet {
            inputTextView.text = contentText
        }
    }
    
    var showsKeyboard: Bool = false {
        didSet {
            if showsKeyboard {
                inputTextView.becomeFirstResponder()
            } else {
                inputTextView.resignFirstResponder()
            }
        }
    }
    
    var status: ToolViewStatus = .none
    
    /// 输入框
    lazy var inputTextView: UITextView = {
        let inputTextView = UITextView(frame:CGRect.zero)
        inputTextView.delegate = self
        return inputTextView
    }()
    
    /// 表情按钮
    lazy var emoticonButton: UIButton = {
        let emoticonButton = UIButton(type: .custom)
        emoticonButton.autoresizingMask = [.flexibleTopMargin]
        emoticonButton.setNormalImage(self.kEmojiImage, highlighted:self.kEmojiImageHL)
        
        return emoticonButton
    }()
    
    /// 文字和录音切换
    lazy var voiceButton: UIButton =  {
        let voiceButton = UIButton(type: .custom)
        voiceButton.autoresizingMask = [.flexibleTopMargin]
        
        voiceButton.setNormalImage(self.kVoiceImage, highlighted:self.kVoiceImageHL)
        return voiceButton
    }()
    
    ///更多按钮
    lazy var moreButton: UIButton = {
        let moreButton = UIButton(type: .custom)
        moreButton.autoresizingMask = [.flexibleTopMargin]
        moreButton.setNormalImage(self.kMoreImage, highlighted:self.kMoreImageHL)
        return moreButton
    }()
    
    /// 录音按钮
    lazy var recordButton: RecordButton = {
        let recordButton = RecordButton(frame: CGRect.zero)
        return recordButton
    }()
    
    //按钮的图片
    var kVoiceImage:UIImage = UIImage(named: "Chat_toolbar_voice")!
    var kVoiceImageHL:UIImage = UIImage(named: "Chat_toolbar_voice_HL")!
    var kEmojiImage:UIImage = UIImage(named: "Chat_toolbar_emotion")!
    var kEmojiImageHL:UIImage = UIImage(named: "Chat_toolbar_emotion_HL")!
    
    //图片名称待修改
    var kMoreImage:UIImage = UIImage(named: "Chat_toolbar_more")!
    var kMoreImageHL:UIImage = UIImage(named: "Chat_toolbar_more_HL")!
    
    var kKeyboardImage:UIImage = UIImage(named: "Chat_toolbar_keyboard")!
    var kKeyboardImageHL:UIImage = UIImage(named: "Chat_toolbar_keyboard_HL")!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateStatus(_ status: ToolViewStatus) {
        
        if status == .text || status == .more {
            
            self.recordButton.isHidden = true
            self.inputTextView.isHidden = false
            updateVoiceButtonImage(true)
            updateEmoticonButtonImage(true)

        } else if (status == .audio) {
            self.recordButton.isHidden = false
            self.inputTextView.isHidden = true
            
            updateVoiceButtonImage(false)
            updateEmoticonButtonImage(true)
        } else if (status == .emoticon) {
            
            self.recordButton.isHidden = true
            self.inputTextView.isHidden = false
            updateVoiceButtonImage(true)
            updateEmoticonButtonImage(true)
        }
        
        
    }
    
    
    func updateVoiceButtonImage(_ selected: Bool) {
        self.voiceButton.setImage(selected ? kVoiceImage:kKeyboardImage, for: .normal)
        self.voiceButton.setImage(selected ? kVoiceImageHL:kKeyboardImageHL, for: .highlighted)
    }
    
    func updateEmoticonButtonImage(_ selected: Bool) {
        self.emoticonButton.setImage(selected ? kEmojiImage:kKeyboardImage, for: .normal)
        self.emoticonButton.setImage(selected ? kEmojiImageHL:kKeyboardImageHL, for: .highlighted)
    }

}



extension ToolView : UITextViewDelegate {
    
    
    
}




