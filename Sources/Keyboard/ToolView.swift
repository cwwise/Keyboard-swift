//
//  ToolView.swift
//  Keyboard
//
//  Created by chenwei on 2017/7/20.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import UIKit

public enum ToolViewStatus {
    case none
    case keyboard
    case audio
    case emoticon
    case more
}

private let kItemSpacing: CGFloat = 3
private let kTextViewPadding: CGFloat = 6

public protocol ToolViewDelegate: class {
    // 高度变化
    func toolView(_ toolView: ToolView, heightChange height: CGFloat)
    // 状态变化
    func toolView(_ toolView: ToolView, statusChange status: ToolViewStatus)
}

/// 输入框按钮
public class ToolView: UIView {

    public weak var delegate: ToolViewDelegate?
    // MARK: 属性
    public var contentText: String? {
        didSet {
            inputTextView.text = contentText
        }
    }
    
    var showsKeyboard: Bool = false
    
    var status: ToolViewStatus = .none {
        didSet {
            updateStatus(status)
        }
    }
    
    /// 输入框
    lazy var inputTextView: InputTextView = {
        let inputTextView = InputTextView(frame: CGRect.zero)
        inputTextView.delegate = self
        return inputTextView
    }()
    
    /// 表情按钮
    lazy var emoticonButton: UIButton = {
        let emoticonButton = UIButton(type: .custom)
        emoticonButton.autoresizingMask = [.flexibleTopMargin]
        emoticonButton.addTarget(self, action: #selector(handelEmotionClick(_:)), for: .touchUpInside)
        emoticonButton.setNormalImage(self.kEmojiImage, highlighted:self.kEmojiImageHL)
        return emoticonButton
    }()
    
    /// 文字和录音切换
    lazy var voiceButton: UIButton = {
        let voiceButton = UIButton(type: .custom)
        voiceButton.autoresizingMask = [.flexibleTopMargin]
        voiceButton.addTarget(self, action: #selector(handelVoiceClick(_:)), for: .touchUpInside)
        voiceButton.setNormalImage(self.kVoiceImage, highlighted:self.kVoiceImageHL)
        return voiceButton
    }()
    
    ///更多按钮
    lazy var moreButton: UIButton = {
        let moreButton = UIButton(type: .custom)
        moreButton.autoresizingMask = [.flexibleTopMargin]
        moreButton.addTarget(self, action: #selector(handelMoreClick(_:)), for: .touchUpInside)
        moreButton.setNormalImage(self.kMoreImage, highlighted:self.kMoreImageHL)
        return moreButton
    }()
    
    /// 录音按钮
    lazy var recordButton: RecordButton = {
        let recordButton = RecordButton()
        return recordButton
    }()
    
    //按钮的图片
    var kVoiceImage: UIImage? = UIImage(named: "chat_toolbar_voice")
    var kVoiceImageHL: UIImage? = UIImage(named: "chat_toolbar_voice_HL")
    
    var kEmojiImage: UIImage? = UIImage(named: "chat_toolbar_emotion")
    var kEmojiImageHL: UIImage? = UIImage(named: "chat_toolbar_emotion_HL")
    
    var kMoreImage: UIImage? = UIImage(named: "chat_toolbar_more")
    var kMoreImageHL: UIImage? = UIImage(named: "chat_toolbar_more_HL")
    
    var kKeyboardImage: UIImage? = UIImage(named: "chat_toolbar_keyboard")
    var kKeyboardImageHL: UIImage? = UIImage(named: "chat_toolbar_keyboard_HL")
    
    var allowVoice: Bool = true
    var allowFaceView: Bool = true
    var allowMoreView: Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func setupUI() {
        
        self.autoresizingMask = [UIViewAutoresizing.flexibleWidth,UIViewAutoresizing.flexibleTopMargin]
        self.backgroundColor = UIColor(hex: "#E4EBF0")
        
        addSubview(self.voiceButton)
        addSubview(self.emoticonButton)
        addSubview(self.moreButton)
        addSubview(self.recordButton)
        addSubview(self.inputTextView)
        
        // 分割线
        let line = UIView()
        line.backgroundColor = UIColor(hex: "#e9e9e9")
        line.frame = CGRect(x: 0, y: self.frame.height-1, width: self.frame.width, height: 1.0/UIScreen.main.scale)
        addSubview(line)
        
        let toolBarHeight = self.height
        
        let kItem: CGFloat = 42
        let buttonSize = CGSize(width: kItem, height: 49)
        
        if self.allowVoice {
            let origin = CGPoint(x: 0, y: toolBarHeight-buttonSize.height)
            voiceButton.frame = CGRect(origin: origin, size: buttonSize)
        } else {
            voiceButton.frame = CGRect.zero
        }
        
        if self.allowMoreView {
            let origin = CGPoint(x: self.bounds.width-buttonSize.width, y: toolBarHeight-buttonSize.height)
            moreButton.frame = CGRect(origin: origin, size: buttonSize)
        } else {
            moreButton.frame = CGRect.zero
        }
        
        if self.allowFaceView {
            let origin = CGPoint(x: self.bounds.width-buttonSize.width*2, y: toolBarHeight-buttonSize.height)
            emoticonButton.frame = CGRect(origin: origin, size: buttonSize)
        } else {
            emoticonButton.frame = CGRect.zero
        }
        
        var textViewX = voiceButton.right
        var textViewWidth = emoticonButton.left - voiceButton.right
        
        if textViewX == 0 {
            textViewX = 8
            textViewWidth -= textViewX
        }
        
        let height: CGFloat = 36
        inputTextView.frame = CGRect(x: textViewX, y: (49 - height)/2.0,
                                     width: textViewWidth, height: height)
        recordButton.frame = inputTextView.frame
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    
    @objc func handelVoiceClick(_ sender: UIButton) {
        if status == .audio {
            status = .keyboard
        } else {
            status = .audio
        }
    }
    
    @objc func handelEmotionClick(_ sender: UIButton) {
        if status == .emoticon {
            status = .keyboard
        } else {
            status = .emoticon
        }
    }
    
    @objc func handelMoreClick(_ sender: UIButton) {
        if status == .more {
            status = .keyboard
        } else {
            status = .more
        }
    }
    
    func updateStatus(_ status: ToolViewStatus) {
        
        if status == .keyboard {
            
            self.recordButton.isHidden = true
            self.inputTextView.isHidden = false
            updateVoiceButtonImage(true)
            updateEmoticonButtonImage(true)
            updateMoreButtonImage(true)

        }
        else if (status == .audio) {
            self.recordButton.isHidden = false
            self.inputTextView.isHidden = true
            
            updateVoiceButtonImage(false)
            updateMoreButtonImage(true)
            updateEmoticonButtonImage(true)
        }
        else if (status == .more) {
         
            self.recordButton.isHidden = true
            self.inputTextView.isHidden = false
            updateVoiceButtonImage(true)
            updateMoreButtonImage(false)
            updateEmoticonButtonImage(true)
        }
        else if (status == .emoticon) {
            
            self.recordButton.isHidden = true
            self.inputTextView.isHidden = false
            updateVoiceButtonImage(true)
            updateMoreButtonImage(true)
            updateEmoticonButtonImage(false)
        }
        
        delegate?.toolView(self, statusChange: status)
        
        print(status)
    }
    
    
    func updateVoiceButtonImage(_ selected: Bool) {
        self.voiceButton.setImage(selected ? kVoiceImage:kKeyboardImage, for: .normal)
        self.voiceButton.setImage(selected ? kVoiceImageHL:kKeyboardImageHL, for: .highlighted)
    }
    
    func updateEmoticonButtonImage(_ selected: Bool) {
        self.emoticonButton.setImage(selected ? kEmojiImage:kKeyboardImage, for: .normal)
        self.emoticonButton.setImage(selected ? kEmojiImageHL:kKeyboardImageHL, for: .highlighted)
    }
    
    func updateMoreButtonImage(_ selected: Bool) {
        self.moreButton.setImage(selected ? kMoreImage:kKeyboardImage, for: .normal)
        self.moreButton.setImage(selected ? kMoreImageHL:kKeyboardImageHL, for: .highlighted)
    }

}



extension ToolView : UITextViewDelegate {
    
    // 开始编辑设置为键盘模式
    public func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if status != .keyboard {
           status = .keyboard
        }
        return true
    }
    
    
    
}




