//
//  ViewController.swift
//  Keyboard
//
//  Created by chenwei on 2017/7/20.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var tapGesture: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // testMore()
        //testKeyboard()
        testEmoticon()
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(test))
        //self.view.addGestureRecognizer(tapGesture)
    }
    
    func test() {
        self.view.endEditing(true)
    }
    
    func testKeyboard() {
        
        let frame = CGRect(x: 0, y: self.view.height-49, width: self.view.width, height: 216+49)
        let keyboard = Keyboard(frame: frame)
        keyboard.backgroundColor = UIColor.orange
        self.view.addSubview(keyboard)
        
        var groupList = [EmoticonGroup]()
        if let qqemoticon = EmoticonGroup(identifier: "com.qq.classic") {
            groupList.append(qqemoticon)
        }
        
        if let qqemoticon = EmoticonGroup(identifier: "com.qq.classic") {
            qqemoticon.emoticons.reverse()
            groupList.append(qqemoticon)
        }
        keyboard.emoticonInputView.loadData(groupList)
        
        
        //创建数据
        let titleArray = ["照片", "拍摄", "小视频", "视频聊天", "红包", "转账",
                          "位置", "收藏", "个人名片", "语音输入", "卡券"]
        let imageArray = ["moreKB_image", "moreKB_video", "moreKB_sight", "moreKB_video_call",
                          "moreKB_wallet", "moreKB_pay", "moreKB_location", "moreKB_favorite",
                          "moreKB_friendcard", "moreKB_voice", "moreKB_wallet"]
        
        var chatMoreKeyboardData: [MoreItem] = []
        for i in 0..<titleArray.count {
            let type = MoreItemType(rawValue: i)!
            let item = MoreItem(title: titleArray[i], imagePath: imageArray[i], type: type)
            chatMoreKeyboardData.append(item)
        }
        keyboard.moreInputView.loadData(chatMoreKeyboardData)

    }
    
    func testEmoticon() {
        
        var groupList = [EmoticonGroup]()
        if let qqemoticon = EmoticonGroup(identifier: "com.qq.classic") {
            groupList.append(qqemoticon)
        }
        
        if let qqemoticon = EmoticonGroup(identifier: "com.qq.classic") {
            qqemoticon.emoticons.reverse()
            groupList.append(qqemoticon)
        }
        
        if let _ = EmoticonGroup(identifier: "cn.com.a-li") {
           // groupList.append(liemoticon)
        }
        
        
        let height: CGFloat = 216
        let frame = CGRect(x: 0, y: self.view.height - height, width: self.view.width, height: height)
        let inputView = EmoticonInputView(frame: frame)
        self.view.addSubview(inputView)
        
        inputView.loadData(groupList)
    }
    
    func testMore() {

        //创建数据
        let titleArray = ["照片", "拍摄", "小视频", "视频聊天", "红包", "转账",
                          "位置", "收藏", "个人名片", "语音输入", "卡券"]
        let imageArray = ["moreKB_image", "moreKB_video", "moreKB_sight", "moreKB_video_call",
                          "moreKB_wallet", "moreKB_pay", "moreKB_location", "moreKB_favorite",
                          "moreKB_friendcard", "moreKB_voice", "moreKB_wallet"]
        
        var chatMoreKeyboardData: [MoreItem] = []
        for i in 0..<titleArray.count {
            let type = MoreItemType(rawValue: i)!
            let item = MoreItem(title: titleArray[i], imagePath: imageArray[i], type: type)
            chatMoreKeyboardData.append(item)
        }
        
        
        let height: CGFloat = 216
        let frame = CGRect(x: 0, y: self.view.height - 2*height - 10, width: self.view.width, height: height)
        let inputView = MoreInputView(frame: frame)
        inputView.backgroundColor = UIColor.orange
        self.view.addSubview(inputView)
        
        inputView.loadData(chatMoreKeyboardData)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

